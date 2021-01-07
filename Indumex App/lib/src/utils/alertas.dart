import 'package:flutter/material.dart';


// alert con ok 
void mostrarAlerta(BuildContext context, String mensaje) async {
 await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Informacion incorrecta'),
          content: Text (mensaje),
          actions: <Widget>[
            FlatButton( child: Text ('ok', style: TextStyle(color:Colors.red)),
                       shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: ()=>Navigator.of(context).pop),
          ],
        );
      });
}
//alert sin ok
void mostrarAlerta1(BuildContext context, String mensaje) async {
    await showDialog(
      context:  context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text('Algo no esta bien!'),
        actions: [
          new FlatButton(
            child: new Text(mensaje,style: TextStyle(color: Colors.red)),
             shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
             onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );

  }


