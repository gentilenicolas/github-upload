import 'dart:async';
import 'package:formvalidation/src/models/Usuario_model.dart';
import 'package:formvalidation/src/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

//es una propiedad que instancia a todas las propiedades del login con esta propiedad de bloc
class LoginBloc with Validators {
  final _emailController = BehaviorSubject<
      String>(); //se escuchan los cambios sin hacer un brodcast la propiedad Beahavior
  //lo hace en lugar de la sTREAMcONTOELLER
  final _passwordController = BehaviorSubject<String>();
  final _nombreController = BehaviorSubject<String>();
  final _usuarioController = BehaviorSubject<UsuarioModel>();

  // Recuperar los datos del Stream y esto lo hace con el get y el .stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarUsuario);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream => Observable.combineLatest2(
      emailStream,
      passwordStream,
      (e, p) => true); //retultado de pass y email, si estan llenos retorno true



  Stream<String> get nombreStream =>
      _nombreController.stream.transform(validarUsuario);
 
//  //valido usuario 
//  Stream<bool> get formValidUsuarioStream => Observable.fromIterable([nom]
//        usuarioStream,
//       (usuarioStream) => true); 



  // Insertar  o enviar valores al Stream .sink
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeNombre => _nombreController.sink.add;
  Function(UsuarioModel) get changeUsuario => _usuarioController.sink.add;

  // Obtener el último valor ingresado a los streams , estos lo relaciono con el metodo _login  , del login.dart
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get nombre => _nombreController.value;
  UsuarioModel get usuario => _usuarioController.value;

  dispose() {
    //el "?" si se coloca en el dispose evita que si hay valores nullos no ejecuta
    //la clusula porque daria error si se hiciera
    _emailController?.close();
    _passwordController?.close();
    _nombreController?.close();
    _usuarioController?.close();
  }
}
