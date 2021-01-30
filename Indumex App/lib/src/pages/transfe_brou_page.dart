import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

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
            margin: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                _contenedorPersona(context),
                SizedBox(
                  height: 10,
                ),
                _enviarPersona(context),
                SizedBox(
                  height: 10,
                ),
                _contenedorEmpresa(context),
                SizedBox(
                  height: 10,
                ),
                _enviarEmpresa(context),
                SizedBox(
                  height: 30,
                ),
                _cobrar(context),
              ],
            ),

            // child: envioComprobante(context),
          ),
        ),
      ),
    );
  }

  //contenedor DATOS DE CUENTAS iX
  Widget _contenedorPersona(BuildContext context) {
    return Card(
      elevation: 24.0,
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Text("TRANSFERENCIA DE PERSONA"),
                ],
              )
            ]),
      ),
    );
  }

  Widget _contenedorEmpresa(BuildContext context) {
    return Card(
      elevation: 24.0,
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Text("TRANSFERENCIA CON EMPRESA"),
                ],
              )
            ]),
      ),
    );
  }

  //ENVIAR TRANFE A PERSONA

  Widget _enviarPersona(BuildContext context) {
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
                  _urlredirectPersona();
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
                      "ENVIAR",
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

  _urlredirectPersona() async {
    const url = 'https://ebanking.brou.com.uy/frontend/loginStep1';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'No pueden cargar el sitio : $url';
    }
  }

  //ENVIAR TRANFE A PERSONA

  Widget _enviarEmpresa(BuildContext context) {
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
                  _urlredirectEmpesa();
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
                      "ENVIAR",
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

  _urlredirectEmpesa() async {
    const url =
        'https://www.canales.brou.com.uy/empresas/seguridad/loginFlow.htm?execution=e2s1';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'No pueden cargar el sitio : $url';
    }
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
                  _urlredirectPersona();
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
                      "COBRAR",
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
