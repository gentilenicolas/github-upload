import 'package:flutter/material.dart';
import 'package:formvalidation/src/pages/envioComprobante_page.dart';



class TranfBrou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tranfe Brou',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Transferencia por Brou'),
        ),
        body: Center(
          child: Container(
           // child: envioComprobante(context),
          ),
        ),
      ),
    );
  }

  Widget envioComprobante(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      child: Center(
        child: Column(
          children: <Widget>[
           Container(
              //largo boton
              height: 70.0,
              //ancho
              width:
                  400,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnvioComprobante(),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orangeAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 400.0, minHeight: 100.0),
                    alignment: Alignment.center,
                    child: Text(
                      "ENVIO DE INFO",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  
  }
}
