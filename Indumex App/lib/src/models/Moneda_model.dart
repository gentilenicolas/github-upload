// To parse this JSON data, do
//
//     final monedaModel = monedaModelFromJson(jsonString);

import 'dart:convert';

MonedaModel monedaModelFromJson(String str) =>
    MonedaModel.fromJson(json.decode(str));

String monedaModelToJson(MonedaModel data) => json.encode(data.toJson());

class MonedaModel {
  MonedaModel({
    this.id,
    this.descripcion,
    this.tipoParidad,
    this.codigoIso,
    this.imagen,
  });

  int id;
  String descripcion;
  int tipoParidad;
  String codigoIso;
  dynamic imagen;

  factory MonedaModel.fromJson(Map<String, dynamic> json) => MonedaModel(
        id: json["Id"],
        descripcion: json["Descripcion"],
        tipoParidad: json["TipoParidad"],
        codigoIso: json["CodigoIso"],
        imagen: json["Imagen"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        "TipoParidad": tipoParidad,
        "CodigoIso": codigoIso,
        "Imagen": imagen,
      };
}
