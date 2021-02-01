import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/simular_bloc.dart';
import 'package:formvalidation/src/providers/SimularOp_provider.dart';
import 'package:formvalidation/src/providers/login_provider.dart';

void main() => runApp(CobrarTranf());

class CobrarTranf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocUsuario = LoginProvider.of(context);
    final blocSimular = SimularOpProvider.of(context);

    return MaterialApp(
      title: 'Cobro de transferencias',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cobrar transferencias'),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                // Text('Cobrar transferencias'),
                _infoDepo(context),
                SizedBox(height: 15.0),
                _formasDePago(blocUsuario, blocSimular),

                SizedBox(height: 15.0),
                _cobrar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }


//info depo
  Widget _infoDepo(BuildContext context) {
    return Card(
      elevation: 24.0,
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Divider(
                color: Colors.white,
              ),
              Text('IMPORTE A COBRAR',
                  style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              Divider(color: Colors.black),
              Text("44454949 DOLAR"),
            ]),
      ),
    );
  }

//Tres botones



  //contenedor botones tipo op
  Widget _formasDePago(LoginBloc blUsuario, SimularBloc blSimular) {
    return Card(
      elevation: 20.0,
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("SELECCIONE UN MEDIO DE COBRO"),
              Divider(color: Colors.white),
              Text('FORMAS DE PAGO',
                  style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              Divider(color: Colors.white),
              SizedBox(height: 10.0),
              Row(
                children: [
                  _crearBotonTipoLiquidacionReturarSuc(blUsuario),
                  Divider(color: Colors.white),
                  _crearBotonTipoLiquidacionMoney(blUsuario),
                  Divider(color: Colors.white),
                  _crearBotonTipoLiquidacionTransf(blUsuario),
                ],
              )
            ]),
      ),
    );
  }

  //botones tipos de liquidacion
  //liquidacion por medio de moneycard

  Widget _crearBotonTipoLiquidacionMoney(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Flexible(
          flex: 4,
          child: Container(
            child: Column(
              children: <Widget>[
                MaterialButton(
                    shape: CircleBorder(
                        side: BorderSide(
                            width: 1,
                            color: Colors.orange[600],
                            style: BorderStyle.solid)),
                    elevation: 24.0,
                    color: Colors.orange[500],
                    textColor: Colors.white,
                    child: Icon(
                      Icons.credit_card,
                      size: 25.0,
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => null()),
                      // );
                    }),
                Text('Moneycard'),
              ],
            ),

            width: 100,
            height: 100,
            alignment: Alignment.center,

            //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          ),
        );
      },
    );
  }
  //liquidacion por surcursal

  Widget _crearBotonTipoLiquidacionReturarSuc(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Flexible(
          flex: 4,
          child: Container(
            child: Column(
              children: <Widget>[
                MaterialButton(
                    shape: CircleBorder(
                        side: BorderSide(
                            width: 1,
                            color: Colors.orange[600],
                            style: BorderStyle.solid)),
                    elevation: 24.0,
                    color: Colors.orange[500],
                    textColor: Colors.white,
                    child: Icon(
                      Icons.map,
                      size: 25.0,
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => null()),
                      // );
                    }),
                Text('Prescencial'),
              ],
            ),

            width: 100,
            height: 100,
            alignment: Alignment.center,

            //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          ),
        );
      },
    );
  }

//liquidacion por transferencia brou
  Widget _crearBotonTipoLiquidacionTransf(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Flexible(
          flex: 4,
          child: Container(
            child: Column(
              children: <Widget>[
                MaterialButton(
                    shape: CircleBorder(
                        side: BorderSide(
                            width: 1,
                            color: Colors.orange[600],
                            style: BorderStyle.solid)),
                    elevation: 24.0,
                    color: Colors.orange[500],
                    textColor: Colors.white,
                    child: Icon(
                      Icons.food_bank_outlined,
                      size: 25.0,
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => null()),
                      // );
                    }),
                Text('Brou'),
              ],
            ),

            width: 100,
            height: 100,
            alignment: Alignment.center,

            //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          ),
        );
      },
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
