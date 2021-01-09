import 'dart:async';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/utils/alertas.dart';
import 'package:formvalidation/src/utils/widgets.dart' as master;
import 'package:formvalidation/src/utils/juego_pruebas.dart' as jp;
import 'package:formvalidation/src/utils/estilos.dart' as estilos;

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
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: <Widget>[
            //_contenidoRealizarOp(context , bloc)/*
            _tiposDeCambio(bloc),
            SizedBox(height: 15.0),
            Text('Resumen Operacion', style: TextStyle(color: Colors.blue[400],fontSize: 20.0)),
            SizedBox(height: 10.0),
            _resumenOp(bloc),
              SizedBox(height: 10.0),
            _btnRealizarOp(context),
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
         bottomNavigationBar: _bottomNavigationBar(),
      endDrawer: master.menuDrawer(context, bloc),
    );
  }

//contenedor info tipos de cambio (card)
  Widget _tiposDeCambio(LoginBloc bloc) {
    final usr = bloc.usuario;
    return Card(
      child: Column(children: <Widget>[
        ListTile(
          title: Text('Moneda :' + usr.nombreCompleto),
          subtitle: Text(
              'para abajo los distintos tipos de cambio ahora puse tres propiedades cualquier a, tengo que traer el nuevo objeto de ale'),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Text("Tc pizarra : PITO PITO"),
                Text("Tc cliente : PITO PITO"),
                Text("Tc moneycard : PITO PITO"),
               
              ],
            )
          ],
        )
      ]),
    );
  }

//contenedor resumen de operacion
  Widget _resumenOp(LoginBloc bloc) {
    final usr = bloc.usuario;
    return Card(
      child: Column(children: <Widget>[
        ListTile(
          title: Text('Resumen de operacion'),
          subtitle: Text('resumen'),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Entrega :"),
                Text("Tipo de cambio :"),
                Text("Recibio :")
              ],
            )
          ],
        ),
      ]),
    );
  }

  Widget _btnRealizarOp(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
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

  _contenidoRealizarOp(BuildContext context, LoginBloc bloc) {
    // final prefs = new PreferenciasUsuario();
    // await prefs.initPrefs();
    final usr = bloc.usuario;

    if ( usr.id != null) {
      return ListView(
        padding: EdgeInsets.all(25),
        children: <Widget>[
          SizedBox(height: 30.0),
          _tiposDeCambio(bloc),
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

  Widget _crearBotonTipoLiquidacionMoney(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Deposito a Moneycard'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.orange[500],
            textColor: Colors.white,
            //obener los valores de las cajas de texto
            onPressed:
                snapshot.hasData ? () => _realizarOp(bloc, context) : null);
      },
    );
  }

  Widget _crearBotonTipoLiquidacionTransf(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Transferencia bancaria'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.orange[500],
            textColor: Colors.white,
            //obener los valores de las cajas de texto
            onPressed:
                snapshot.hasData ? () => _realizarOp(bloc, context) : null);
      },
    );
  }

  Widget _crearBotonTipoLiquidacionReturarSuc(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Retirar por sucursal'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.orange[500],
            textColor: Colors.white,
            //obener los valores de las cajas de texto
            onPressed:
                snapshot.hasData ? () => _realizarOp(bloc, context) : null);
      },
    );
  }

//validarion usuario

  void _realizarOp(LoginBloc bloc, BuildContext context) {
    final user = bloc.usuario.id;

    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      mostrarAlerta(context, 'Usuario no encontrado');
    }
  }

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
