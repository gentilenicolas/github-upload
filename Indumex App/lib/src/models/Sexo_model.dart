// To parse this JSON data, do
//
//     final sexoModel = sexoModelFromJson(jsonString);

import 'dart:convert';

SexoModel sexoModelFromJson(String str) => SexoModel.fromJson(json.decode(str));

String sexoModelToJson(SexoModel data) => json.encode(data.toJson());

class SexoModel {
  SexoModel({
    this.id,
    this.descripcion,
  });

  int id;
  String descripcion;

  factory SexoModel.fromJson(Map<String, dynamic> json) => SexoModel(
        id         : json["id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id"         : id,
        "Descripcion": descripcion,
      };
}
