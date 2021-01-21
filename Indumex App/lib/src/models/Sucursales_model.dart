// To parse this JSON data, do
//
//final sucursalesModel = sucursalesModelFromJson(jsonString);

import 'dart:convert';
//import 'package:formvalidation/src/pages/sucursales.dart';

SucursalesModel sucursalesModelFromJson(String str) =>
    SucursalesModel.fromJson(json.decode(str));

String sucursalesModelToJson(SucursalesModel data) =>
    json.encode(data.toJson());

//sucursales ** ejemplo para ver si tuviera que traer una lista
class SucursalessModel {
  List<SucursalessModel> listSucursales = new List();

  SucursalessModel();

  SucursalessModel.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final sucursales = new SucursalessModel.fromJsonList(item);
      listSucursales.add(sucursales);
    }
  }
}

//sucursal
class SucursalesModel {
  SucursalesModel({
    this.id,
    this.descripcion,
    // this.suc,
    // this.mail,
    // this.direccion,
    // this.telefono,
    // this.telefono2,
    // this.telefono3,
    // this.celular,
    // this.departamento,
  });

  int id;
  String descripcion;
  // int suc;
  // String mail;
  // String direccion;
  // String telefono;
  // String telefono2;
  // String telefono3;
  // String celular;
  // Departamento departamento;

  factory SucursalesModel.fromJson(Map<String, dynamic> json) =>
      SucursalesModel(
        id: json["id"],
        descripcion: json["Descripcion"],
        //suc : json ["suc"],


       // departamento: Departamento.fromJson(json["Departamento"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Descripcion": descripcion,
      //  "suc":suc,
      //  "Departamento": departamento.toJson(),
      };
}

// class Departamento {
//   Departamento({
//     this.id,
//     this.descripcion,
//   });

//   int id;
//   String descripcion;

//   factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
//         id: json["Id"],
//         descripcion: json["Descripcion"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Id": id,
//         "Descripcion": descripcion,
//       };
// }
