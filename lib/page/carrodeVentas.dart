import 'package:flutter/material.dart';
import 'package:reciclaje_app/widgets/NavBar.dart';

import '../core/constants.dart';

class CarrodeVentas extends StatefulWidget {
  CarrodeVentas({Key key}) : super(key: key);

  @override
  _CarrodeVentasState createState() => _CarrodeVentasState();
}

class _CarrodeVentasState extends State<CarrodeVentas> {
  final formKey = GlobalKey<FormState>();

  String tipodeResiduo;
  String estadodelResiduo;
  int peso;
  int total;
  int precioPapel = 1000;
  int precioCarton = 2000;
  int precioVidirio = 2500;

  String estado;

  final allChecked = CheckBoxModalCarro(title: "Al checked");
  List checkBoxList = [
    CheckBoxModalCarro(title: 'Mojado'),
    CheckBoxModalCarro(title: 'Molido'),
    CheckBoxModalCarro(title: 'Contaminado'),
    CheckBoxModalCarro(title: 'Hoja'),
    CheckBoxModalCarro(title: 'Pliegos')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Reciclador Oficial",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                //Formulario
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      top: 30.0, bottom: 30.0, left: 40, right: 40),
                  child: Column(
                    children: [
                      Text(
                        "Carro de Ventas",
                        style: TextStyle(
                            color: Color.fromRGBO(46, 99, 238, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            //Campos
                            Container(
                              height: 50,
                              //Tipo de residuo
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Tipor de Residuo",
                                  contentPadding: EdgeInsets.all(11),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                //Validacion
                                onSaved: (value) {
                                  tipodeResiduo = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "llenar el campo";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            //Cantidad del residuo
                            SizedBox(height: 15),
                            Container(
                              height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "ingrese el peso",
                                    contentPadding: EdgeInsets.all(11),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                          width: 0.5,
                                        ))),

                                //Validacion
                                onSaved: (value) {
                                  peso = int.parse(value);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "LLenar el campo";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            //Cantidad del residuo

                            SizedBox(height: 15),
                            new Column(
                              children: [
                                Text(
                                  "Estado del Residuo",
                                  style: TextStyle(
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                ...checkBoxList
                                    .map(
                                      (item) => CheckboxListTile(
                                        title: Text(
                                          item.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        value: item.value,
                                        onChanged: (val) {
                                          setState(() {
                                            item.value = val;
                                            if (val == true) {
                                              estadodelResiduo = item.title;
                                            }
                                          });
                                        },
                                      ),
                                    )
                                    .toList()
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      new Column(
                        children: [
                          Text(
                            "Total de Venta del Residuo",
                            style: TextStyle(
                                color: Color.fromRGBO(46, 99, 238, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      MaterialButton(
                        height: 50,
                        minWidth: 150,
                        color: Color.fromRGBO(46, 99, 238, 1),
                        textColor: Colors.white,
                        child: new Text(
                          "Añadir al Carro de Ventas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            debugPrint(this.tipodeResiduo);
                            debugPrint(this.estadodelResiduo);
                            print(peso);
                          }

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "Residuo Agregado",
                                style: TextStyle(
                                  color: Color.fromRGBO(46, 99, 238, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              content:
                                  Text("El Residuo se Agrego Exitosamente"),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CarrodeVentas()));
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckBoxModalCarro {
  String title;
  String descripcion;
  bool value;
  CheckBoxModalCarro({@required this.title, this.value = false});
}
