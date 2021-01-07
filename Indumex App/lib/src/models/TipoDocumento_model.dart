// To parse this JSON data, do
//
//     final tipoDocumentoModel = tipoDocumentoModelFromJson(jsonString);

import 'dart:convert';

List<TipoDocumentoModel> tipoDocumentoModelFromJson(String str) =>
    List<TipoDocumentoModel>.from(
        json.decode(str).map((x) => TipoDocumentoModel.fromJson(x)));

String tipoDocumentoModelToJson(List<TipoDocumentoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoDocumentoModel {
  TipoDocumentoModel({
    this.id,
    this.descripcion,
    this.pais,
  });

  int id;
  String descripcion;
  Pais pais;

  factory TipoDocumentoModel.fromJson(Map<String, dynamic> json) =>
      TipoDocumentoModel(
        id: json["id"],
        descripcion: json["Descripcion"],
        pais: Pais.fromJson(json["Pais"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        "Pais": pais.toJson(),
      };
}

class Pais {
  Pais({
    this.id,
    this.descripcion,
  });

  int id;
  String descripcion;

  factory Pais.fromJson(Map<String, dynamic> json) => Pais(
        id: json["Id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
      };
}
