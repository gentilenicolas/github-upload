//import 'dart:js';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/utils/alertas.dart';
import 'package:formvalidation/src/utils/widgets.dart' as master;
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
        title: Text('Realizar Op'),
        backgroundColor: Colors.blueAccent[400],
        actions: [],
      ),
      //fondo gradiente
     body: Column(
        children: [
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [estilos.gradientStart, estilos.gradientEnd],
                  begin: const FractionalOffset(0.5, 0.0),
                  end: const FractionalOffset(0.0, 0.5),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          _contenidoRealizarOp(context, bloc),
        ],
      ),
      endDrawer: master.menuDrawer(context, bloc),
    );
  }

  Widget _card1() {
    return Card(
      child: Column(children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.phone,
            color: Colors.brown,
          ),
          title: Text('iiiiiiii'),
          subtitle: Text('kjljljljljllkñlklñklkjklsdlfkj'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                FlatButton(
                  child: Text('Boton1 '),
                  onPressed: () {},
                ),
              ],
            ),
            VerticalDivider(),
            Column(
              children: [
                FlatButton(
                  child: Text('Boton2 '),
                  onPressed: () {},
                ),
              ],
            )
          ],
        )
      ]),
    );
  }

  Widget _card2() {
    return Card(
      child: Column(children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.phone,
            color: Colors.brown,
          ),
          title: Text('uuuuuuuuuuu'),
          subtitle: Text('lklñjlkjasdlfkjklajdlkjadlfkj'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Boton1 '),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Boton2 '),
              onPressed: () {},
            )
          ],
        )
      ]),
    );
  }

  _contenidoRealizarOp(BuildContext context, LoginBloc bloc) {
    // final prefs = new PreferenciasUsuario();
    // await prefs.initPrefs();

    if (bloc.usuario != null) {
      return ListView(
        padding: EdgeInsets.all(25),
        children: <Widget>[
          _card1(),
          _card2(),
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
}
