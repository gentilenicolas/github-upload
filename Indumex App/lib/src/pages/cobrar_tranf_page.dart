import 'package:flutter/material.dart';

void main() => runApp(CobrarTranf());

class CobrarTranf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cobro de transferencias',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cobrar transferencias'),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Text('Cobrar transferencias'),
                _cobrar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cobrar(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(05),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              //largo boton
              height: 70.0,
              //ancho
              width: 400,
              child: RaisedButton(
                onPressed: () {
                  // _urlredirectPersona();
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
                      "CONFIRMAR",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
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
