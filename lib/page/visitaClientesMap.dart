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
    getMakerData();
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

  getCoordenadas(String address) async {
    var coordenadas = await Geocoder.local.findAddressesFromQuery(address);
    var first = coordenadas.first;
    coordinates.add(first.coordinates);
    print(first.coordinates);
    print(coordinates);
    return first.coordinates;
  }

  void initMarker(specify, specifyId) async {
    for (int i = 0; i < coordinates.length; i++) {
      var makerIdVal = specifyId;
      final MarkerId markerId = MarkerId(makerIdVal);
      final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(coordinates[i].latitude, coordinates[i].longitude));
      setState(() {
        markers[markerId] = marker;
      });
    }
  }

  getMakerData() async {
    var direccionConvert;
    recoleccionDonacionDataSourceImpl
        .carrosDisponiblesNoAplicados()
        .then((value) {
      if (value.solicitudes.isEmpty) {
        for (int i = 0; i < value.solicitudes.length; i++) {
          direccionConvert =
              getCoordenadas(solicitudes.solicitudes[i].direccionRecoleccion);
          coordinates.add(direccionConvert);
          initMarker(direccionConvert, solicitudes.solicitudes[i].emailCivil);
        }
      }
    });
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
                                              GoogleMap(
                                                markers: Set.of(markers.values),
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
