import 'dart:async';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/utils/alertas.dart';
import 'package:formvalidation/src/utils/widgets.dart' as master;

/*void main() async {
  final prefs = new PreferenciasLogin();

  await prefs.initPrefs();
  if (prefs.nombre != null) {
    runApp(RealizarOp());
  }

  //luego de que se autentica y esta todo ok deberia de mostrar a realizar operacion
}*/

class RealizarOp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);
    final size = MediaQuery.of(context).size;

    //final _prefs = new PreferenciasUsuario();
    //  print (_prefs.nombre);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[],
        title: Image(
          image: AssetImage('assets/images/indumex-logo.png'),
          width: 200,
        ),
      ),
      //fondo gradiente
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: <Widget>[
              //_contenidoRealizarOp(context , bloc)/*
              _tiposDeCambio(bloc, context),
              SizedBox(
                width: size.width * 0.10,
              ),
              Text('RESUMEN DE OPERACION',
                  style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              SizedBox(height: 10.0),
              _resumenOp(bloc),

              SizedBox(height: 10.0),
              Text('FORMAS DE PAGO',
                  style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              SizedBox(height: 10.0),
              _formasDePago(bloc),
              SizedBox(height: 10.0),
              _btnRealizarOp(context),
              Center(
                child: Row(
                  children: [
                    _crearBotonTipoLiquidacionReturarSuc(bloc),
                    _crearBotonTipoLiquidacionMoney(bloc),
                    _crearBotonTipoLiquidacionTransf(bloc)
                  ],
                ),
              ),
            ],
          ), /*
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [estilos.gradientStart, estilos.gradientEnd],
              begin: const FractionalOffset(0.5, 0.0),
              end: const FractionalOffset(0.0, 0.5),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),*/
        ),
      ),

      bottomNavigationBar: _bottomNavigationBar(),
      endDrawer: master.menuDrawer(context, bloc),
    );
  }

//validarion usuario

  UsuarioModel _usuarioValido(LoginBloc bloc, BuildContext context) {
    final usr = bloc.usuario;
    

    if (usr.id== null) {
      UsuarioModel usuario = new UsuarioModel();
      _tiposDeCambio(bloc, context);
      mostrarAlerta(context, 'Debe estar logueado para realizar la operacion');
      print("debe esar logueado");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      
     
    }
    return usr;
  }

 
//contenedor info tipos de cambio (card)
  Widget _tiposDeCambio(LoginBloc bloc, BuildContext context) {
    final usr = _usuarioValido(bloc, context);

    if (usr == null) {
      mostrarAlerta(context, "Debe loguearce para realizar esta accción");
      usr.nombreCompleto = "";
    }
    return Card(
      elevation: 24.0,
      child: Column(children: <Widget>[
        ListTile(
          title: Text('Moneda :' /*+ usr.nombreCompleto*/),
          subtitle: Text('para abajo los distintos tipos de cambio'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Tc pizarra : PITO PITO", textAlign: TextAlign.start),
                SizedBox(height: 5.0),
                Text("Tc cliente : PITO PITO"),
                SizedBox(height: 5.0),
                Text("Tc moneycard : PITO PITO"),
                SizedBox(height: 5.0),
              ],
            )
          ],
        )
      ]),
    );
  }

//contenedor resumen de operacion
  Widget _resumenOp(LoginBloc bloc) {
    return Card(
      elevation: 24.0,
      child: Column(children: <Widget>[
        ListTile(
          title: Text('Resumen de operacion'),
          subtitle: Text('resumen'),
        ),
        Column(
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 5.0),
                Text("Entrega : pito "),
                SizedBox(height: 5.0),
                Text("Tipo de cambio : mas pito "),
                SizedBox(height: 10.0),
                SizedBox(height: 5.0),
              ],
            )
          ],
        ),
      ]),
    );
  }

  //contenedor resumen de operacion
  Widget _formasDePago(LoginBloc bloc) {
    return Card(
      elevation: 24.0,
      child: Column(children: <Widget>[
        ListTile(
          title: Text('Resumen de operacion'),
          subtitle: Text('resumen'),
        ),
        Column(
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 5.0),
                Text("Entrega : pito "),
                VerticalDivider(),
                Text("Tipo de cambio : mas pito "),
                SizedBox(height: 10.0),
              ],
            )
          ],
        ),
      ]),
    );
  }

  Widget _btnRealizarOp(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RealizarOp(),
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

//
  _contenidoRealizarOp(BuildContext context, LoginBloc bloc) {
    // final prefs = new PreferenciasUsuario();
    // await prefs.initPrefs();
    final usr = bloc.usuario;

    if (usr.id != null) {
      return ListView(
        padding: EdgeInsets.all(25),
        children: <Widget>[
          SizedBox(height: 30.0),
          _tiposDeCambio(bloc, context),
          SizedBox(height: 30.0),
          _resumenOp(bloc),
        ],
      );
    } else {
      mostrarAlerta1(
          context, "Debe estar logueado para realizar una operación");
      return scheduleMicrotask(() => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage())));
    }

    //else return Container (child: Text('Debe de estar logueado para poder realizar operaciones'));
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
                    size: 20.0,
                  ),
                  onPressed: null,
                ),
                Text('Deposito Moneycard'),
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
                    Icons.store,
                    size: 20.0,
                  ),
                  onPressed: null,
                ),
                Text('Retirar por sucursal'),
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
                    Icons.comment_bank,
                    size: 20.0,
                  ),
                  onPressed: null,
                ),
                Text('Transferencia bancaria'),
              ],
            ),

            width: 100,
            height: 100,
            alignment: Alignment.center,

            //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          ),
        );

        // return Container(
        //   color: Colors.blue,
        //   width: 100,
        //   height: 80,
        //   alignment: Alignment.centerRight,
        //   //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        //   child: MaterialButton(
        //     shape: CircleBorder(
        //         side: BorderSide(
        //             width: 2,
        //             color: Colors.orange[600],
        //             style: BorderStyle.solid)),
        //     elevation: 0.0,
        //     color: Colors.orange[500],
        //     textColor: Colors.white,
        //     onPressed: null,
        //     child: Text('Transferencia Bancaria'),
        //   ),
        // );
      },
    );
  }

/*
 Function _habilitarBotonesTransaccion() {
    if (     ) {
      return null;
    } else {
      return () {
       
      };
    }
  }
*/

  // navigationBar
  Widget _bottomNavigationBar() {
    return Container(
      //alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.orange[50],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Algo',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Algo',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Login',
          ),
        ],
      ),
    );
  }
}
