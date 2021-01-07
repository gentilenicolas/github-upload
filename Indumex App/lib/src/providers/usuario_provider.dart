// para luego validar con la api de firebase que sea un usuario por lo menos de google
//import 'dart:convert';

//import 'package:http/http.dart' as http;

class UsuarioProvider {/*
  int id;
  String nombre;
  String apellido1;
  String apellido2;
  String nombreCompleto;
  String email;
  Tipodoc tipodoc;
  String nroDoc;
  int nroCliente;
  bool tieneMoneyCar;
  bool habilitadoOperar;
  String pass;

  UsuarioProvider({
    this.id,
    this.nombre,
    this.apellido1,
    this.apellido2,
    this.nombreCompleto,
    this.email,
    this.tipodoc,
    this.nroDoc,
    this.nroCliente,
    this.tieneMoneyCar,
    this.habilitadoOperar,
    this.pass,
  });
}

class Tipodoc {
  int id;
  String descripcion;
  Pais pais;

  Tipodoc({
    this.id,
    this.descripcion,
    this.pais,
  });
}

class Pais {
  int id;
  String descripcion;

  Pais({
    this.id,
    this.descripcion,
  });

  //nuevo usuario por firebase
/*
  nuevoUsuario(String email, String password) async {
//api token que se proporciona de la api
    final String _firebaseToken = ''; // poner la url de la api

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true //esto es para recibir un token
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp); // ver si manda algo 
  }*/
  */
}
