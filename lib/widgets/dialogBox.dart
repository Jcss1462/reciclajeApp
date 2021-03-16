import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {

  //recibo el parametro
  final String titulo;
  final String cuerpo;
  DialogBox(this.titulo,this.cuerpo);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {

  //capturo el valor pasado por el parametro
  String _titulo;
  String _cuerpo;
  @override
  void initState() {
    super.initState();
    //obtengo el id del usuario
    _titulo = this.widget.titulo;
    _cuerpo = this.widget.cuerpo;
  }
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _titulo,
        style: TextStyle(
          color: Color.fromRGBO(46, 99, 238, 1),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      content: Text(
          _cuerpo),
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
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
