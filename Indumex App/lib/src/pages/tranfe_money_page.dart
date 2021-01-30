
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(TranfMoney());

class TranfMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tranferencia Money',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Deposito a Moneycard'),
        ),
        body: Center(
          child: Container(
               margin: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                _datosDeCuentas(),
                SizedBox(
                  height: 10,
                ),
                _enviarMoney(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //contenedor DATOS DE CUENTAS iX
  Widget _datosDeCuentas() {
    return Card(
      elevation: 24.0,
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Text("Recuerde ......................................ll"),
                ],
              )
            ]),
      ),
    );
  }

  //ENVIAR TRANFE A MONEY

  Widget _enviarMoney(BuildContext context) {
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
                  _urlredirect();
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

  _urlredirect() async {
    const url = 'https://auth.redpagos.com.uy/isam/sps/auth';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'No pueden cargar el sitio : $url';
    }
  }

// //

//   Widget _btnRealizarMoneyPage(BuildContext context) {
//     return Container(
//         //margin: EdgeInsets.all(05),
//         child: Center(
//       child: Row(
//         children: <Widget>[
//           Icon(Icons.person_pin_circle, size: 20, color: Colors.white),
//           InkWell(
//             child: Text(
//               'Redireccion al sitio Moneycard !',
//               style: new TextStyle(color: Colors.white, fontSize: 15.0),
//             ),
//             onTap: () async {
//               if (await canLaunch(_urlredirect())) {
//                 await launch(_urlredirect());
//               }
//             },
//           ),
//         ],
//         mainAxisAlignment: MainAxisAlignment.center,
//       ),
//     ));
//   }
}
