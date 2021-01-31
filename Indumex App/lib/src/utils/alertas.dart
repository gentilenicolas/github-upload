import 'package:flutter/material.dart';

// alert con ok
void mostrarAlerta(BuildContext context, String mensaje) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Algo no está bien'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                child: Text('ok', style: TextStyle(color: Colors.red)),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () =>
                    Navigator.pop(context)), //Navigator.of(context).pop),
          ],
        );
      });
}

//alert sin ok
void aviso(BuildContext context, String mensaje) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Text(mensaje),
      actions: [
        new FlatButton(
          //  child: new Text(   mensaje, 
          //    style: TextStyle(color: Colors.red)),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
