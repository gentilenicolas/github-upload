import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';
import 'package:formvalidation/src/pages/home_page.dart';

import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/utils/alertas.dart';
import 'package:formvalidation/src/utils/widgets.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = 'login';
// instancia de mi usuario provider
  final loginProvider = new LoginProvider();
  //final prefs = new PreferenciasUsuario();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      /*
      appBar: AppBar(
        actions: [
          Text(_prefs.email)
          //menu hamburguesa
        ],
      ),*/
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
    //);
  }

  Widget _loginForm(BuildContext context) {
    final bloc = LoginProvider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 150.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc),
              ],
            ),
          ),

          //crear cuenta comentado para una proxima version!

          // Container(
          //   child: FlatButton(
          //     child: Text('Crear una nueva cuenta'),
          //     onPressed: () =>
          //         Navigator.pushReplacementNamed(context, 'registro'),
          //   ),
          // ),
          FlatButton(
            child: Text('Salir'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    //mando al loginbloc, como referencia
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final email = snapshot.data ?? "";

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.accessibility, color: Colors.blue),
                hintText: 'ejemplo@correo.com ó 12345678',
                labelText: 'Email o cédula de identidad',
                counterText:
                    email, //snapshot.data, //cuando escribo en el input, me pone por debajo de la linea lo mismo que pongo en ese imput
                errorText: snapshot.error),
            onChanged: bloc
                .changeEmail, //cuando escriben en el campo, se lo manda al email
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.blue),
                labelText: 'Contraseña',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.orange[500],
            textColor: Colors.white,
            //obener los valores de las cajas de texto
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
      },
    );
  }

/*
@override
void initState(){
super.initState();
prefs.ultimaPagina= LoginPage().routeName;
}
*/

  Future<UsuarioModel> _login(LoginBloc bloc, BuildContext context) async {
    final user =
        await loginProvider.crearLogin(bloc.email, bloc.password, context);

    if (user != null) {
      mostrarSnackBar('Login correcto!', scaffoldKey);
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else {
      mostrarAlerta(
          context, 'El usuario no existe o la contraseña es incorrecta');
    }

    return user;
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //este contenedor va a tener un 40% por eso se multiplica el height *0.4

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Colors.deepOrange,
        Colors.orangeAccent
        //Color.fromRGBO(63, 63, 156, 1.0/*este ultimo valor es la opacidad*/ ),
        //Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

//circulos
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)), //color del circulo
    );

    return Stack(
      //circulitos en el fondo  o stack
      children: <Widget>[
        fondoModaro,
        //la propiedad positioned controla para donde van los hijos o "circulitos dentro del stack"
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_sharp,
                  color: Colors.white, size: 100.0), //centrado del icono
              SizedBox(height: 10.0, width: double.infinity),
              //Text('Ingreso al portal Indumex',
              //  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
