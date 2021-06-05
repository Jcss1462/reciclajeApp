import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reciclaje_app/blocs/application_bloc.dart';
import 'package:reciclaje_app/data/datasources/recoleccionDonacion_datasource.dart';
import 'package:reciclaje_app/data/model/aplicacionRecoleccion.dart';
import 'package:reciclaje_app/data/model/carrodeDonacionList.dart';
import 'package:reciclaje_app/service/geolocator.dart';
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
  ApplicationBloc applicationBloc;

  final geoLocatorService = GeolacatorService();
  Position currentLocation;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  final formKey = GlobalKey<FormState>();
  RecoleccionDonacionDataSourceImpl recoleccionDonacionDataSourceImpl =
      new RecoleccionDonacionDataSourceImpl();

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    setCurrentLocation();
    super.initState();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
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
      //setPolylines(coordinates);
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
          await setPolylines(listaCoordenadas);
        }).onError((error, stackTrace) {
          showDialog(
            context: context,
            builder: (context) => DialogBox("ERROR",
                "Problemas convirtiendo las coordenadas \n" + error.toString()),
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
      String emailCivilSelect = listacarros.solicitudes[i].emailCivil;
      if (listacarros.solicitudes[i].emailCivil == emailCivilSelect) {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0, left: 20, right: 20),
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
                              builder: (context) => DialogBox(
                                  "Error al Aplicar", error.toString()),
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
  }

  Future<void> setPolylines(List<Coordinates> cordenadas) async {
    polylinePoints = PolylinePoints();
    for (int i = 0; i < cordenadas.length; i++) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "",
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(cordenadas[i].latitude, cordenadas[i].longitude),
      );
      PolylineResult result2 = await polylinePoints.getRouteBetweenCoordinates(
          "",
          PointLatLng(cordenadas[i].latitude, cordenadas[i].longitude),
          PointLatLng(cordenadas[i + 1].latitude, cordenadas[i + 1].longitude));
      if (result.points.isNotEmpty && result2.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        result2.points.forEach((PointLatLng point1) {
          polylineCoordinates.add(LatLng(point1.latitude, point1.longitude));
        });
      }
      PolylineId id = PolylineId('Id');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      );

      polylines[id] = polyline;
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
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout_outlined, color: Colors.white),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            title: Text(
                              "Cerrar Sesión",
                              style: TextStyle(
                                color: Color.fromRGBO(46, 99, 238, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            content: Text(
                              "Esta seguro que desea cerrar la sesión",
                            ),
                            actions: <Widget>[
                              TextButton(
                                  child: Text(
                                    'Ok',
                                    style: TextStyle(
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {
                                    //eliminamos todas las preferencias y re dirigimos a Login
                                    Preferences preferences = new Preferences();
                                    preferences
                                        .eliminarPreferencias()
                                        .then((value) {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    }).onError((error, stackTrace) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => DialogBox(
                                            "Error al cerrar sesión",
                                            error.toString()),
                                      );
                                    });
                                  }),
                              TextButton(
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ]));
              })
        ],
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
                                              polylines: Set<Polyline>.of(
                                                  polylines.values),
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
