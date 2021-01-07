import 'dart:async';

class Validators {


  final validarUsuario = StreamTransformer<String, String>.fromHandlers(
      handleData: (usuario, sink) {
  //patron para ci
    Pattern pattternCedula = r'(^[0-9]{8}.*$)';
//patron para email
    Pattern patternEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExpEM = new RegExp(patternEmail);
    RegExp regExpCI = new RegExp(pattternCedula);

    if (regExpEM.hasMatch(usuario) | regExpCI.hasMatch(usuario)) {
      sink.add(usuario);
    } else {
      return sink.addError('Correo electronico o cedula sin guion');
    }
  });
/*
 final validarDocumento = StreamTransformer<String, String>.fromHandlers(// string , string , significa que entra un string y sale un string
    handleData: ( password, sink ) { //recibe el string y el sink le dice que info notifico o que info le digo que es error

 */ 

//validar password 
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      // string , string , significa que entra un string y sale un string
      handleData: (password, sink) {
    //recibe el string y el sink le dice que info notifico o que info le digo que es error

    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Más de 6 caracteres por favor');
    }
  });
}
