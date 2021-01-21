import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/utils/estilos.dart' as estilos;
import 'dart:io' show Platform, exit;

// https://api.flutter.dev/flutter/material/AlertDialog-class.html

Future<void> cerrarSesion(BuildContext context, LoginBloc bloc) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Esta seguro que quiere cerrar sesion?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Alerta alerta '),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No')),
          FlatButton(
            child: Text(' SI '),
            onPressed: () {
              if (Platform.isAndroid) {
                //exit para android
                SystemNavigator.pop();
                bloc.dispose();
              } else if (Platform.isIOS) {
                bloc.dispose();
                Future.delayed(const Duration(milliseconds: 1500), () {
                  exit(0); //exit para ios
                });
              }
            },
          ),
        ],
        elevation: 24.0,
      );
    },
  );
}

class LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);
    //final _prefs = new PreferenciasUsuario();
    //  print (_prefs.nombre);

    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.blueAccent[400],
        actions: [],
      ),
      //fondo gradiente
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: <Widget>[
//mostrarAlerta2( context,  mensaje),
             // _salir(bloc, context),
            ],
          ),
          // decoration: new BoxDecoration(
          //   gradient: new LinearGradient(
          //       colors: [estilos.gradientStart, estilos.gradientEnd],
          //       begin: const FractionalOffset(0.5, 0.0),
          //       end: const FractionalOffset(0.0, 0.5),
          //       stops: [0.0, 1.0],
          //       tileMode: TileMode.clamp),
          //),
        ),
      ),
    );
  }

  Widget _salir(LoginBloc bloc, BuildContext context) {
    return Center(
      child: Card(
        child: Column(children: <Widget>[
          Center(
            child: ListTile(
              title: Text('Esta seguro que desea salir?'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: [
                  FlatButton(
                    child: Text('NO'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              VerticalDivider(),
              Row(
                children: [
                  FlatButton(
                    child: Text(' SI '),
                    onPressed: () {
                      if (Platform.isAndroid) {
                        //exit para android
                        SystemNavigator.pop();
                        bloc.dispose();
                      } else if (Platform.isIOS) {
                        bloc.dispose();
                        Future.delayed(const Duration(milliseconds: 1500), () {
                          exit(0); //exit para ios
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }



 void mostrarAlerta2(BuildContext context, String mensaje) {
   
    Widget cancelBoton = FlatButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
    Widget continuarBoton = FlatButton(
      child: Text("Continuar"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );

    
    AlertDialog alerta = AlertDialog(
     title: Text('Esta seguro que desea salir?'),
      content: Text(mensaje),
      actions: [
        cancelBoton,
        continuarBoton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }


}
