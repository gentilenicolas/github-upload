// To parse this JSON data, do
//
//     final localidadesModel = localidadesModelFromJson(jsonString);

import 'dart:convert';

LocalidadesModel localidadesModelFromJson(String str) =>
    LocalidadesModel.fromJson(json.decode(str));

String localidadesModelToJson(LocalidadesModel data) =>
    json.encode(data.toJson());

class LocalidadesModel {
  LocalidadesModel({
    this.id,
    this.descripcion,
    this.idDepartamento,
  });

  int id;
  String descripcion;
  int idDepartamento;

  factory LocalidadesModel.fromJson(Map<String, dynamic> json) =>
      LocalidadesModel(
        id: json["Id"],
        descripcion: json["Descripcion"],
        idDepartamento: json["idDepartamento"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        "idDepartamento": idDepartamento,
      };
}
