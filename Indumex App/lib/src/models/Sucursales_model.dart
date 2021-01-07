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
// fin       ** ejemplo para ver si tuviera que traer una lista 
 


//sucursal
class SucursalesModel {
  SucursalesModel({
    this.id,
    this.descripcion,
  });

  int id;
  String descripcion;

  factory SucursalesModel.fromJson(Map<String, dynamic> json) =>
      SucursalesModel(
        id         : json["id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id"         : id,
        "Descripcion": descripcion,
      };
}
