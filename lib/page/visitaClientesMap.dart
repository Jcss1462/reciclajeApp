import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reciclaje_app/blocs/application_bloc.dart';
import 'package:reciclaje_app/data/datasources/recoleccionDonacion_datasource.dart';
import 'package:reciclaje_app/data/model/carrodeDonacionList.dart';
import 'package:reciclaje_app/data/model/place.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class VisitaClientesMap extends StatefulWidget {
  const VisitaClientesMap({Key key}) : super(key: key);
  @override
  _VisitaClientesMapState createState() => _VisitaClientesMapState();
}

class _VisitaClientesMapState extends State<VisitaClientesMap> {
  Completer<GoogleMapController> _mapController = Completer();
  Preferences preferencias = new Preferences();
  String _email;
  GoogleMapController googleMapController;
  List<Coordinates> coordinates = [];
  Map<MarkerId, Marker> markers = {};

  final formKey = GlobalKey<FormState>();
  RecoleccionDonacionDataSourceImpl recoleccionDonacionDataSourceImpl =
      new RecoleccionDonacionDataSourceImpl();
  CarrodeDonacionList solicitudes = new CarrodeDonacionList();

  @override
  void initState() {
    super.initState();
  }

  Future<String> getEmail() async {
    return await preferencias.obtenerEmail().then((value) async {
      _email = value;
      return _email;
    });
  }

  Future<CarrodeDonacionList> getListSolicitudes() async {
    return await this
        .recoleccionDonacionDataSourceImpl
        .carrosDisponiblesNoAplicados();
  }

  getCoordenadas(String address, String id) async {
    var coordenadas = await Geocoder.local.findAddressesFromQuery(address);
    var first = coordenadas.first;
    coordinates.add(first.coordinates);
    var marrkerVal = id;
    final MarkerId markerId = MarkerId(marrkerVal);
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(first.coordinates.latitude, first.coordinates.longitude),
        icon: BitmapDescriptor.defaultMarker);
    setState(() {
      markers[markerId] = marker;
    });
    print(first.coordinates);
    print(coordinates);
    return marker;
  }

  @override
  Widget build(BuildContext context) {
    final applicationBolc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Visita A Clientes",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: (applicationBolc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new Stack(
              children: <Widget>[
                new Center(
                  child: FutureBuilder(
                    future: getEmail(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return FutureBuilder(
                              future: getListSolicitudes(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return CircularProgressIndicator();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      this.solicitudes = snapshot.data;
                                      return Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Card(
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2.5,
                                                  constraints: BoxConstraints(
                                                    minWidth: 150,
                                                    minHeight: 100,
                                                  ),
                                                  child: GoogleMap(
                                                    mapType: MapType.normal,
                                                    myLocationEnabled: true,
                                                    initialCameraPosition:
                                                        CameraPosition(
                                                            target: LatLng(
                                                                applicationBolc
                                                                    .currentLocation
                                                                    .latitude,
                                                                applicationBolc
                                                                    .currentLocation
                                                                    .longitude),
                                                            zoom: 10),
                                                    onMapCreated:
                                                        (GoogleMapController
                                                            controller) {
                                                      _mapController
                                                          .complete(controller);
                                                    },
                                                    //markers: Set<Marker>.of(applicationBolc.markers),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Expanded(
                                                  child: ListView.builder(
                                                      itemCount: solicitudes
                                                          .solicitudes.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                          child: ListTile(
                                                              title: TextButton(
                                                            child: Text(
                                                                solicitudes
                                                                    .solicitudes[
                                                                        index]
                                                                    .emailCivil),
                                                            onPressed: () {
                                                              getCoordenadas(
                                                                  solicitudes
                                                                      .solicitudes[
                                                                          index]
                                                                      .direccionRecoleccion,
                                                                  solicitudes
                                                                      .solicitudes[
                                                                          index]
                                                                      .emailCivil);
                                                            },
                                                          )),
                                                        );
                                                      }))
                                            ],
                                          )
                                        ],
                                      );
                                    }
                                }
                              },
                            );
                          }
                      }
                    },
                  ),
                )
              ],
            ),
    );
  }

  Future<void> gotoPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 14)));
  }
}
