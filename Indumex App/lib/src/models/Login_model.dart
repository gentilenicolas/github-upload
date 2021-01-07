
/*

import 'dart:convert';

//********************************************************************************************************************************/
//con el atajo , (ctrl+shift+p) "paste jason as code" , podemos copiar todas las row de la api, y nos mete todas las propiedades (ver video 100 udemy)
//*******************************************************************************************************************************/

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String email;
  String pass;

  // String cambiarP; //no tengo idea que peticion le tengo que madnar para cambiar la pass

//constructor
  LoginModel({
    this.email,
    this.pass,
    //  this.tipoDoc,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json['user'],
        pass: json['pass'],
        //  tipoDoc : json ["tipoDoc"],
      );

  Map<String, dynamic> toJson() => {
        'user': email,
        'pass': pass,

   
        // "TipoDoc" : tipoDoc,
      };
}

*/