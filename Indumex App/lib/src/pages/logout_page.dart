import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/utils/estilos.dart' as estilos;
import 'dart:io' show Platform, exit;

class LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);
    //final _prefs = new PreferenciasUsuario();
    //  print (_prefs.nombre);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[400],
        actions: [],
      ),
      //fondo gradiente
      body: Container(
        child: Column(
          children: <Widget>[
            _salir(bloc),
          ],
        ),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [estilos.gradientStart, estilos.gradientEnd],
              begin: const FractionalOffset(0.5, 0.0),
              end: const FractionalOffset(0.0, 0.5),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
    );
  }

  Widget _salir(LoginBloc bloc) {
    return Card(
      child: Column(children: <Widget>[
        ListTile(
          title: Text('              Esta seguro que desea salir?'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                FlatButton(
                  child: Text('No'),
                  onPressed: () {},
                ),
              ],
            ),
            VerticalDivider(),
            Row(
              children: [
                FloatingActionButton(onPressed: () {
                  if (Platform.isAndroid) {
                    //exit para android
                    SystemNavigator.pop();
                    bloc.dispose();
                  } else if (Platform.isIOS) {
                    bloc.dispose();
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      exit(0); //exit para ios
                    });
                  }
                }),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
