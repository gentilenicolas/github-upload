import 'package:flutter/material.dart';
 
void main() => runApp(TranfMoney());
 
class TranfMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tranfe Money',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Deposito a Moneycard'),
        ),
        body: Center(
          child: Container(
            child: Text('Depo a Money'),
          ),
        ),
      ),
    );
  }


  Widget _btnRealizarMoneyPage(BuildContext context) {
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
                 // https://auth.redpagos.com.uy/isam/sps/auth
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
                      "CONFIRMAR OPERACION",
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