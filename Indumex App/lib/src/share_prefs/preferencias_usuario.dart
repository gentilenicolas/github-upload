

//para guardar las preferencias de usuario en este caso el email en el storage del tel
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal(); //singleton para utilizar las preferencias en todos lados,
  
  //construcytor
  factory PreferenciasUsuario() {
    return _instancia;
  }

//incializacion del metodo internal
  PreferenciasUsuario._internal(); 

// SharedPreferences es donde se guarda la clase que guarda y lee configuraciones
  SharedPreferences _prefs; 
  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Los campos a guardar en este caso es el email
  get email {
    return _prefs.getString("email") ?? ''; // si no encuentra el mail , me devuelve vacio
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

//nombre
  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  //la última página donde trabajo el usuario
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
