import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            // _btnRealizarMoneyPage( context),
          ),
        ),
      ),
    );
  }

  Widget _btnRealizarMoneyPage(BuildContext context) {
    return Container(
        //margin: EdgeInsets.all(05),
        child: Center(
      child: Row(
        children: <Widget>[
          Icon(Icons.person_pin_circle, size: 20, color: Colors.white),
          InkWell(
            child: Text(
              'Redireccion al sitio Moneycard !',
              style: new TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            onTap: () async {
              if (await canLaunch(_urlredirect())) {
                await launch(_urlredirect());
              }
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    ));
  }

  _urlredirect() async {
    const url = 'https://auth.redpagos.com.uy/isam/sps/auth';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'No pueden cargar el sitio : $url';
    }
  }
}
