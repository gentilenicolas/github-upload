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
}