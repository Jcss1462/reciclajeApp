import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/ofertas_datasource.dart';
import 'package:reciclaje_app/data/model/aplicantesOfertasList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbarCentrodeAcopio.dart';

class SolicitantesOfertas extends StatefulWidget {
  final int idOferta;
  SolicitantesOfertas(this.idOferta);

  @override
  _SolicitantesOfertasState createState() => _SolicitantesOfertasState();
}

class _SolicitantesOfertasState extends State<SolicitantesOfertas> {
  Preferences preferencias = new Preferences();
  int _idOferta;
  OfertasDatasourceImpl ofertasDatasourceImpl = new OfertasDatasourceImpl();
  AplicanteOfertasList aplicanteOfertasList = new AplicanteOfertasList();

  @override
  void initState() {
    super.initState();
    _idOferta = this.widget.idOferta;
    print("idOferta: " + _idOferta.toString());
  }

  Future<AplicanteOfertasList> gerListAplicanteOferta() async {
    return await this.ofertasDatasourceImpl.getAplicanteMyOferta(_idOferta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCentrodeAcopio(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Lista de Solicitantes",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
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
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/fondo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Center(
              child: FutureBuilder(
            future: gerListAplicanteOferta(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    this.aplicanteOfertasList = snapshot.data;
                    print("id ofert" + _idOferta.toString());
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    this.aplicanteOfertasList.aplicantes.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                          constraints: BoxConstraints(
                                            minWidth: 150,
                                            minHeight: 40,
                                          ),
                                          padding: EdgeInsets.only(
                                              top: 20.0,
                                              bottom: 20.0,
                                              left: 20,
                                              right: 20),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.25),
                                                  spreadRadius: 5,
                                                  offset: Offset(0, 3),
                                                ),
                                              ]),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Reciclador: ",
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              46, 99, 238, 1),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Text(
                                                        aplicanteOfertasList
                                                            .aplicantes[index]
                                                            .emailUsuario,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              46, 99, 238, 1),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              }
            },
          )),
        ],
      ),
    );
  }
}
