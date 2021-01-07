// To parse this JSON data, do
//
//     final monedaModel = monedaModelFromJson(jsonString);

import 'dart:convert';

PizarraModel pizarraModelFromJson(String str) =>
    PizarraModel.fromJson(json.decode(str));

String pizarraModelToJson(PizarraModel data) => json.encode(data.toJson());

class PizarraModel {
  String id;
  String moneda;
  double compra;
  double venta;

  PizarraModel({
    this.moneda = '',
    this.compra = 0,
    this.venta = 0,
  });

  factory PizarraModel.fromJson(Map<String, dynamic> json) => PizarraModel(
        moneda: json["Moneda"],
        compra: json["compra"],
        venta: json["venta"],
      );

  Map<String, dynamic> toJson() => {
        "Moneda": moneda,
        "compra": compra,
        "venta": venta,
      };
}
