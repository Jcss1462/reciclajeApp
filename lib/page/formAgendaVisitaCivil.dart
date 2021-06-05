import 'package:flutter/material.dart';
import 'package:reciclaje_app/page/listaVisitasAgendadas.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/navbarCiudadanoCivil.dart';

class FormAgendaVisitaCivil extends StatefulWidget {
  const FormAgendaVisitaCivil({Key key}) : super(key: key);
  @override
  _FormAgendaVisitaCivilState createState() => _FormAgendaVisitaCivilState();
}

class _FormAgendaVisitaCivilState extends State<FormAgendaVisitaCivil> {
  Preferences preferencias = new Preferences();
  String _email;
  DateTime dateTime;
  DateTime hora;
  TimeOfDay timeOfDay;
  final fromKey = GlobalKey<FormState>();

  Future<String> getEmail() async {
    return await preferencias.obtenerEmail().then((value) async {
      _email = value;
      return _email;
    });
  }

  @override
  void initState() {
    dateTime = DateTime.now();
    timeOfDay = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCiudadanoCivil(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Agendar Visita",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
            icon:
                Icon(Icons.perm_contact_calendar_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListaVistasAgendadas()));
            },
          ),
        ],
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
          FutureBuilder(
            future: getEmail(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.15,
                        height: MediaQuery.of(context).size.height / 1.8,
                        constraints: BoxConstraints(
                          minWidth: 160,
                          minHeight: 160,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 30.0, left: 40, right: 40),
                            child: Column(
                              children: [
                                Text(
                                  "Agendar Visita",
                                  style: TextStyle(
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Ingresar la Fecha a Agendar: ",
                                      style: TextStyle(
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText:
                                            "Fecha: ${dateTime.day}-${dateTime.month}-${dateTime.year}",
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                        ),
                                      ),
                                      onTap: _pickDate,
                                      onSaved: (value) {
                                        dateTime = DateTime.parse(value);
                                        if (value != null) {
                                          dateTime = dateTime;
                                        }
                                      },
                                      onChanged: (value) {
                                        dateTime = DateTime.parse(value);
                                        if (value != null) {
                                          dateTime = dateTime;
                                        }
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Llenar el campo";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Ingresar la Hora a Agendar: ",
                                      style: TextStyle(
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText:
                                            "Hora: ${timeOfDay.hour}:${timeOfDay.minute} ",
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                        ),
                                      ),
                                      onTap: _pickTime,
                                      onSaved: (value) {
                                        timeOfDay = TimeOfDay.fromDateTime(
                                            DateTime.parse(value));
                                        if (value != null) {
                                          timeOfDay = timeOfDay;
                                        }
                                      },
                                      onChanged: (value) {
                                        timeOfDay = TimeOfDay.fromDateTime(
                                            DateTime.parse(value));
                                        if (value != null) {
                                          timeOfDay = timeOfDay;
                                        }
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Llenar el campo";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                MaterialButton(
                                  height: 50,
                                  minWidth: 150,
                                  color: Color.fromRGBO(46, 99, 238, 1),
                                  textColor: Colors.white,
                                  child: new Text(
                                    "Agendar Visita",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (fromKey.currentState.validate()) {
                                      fromKey.currentState.save();
                                      print(dateTime);
                                      print(timeOfDay);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            "Agendar Visita",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  46, 99, 238, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          content: Text(
                                            "Se Agrego Exitosamente la Visita",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                'Ok',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      46, 99, 238, 1),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ListaVistasAgendadas()));
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                "Cambiar Agenda",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      46, 99, 238, 1),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              onPressed: () {
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FormAgendaVisitaCivil());
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              }
            },
          )
        ],
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10),
        initialDate: dateTime);
    if (date != null) {
      setState(() {
        dateTime = date;
      });
    }
  }

  _pickTime() async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (time != null) {
      setState(() {
        timeOfDay = time;
      });
    }
  }
}
