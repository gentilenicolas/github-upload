// To parse this JSON data, do
//
//     final paisNacimientoModel = paisNacimientoModelFromJson(jsonString);

import 'dart:convert';

PaisNacimientoModel paisNacimientoModelFromJson(String str) =>
    PaisNacimientoModel.fromJson(json.decode(str));

String paisNacimientoModelToJson(PaisNacimientoModel data) =>
    json.encode(data.toJson());

class PaisNacimientoModel {
  PaisNacimientoModel({
    this.id,
    this.descripcion,
  });

  int id;
  String descripcion;

  factory PaisNacimientoModel.fromJson(Map<String, dynamic> json) =>
      PaisNacimientoModel(
        id         : json["id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id"         : id,
        "Descripcion": descripcion,
      };
}
