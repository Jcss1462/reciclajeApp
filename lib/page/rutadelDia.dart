import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reciclaje_app/blocs/application_bloc.dart';
import 'package:reciclaje_app/data/datasources/recoleccionDonacion_datasource.dart';
import 'package:reciclaje_app/data/model/aplicacionRecoleccion.dart';
import 'package:reciclaje_app/data/model/carrodeDonacionList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class RutadelDia extends StatefulWidget {
  const RutadelDia({Key key}) : super(key: key);
  @override
  _RutadelDiaState createState() => _RutadelDiaState();
}

class _RutadelDiaState extends State<RutadelDia> {
  Preferences preferencias = new Preferences();
  String _email;
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = {};
  List<Coordinates> coordinates = [];
  GoogleMap googleMap;

  final Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  final formKey = GlobalKey<FormState>();
  RecoleccionDonacionDataSourceImpl recoleccionDonacionDataSourceImpl =
      new RecoleccionDonacionDataSourceImpl();

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

  Future<List<Coordinates>> getCoordenadas(
      CarrodeDonacionList solicitudes) async {
    for (int i = 0; i < solicitudes.solicitudes.length; i++) {
      var coordenadas = await Geocoder.local.findAddressesFromQuery(
          solicitudes.solicitudes[i].direccionRecoleccion);
      var direcion = coordenadas.first;
      coordinates.add(direcion.coordinates);
      //print(direcion.coordinates);
      print(coordinates);
    }
    return coordinates;
  }

  Future<void> initMarker(
      List<Coordinates> listCoodinates, CarrodeDonacionList listaCarros) async {
    print("Iniciando creacion de markers");
    for (var i = 0; i < listCoodinates.length; i++) {
      final MarkerId markerId = MarkerId(markers.length.toString());
      LatLng markerPos =
          LatLng(listCoodinates[i].latitude, listCoodinates[i].longitude);
      final Marker marker = Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: markerId,
          position: markerPos,
          onTap: () {
            onCardInfo(listaCarros);
          });
      markers[markerId] = marker;
    }
    print("Creacion de markers terminada");
  }

  Future<dynamic> getMakerData() async {
    print("acceddiendo al back");
    return await recoleccionDonacionDataSourceImpl
        .recicladorCarrosAsignados(_email)
        .then((listaCarros) async {
      print("Datos del back obtenidos");
      if (listaCarros.solicitudes.length != 0) {
        print("Iniciando conversiona coordenadas");
        await getCoordenadas(listaCarros).then((listaCoordenadas) async {
          print("Conversion terminada");
          await initMarker(listaCoordenadas, listaCarros);
        }).onError((error, stackTrace) {
          showDialog(
            context: context,
            builder: (context) =>
                DialogBox("ERROR", "Problemas convirtiendo las coordenadas"),
          );
        });
      }
    }).onError((error, stackTrace) {
      showDialog(
        context: context,
        builder: (context) => DialogBox("ERROR",
            "Problema obteniendo la lista del carros deisponibles del back"),
      );
    });
  }

  Future<void> onCardInfo(CarrodeDonacionList listacarros) async {
    for (int i = 0; i < listacarros.solicitudes.length; i++) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20, right: 20),
              height: MediaQuery.of(context).size.height / 3,
              constraints: BoxConstraints(
                minWidth: 150,
                minHeight: 230,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).canvasColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          "Usuario:",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromRGBO(46, 99, 238, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(children: [
                      Text(
                        listacarros.solicitudes[i].emailCivil,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(46, 99, 238, 1),
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Dirección: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(46, 99, 238, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            listacarros.solicitudes[i].direccionRecoleccion,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(46, 99, 238, 1),
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    MaterialButton(
                      height: 50,
                      minWidth: 250,
                      color: Color.fromRGBO(46, 99, 238, 1),
                      textColor: Colors.white,
                      child: new Text(
                        "Agendar Visita",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      onPressed: () async {
                        print("email solicitante: " + _email);
                        print("carrito de donacion: " +
                            listacarros.solicitudes[i].idcarrodonacion
                                .toString());

                        AplicacionRecoleccion aplicacionRecoleccion =
                            new AplicacionRecoleccion(
                                listacarros.solicitudes[i].idcarrodonacion
                                    .toInt(),
                                _email);
                        this
                            .recoleccionDonacionDataSourceImpl
                            .aplicacionaRecolectar(aplicacionRecoleccion)
                            .then((value) {
                          showDialog(
                            context: context,
                            builder: (context) => DialogBox(
                                "Aplicación exitosa",
                                "Esperar la aceptación del usuario civil"),
                          ).then((value) {
                            setState(() {});
                          });
                        }).onError((error, stackTrace) {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                DialogBox("Error al Aplicar", error.toString()),
                          );
                        });
                      },
                    )
                  ],
                ),
              ),
            );
          });
    }
  }

  Future<void> setPolylines() async {
    for (int i = 0; i < coordinates.length; i++) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "",
          null,
          PointLatLng(coordinates[i].latitude, coordinates[i].longitude));
    }
  }

  @override
  Widget build(BuildContext context) {
    final applicationBolc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Ruta del Dia",
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
                new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/fondo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                              future: getMakerData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return CircularProgressIndicator();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Stack(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: GoogleMap(
                                              markers: Set<Marker>.of(
                                                  markers.values),
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
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                controller = controller;
                                              },
                                            ),
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
}
