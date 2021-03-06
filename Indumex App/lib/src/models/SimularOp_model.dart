// To parse this JSON data, do
//
//     final simularOpModel = simularOpModelFromJson(jsonString);

import 'dart:convert';

import 'package:formvalidation/src/models/Moneda_model.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';

SimularOpModel simularOpModelFromJson(String str) =>
    SimularOpModel.fromJson(json.decode(str));

String simularOpModelToJson(SimularOpModel data) => json.encode(data.toJson());

class SimularOpModel {
  SimularOpModel({
    this.idSimulacion,
    this.monedaTengo,
    this.monedaQuiero,
    this.importeTengo,
    this.importeQuiero,
    this.tcAplicado,
    this.tcPizarra,
    this.tcUsuarioApp,
    this.tcClientePref,
    this.tcDescuentoMax,
    this.usuario,
  });

  int idSimulacion;
  MonedaModel monedaTengo;
  MonedaModel monedaQuiero;
  double importeTengo;
  double importeQuiero;
  double tcAplicado;
  double tcPizarra;
  double tcUsuarioApp;
  double tcClientePref;
  double tcDescuentoMax;
  UsuarioModel usuario;

  factory SimularOpModel.fromJson(Map<String, dynamic> json) {
    if (json["Usuario"] != null) {
      //pregunto si es nulo usuario
      return SimularOpModel(
        idSimulacion: json["idSimulacion"],
        monedaTengo: MonedaModel.fromJson(json["MonedaTengo"]),
        monedaQuiero: MonedaModel.fromJson(json["MonedaQuiero"]),
        importeTengo: json["ImporteTengo"].toDouble(),
        importeQuiero: json["ImporteQuiero"].toDouble(),
        tcAplicado: json["TcAplicado"].toDouble(),
        tcPizarra: json["TcPizarra"].toDouble(),
        tcUsuarioApp: json["TcUsuarioApp"].toDouble(),
        tcClientePref: json["TcClientePref"].toDouble(),
        tcDescuentoMax: json["TcDescuentoMax"].toDouble(),
        usuario: UsuarioModel.fromJson(json["Usuario"]),
      );
    } else {
      return SimularOpModel(
        idSimulacion: json["idSimulacion"],
        monedaTengo: MonedaModel.fromJson(json["MonedaTengo"]),
        monedaQuiero: MonedaModel.fromJson(json["MonedaQuiero"]),
        importeTengo: json["ImporteTengo"].toDouble(),
        importeQuiero: json["ImporteQuiero"].toDouble(),
        tcAplicado: json["TcAplicado"].toDouble(),
        tcPizarra: json["TcPizarra"].toDouble(),
        tcUsuarioApp: json["TcUsuarioApp"].toDouble(),
        tcClientePref: json["TcClientePref"].toDouble(),
        tcDescuentoMax: json["TcDescuentoMax"].toDouble(),
        usuario: null,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "idSimulacion": idSimulacion,
        "MonedaTengo": monedaTengo.toJson(),
        "MonedaQuiero": monedaQuiero.toJson(),
        "ImporteTengo": importeTengo,
        "ImporteQuiero": importeQuiero,
        "TcAplicado": tcAplicado,
        "TcPizarra": tcPizarra,
        "TcUsuarioApp": tcUsuarioApp,
        "TcClientePref": tcClientePref,
        "TcDescuentoMax": tcDescuentoMax,
        "Usuario": usuario != null ? usuario.toJson() : null
      };
}

//MODELO ANTES DEL CAMBIO DE ALE:

// To parse this JSON data, do
//
//     final simularOpModel = simularOpModelFromJson(jsonString);

// import 'dart:convert';

// import 'package:formvalidation/src/models/Moneda_model.dart';
// import 'package:formvalidation/src/models/Usuario_model.dart';

// SimularOpModel simularOpModelFromJson(String str) =>
//     SimularOpModel.fromJson(json.decode(str));

// String simularOpModelToJson(SimularOpModel data) => json.encode(data.toJson());

// class SimularOpModel {
//   SimularOpModel({
//     this.monedaTengo,
//     this.monedaQuiero,
//     this.importeTengo,
//     this.importeQuiero,
//     this.tcAplicado,
//     this.usuario,
//   });

//   MonedaModel monedaTengo;
//   MonedaModel monedaQuiero;
//   double importeTengo;
//   double importeQuiero;
//   double tcAplicado;
//   UsuarioModel usuario;

//   factory SimularOpModel.fromJson(Map<String, dynamic> json) {
//     if (json["Usuario"] != null) {
//       //pregunto si es nulo usuario
//       return SimularOpModel(
//         monedaTengo: MonedaModel.fromJson(json["MonedaTengo"]),
//         monedaQuiero: MonedaModel.fromJson(json["MonedaQuiero"]),
//         importeTengo: json["ImporteTengo"].toDouble(),
//         importeQuiero: json["ImporteQuiero"].toDouble(),
//         tcAplicado: json["TcAplicado"],
//         usuario: UsuarioModel.fromJson(json["Usuario"]),
//       );
//     } else {
//       return SimularOpModel(
//         monedaTengo: MonedaModel.fromJson(json["MonedaTengo"]),
//         monedaQuiero: MonedaModel.fromJson(json["MonedaQuiero"]),
//         importeTengo: json["ImporteTengo"].toDouble(),
//         importeQuiero: json["ImporteQuiero"].toDouble(),
//         tcAplicado: json["TcAplicado"],
//         usuario: null,
//       );
//     }
//   }
//   Map<String, dynamic> toJson() => {
//         "MonedaTengo": monedaTengo.toJson(),
//         "MonedaQuiero": monedaQuiero.toJson(),
//         "ImporteTengo": importeTengo,
//         "ImporteQuiero": importeQuiero,
//         "TcAplicado": tcAplicado,
//         "Usuario": usuario != null ? usuario.toJson() : null
//       };
// }

// class MonedaModel {
//   MonedaModel({
//     this.id,
//     this.descripcion,
//     this.tipoParidad,
//     this.codigoIso,
//     this.imagen,
//   });

//   int id;
//   String descripcion;
//   int tipoParidad;
//   String codigoIso;
//   dynamic imagen;

//   factory MonedaModel.fromJson(Map<String, dynamic> json) => MonedaModel(
//         id: json["Id"],
//         descripcion: json["Descripcion"],
//         tipoParidad: json["TipoParidad"],
//         codigoIso: json["CodigoIso"],
//         imagen: json["Imagen"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Id": id,
//         "Descripcion": descripcion,
//         "TipoParidad": tipoParidad,
//         "CodigoIso": codigoIso,
//         "Imagen": imagen,
//       };
// }

// class Usuario {
//   Usuario({
//     this.id,
//     this.nombre,
//     this.apellido1,
//     this.apellido2,
//     this.nombreCompleto,
//     this.email,
//     this.tipodoc,
//     this.nroDoc,
//     this.nroCliente,
//     this.tieneMoneyCar,
//     this.habilitadoOperar,
//     this.tipoDescuento,
//     this.pass,
//   });

//   int id;
//   String nombre;
//   String apellido1;
//   String apellido2;
//   String nombreCompleto;
//   String email;
//   Tipodoc tipodoc;
//   String nroDoc;
//   int nroCliente;
//   bool tieneMoneyCar;
//   bool habilitadoOperar;
//   int tipoDescuento;
//   String pass;

//   factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
//         id: json["id"],
//         nombre: json["Nombre"],
//         apellido1: json["Apellido1"],
//         apellido2: json["Apellido2"],
//         nombreCompleto: json["NombreCompleto"],
//         email: json["Email"],
//         tipodoc: Tipodoc.fromJson(json["tipodoc"]),
//         nroDoc: json["NroDoc"],
//         nroCliente: json["NroCliente"],
//         tieneMoneyCar: json["tieneMoneyCar"],
//         habilitadoOperar: json["habilitadoOperar"],
//         tipoDescuento: json["TipoDescuento"],
//         pass: json["Pass"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "Nombre": nombre,
//         "Apellido1": apellido1,
//         "Apellido2": apellido2,
//         "NombreCompleto": nombreCompleto,
//         "Email": email,
//         "tipodoc": tipodoc.toJson(),
//         "NroDoc": nroDoc,
//         "NroCliente": nroCliente,
//         "tieneMoneyCar": tieneMoneyCar,
//         "habilitadoOperar": habilitadoOperar,
//         "TipoDescuento": tipoDescuento,
//         "Pass": pass,
//       };
// }

// class Tipodoc {
//   Tipodoc({
//     this.id,
//     this.descripcion,
//     this.pais,
//   });

//   int id;
//   String descripcion;
//   Pais pais;

//   factory Tipodoc.fromJson(Map<String, dynamic> json) => Tipodoc(
//         id: json["Id"],
//         descripcion: json["Descripcion"],
//         pais: Pais.fromJson(json["Pais"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "Id": id,
//         "Descripcion": descripcion,
//         "Pais": pais.toJson(),
//       };
// }

// class Pais {
//   Pais({
//     this.id,
//     this.descripcion,
//   });

//   int id;
//   String descripcion;

//   factory Pais.fromJson(Map<String, dynamic> json) => Pais(
//         id: json["Id"],
//         descripcion: json["Descripcion"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Id": id,
//         "Descripcion": descripcion,
//       };
// }
