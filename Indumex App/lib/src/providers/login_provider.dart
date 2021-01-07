import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';

import 'package:formvalidation/src/utils/url_api.dart';
import 'package:http/http.dart' as http;
export 'package:formvalidation/src/bloc/login_bloc.dart'; //donde utilice mi provider con el export lo puedo usar donde quiera


//el inheritedwidget , es una clase que obliga a notificar a todos los hijos de la cadena o arbol
class LoginProvider extends InheritedWidget {
  static LoginProvider _instancia;

  factory LoginProvider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new LoginProvider._internal(
          key: key,
          child:
              child); //creo el constructor privado par aqu eno se inicialice desde afuera
    }

    return _instancia;
  }

  LoginProvider._internal({Key key, Widget child})
      : super(
            key: key, //es el mismo key al igual qu eel child
            child:
                child); // es un identificador unico del widget osea que dentro de mi inheritWidget voy a meter un widget child

  final loginBloc = LoginBloc(); // es una propiedad de instancia de login bloc

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      true; // esto es para que se actualice todo el dia.

  static LoginBloc of(BuildContext context) {
    //metodo estatico of y el build context es el arbol de widgets el of busca dentro del arbol del context
    //print(context);

    return context.dependOnInheritedWidgetOfExactType<LoginProvider>().loginBloc; //el inheritedWidget cambio por el dependoOnInheritedWidgetOf....
  }

  
  Future<UsuarioModel> crearLogin(String user, String pass, BuildContext context) async {
    final bloc = LoginProvider.of(context);
    //final _prefs = new PreferenciasUsuario();

    UsuarioModel usuario = new UsuarioModel();

    final url = '$urlApi/Usuario?user=$user&pass=$pass';
    //envio a api "res = respuesta"
    final resp = await http.post(url,//esperar a que tenga respuesta
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
       

    //data decodificata= "data", en el decode viene la respuesa de la data desd ela api
    final decodedData = json.decode(resp
        .body); 

   // print(decodedData); // para ver lo que trae en el debug
    //String mensaje = decodedData;

    if (resp.statusCode == 400) {
      return null;
    } else {
      usuario = UsuarioModel.fromJson(decodedData);
      bloc.changeNombre(usuario.nombre);
      bloc.changeUsuario(usuario);
    
     // _prefs.nombre(usuario.nombre); //seteo el nombre a las preferencias del usuario para que qeude grabado en memoria del tel
      //_prefs.email(usuario.email);
      return usuario;
    }
  }


}
