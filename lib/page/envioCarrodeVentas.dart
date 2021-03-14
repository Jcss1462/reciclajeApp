import 'package:flutter/material.dart';
import 'package:reciclaje_app/page/index.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class EnvioCarrodeVentas extends StatefulWidget {
  EnvioCarrodeVentas(this.peso, this.total, this.tipodeResiduo);

  final int peso;
  final int total;
  final String tipodeResiduo;

  @override
  _EnvioCarrodeVentasState createState() => _EnvioCarrodeVentasState();
}

class _EnvioCarrodeVentasState extends State<EnvioCarrodeVentas> {
  final formKey = GlobalKey<FormState>();

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
            child: new Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Carro de Ventas",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    new Card(
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 3.5,
                        padding: EdgeInsets.only(
                            top: 30.0, bottom: 30.0, left: 40, right: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              spreadRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "Tipo de Residuo",
                                style: TextStyle(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.tipodeResiduo,
                                style: TextStyle(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Peso en Kilogramos",
                                style: TextStyle(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.peso.toString(),
                                style: TextStyle(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Total del Residuo",
                                style: TextStyle(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.total.toString(),
                                style: TextStyle(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    size: 50,
                                  ),
                                  onPressed: null),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    size: 50,
                                  ),
                                  onPressed: null),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    MaterialButton(
                      height: 50,
                      minWidth: 150,
                      color: Color.fromRGBO(46, 99, 238, 1),
                      textColor: Colors.white,
                      child: new Text(
                        "Enviar Sollicitud de Compra",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          debugPrint(widget.tipodeResiduo);
                          print(widget.peso.toString());
                          print(widget.total.toString());
                        }

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Residuo Enviada",
                              style: TextStyle(
                                color: Color.fromRGBO(46, 99, 238, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            content: Text("La solicitud se envio exitosamente"),
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
                                              InicioReciclador()));
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
        ],
      ),
    );
  }
}
