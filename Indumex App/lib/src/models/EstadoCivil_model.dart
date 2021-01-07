// To parse this JSON data, do
//
//     final estadoCivilModel = estadoCivilModelFromJson(jsonString);

import 'dart:convert';

EstadoCivilModel estadoCivilModelFromJson(String str) =>
    EstadoCivilModel.fromJson(json.decode(str));

String estadoCivilModelToJson(EstadoCivilModel data) =>
    json.encode(data.toJson());

class EstadoCivilModel {
  EstadoCivilModel({
    this.id,
    this.descripcion,
  });

  int id;
  String descripcion;

  factory EstadoCivilModel.fromJson(Map<String, dynamic> json) =>
      EstadoCivilModel(
        id         : json["id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id"         : id,
        "Descripcion": descripcion,
      };
}
