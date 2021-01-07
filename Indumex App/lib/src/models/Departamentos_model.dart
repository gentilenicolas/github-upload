// To parse this JSON data, do
//
//     final departamentosModel = departamentosModelFromJson(jsonString);

import 'dart:convert';

DepartamentosModel departamentosModelFromJson(String str) =>
    DepartamentosModel.fromJson(json.decode(str));

String departamentosModelToJson(DepartamentosModel data) =>
    json.encode(data.toJson());

class DepartamentosModel {
  DepartamentosModel({
    this.id,
    this.descripcion,
    this.tieneSuc,
  });

  int id;
  String descripcion;
  int tieneSuc;

  factory DepartamentosModel.fromJson(Map<String, dynamic> json) =>
      DepartamentosModel(
        id         : json["Id"],
        descripcion: json["Descripcion"],
        tieneSuc   : json["tieneSuc"],
      );

  Map<String, dynamic> toJson() => {
        "id"         : id,
        "Descripcion": descripcion,
        "tieneSuc"   : tieneSuc,
      };
}
