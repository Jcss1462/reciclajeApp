import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/carroVenta_datasource.dart';
import 'package:reciclaje_app/data/model/tipoResiduo.dart';
import 'package:reciclaje_app/data/model/tipoResiduoList.dart';
import 'package:reciclaje_app/page/carroDeVentas.dart';
import 'package:reciclaje_app/widgets/NavBar.dart';

class VentasForm extends StatefulWidget {
  VentasForm({Key key}) : super(key: key);

  @override
  _VentasFormState createState() => _VentasFormState();
}

class _VentasFormState extends State<VentasForm> {
  final formKey = GlobalKey<FormState>();

  String estadodelResiduo;
  int peso;
  int quantity;
  int total;
  int precioPapel = 1000;
  int precioCarton = 2000;
  int precioVidirio = 2500;

  var estados = [];

  CarroVentasDataSourceImpl carroVentasDataSourceImpl =
      new CarroVentasDataSourceImpl();

  List<CheckBoxModalCarro> estadoList = [];

  List<DropdownMenuItem<TipoResiduoList>> dropListaresiduo;

  TipoResiduoList selectResiduo;

  List<DropdownMenuItem<TipoResiduoList>> getResiduo(List listaresiduos) {
    List<DropdownMenuItem<TipoResiduoList>> items = [];
    for (TipoResiduo listResiduo in listaresiduos) {
      items.add(DropdownMenuItem(
        child: Text(
          listResiduo.tipo,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ),
      ));
    }

    return items;
  }

  TipoResiduoList listadeResiduos;
  Future<TipoResiduoList> getListObtenerTipoResiduo() async {
    return await this.carroVentasDataSourceImpl.obtenerTiposResiduos();
  }

  @override
  void initState() {
    estadoList.add(CheckBoxModalCarro(title: 'Mojado', value: false));
    estadoList.add(CheckBoxModalCarro(title: 'Molido', value: false));
    estadoList.add(CheckBoxModalCarro(title: 'Contaminado', value: false));
    estadoList.add(CheckBoxModalCarro(title: 'Hoja', value: false));
    estadoList.add(CheckBoxModalCarro(title: 'Pliegos', value: false));

    super.initState();
  }

  getItems() {
    estadoList.forEach((element) {
      if (element.value == true) {
        estados.add(element.title);
      }
    });

    print(estados);
    estados.clear();
  }

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
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CarroDeVentas("jcss1462@gmail.com")));
              })
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
          new Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.15,
              height: MediaQuery.of(context).size.height / 1.15,
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
                  ),
                ],
              ),
              child: Center(
                //Formulario
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      top: 5.0, bottom: 30.0, left: 40, right: 40),
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
                                height: 70,
                                //Tipo de residuo
                                child: FutureBuilder(
                                    future: getListObtenerTipoResiduo(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      switch (snapshot.connectionState) {
                                        //mientras espera
                                        case ConnectionState.waiting:
                                          return CircularProgressIndicator();
                                        default:
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            this.listadeResiduos =
                                                snapshot.data;
                                            dropListaresiduo = getResiduo(
                                                listadeResiduos.tipoResiduos);
                                            selectResiduo =
                                                dropListaresiduo[0].value;
                                            return Card(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    100,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    50,
                                                constraints: BoxConstraints(
                                                  minWidth: 185,
                                                  minHeight: 185,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 2.0,
                                                    bottom: 2.0,
                                                    left: 2,
                                                    right: 2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.25),
                                                      spreadRadius: 2,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: DropdownButton<
                                                    TipoResiduoList>(
                                                  hint: Text(
                                                    "Tipo de Residuo",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            46, 99, 238, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  elevation: 5,
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          46, 99, 238, 1),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15),
                                                  underline: Container(
                                                    height: 2,
                                                    color: Color.fromRGBO(
                                                        46, 99, 238, 1),
                                                  ),
                                                  value: selectResiduo,
                                                  items: dropListaresiduo,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectResiduo = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                      }
                                    })),

                            //Cantidad del residuo
                            SizedBox(height: 15),
                            new Container(
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "ingrese el peso",
                                      contentPadding: EdgeInsets.all(11),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(46, 99, 238, 1),
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
                                  }),
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
                                ...estadoList
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
                            print(peso);
                            print(selectResiduo.tipoResiduos);
                            print(dropListaresiduo);
                            getItems();
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
                                            builder: (context) => CarroDeVentas(
                                                "jcss1462@gmail.com")));
                                  },
                                ),
                                TextButton(
                                    child: Text(
                                      'Vender Mas',
                                      style: TextStyle(
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      MaterialPageRoute(
                                          builder: (context) => VentasForm());
                                    }),
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
  bool value;
  CheckBoxModalCarro({@required this.title, this.value = false});
}
