import 'dart:convert';
import 'package:formvalidation/src/models/Moneda_model.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';

RealizarOpModel realizarOpModelFromJson(String str) =>
    RealizarOpModel.fromJson(json.decode(str));

String realizarOpModelToJson(RealizarOpModel data) => json.encode(data.toJson());

class RealizarOpModel {
  RealizarOpModel({
    this.monedaTengo,
    this.monedaQuiero,
    this.importeTengo,
    this.importeQuiero,
    this.tcAplicado,
    this.usuario,
  });

  MonedaModel monedaTengo;
  MonedaModel monedaQuiero;
  double importeTengo;
  double importeQuiero;
  double tcAplicado;
  UsuarioModel usuario;

  factory RealizarOpModel.fromJson(Map<String, dynamic> json) {
    if (json["Usuario"] != null) {
      //pregunto si es nulo usuario
      return RealizarOpModel(
        monedaTengo: MonedaModel.fromJson(json["MonedaTengo"]),
        monedaQuiero: MonedaModel.fromJson(json["MonedaQuiero"]),
        importeTengo: json["ImporteTengo"].toDouble(),
        importeQuiero: json["ImporteQuiero"].toDouble(),
        tcAplicado: json["TcAplicado"],
        usuario: UsuarioModel.fromJson(json["Usuario"]),
      );
    } else {
      return RealizarOpModel(
        monedaTengo: MonedaModel.fromJson(json["MonedaTengo"]),
        monedaQuiero: MonedaModel.fromJson(json["MonedaQuiero"]),
        importeTengo: json["ImporteTengo"].toDouble(),
        importeQuiero: json["ImporteQuiero"].toDouble(),
        tcAplicado: json["TcAplicado"],
        usuario: null,
      );
    }
  }
  Map<String, dynamic> toJson() => {
        "MonedaTengo": monedaTengo.toJson(),
        "MonedaQuiero": monedaQuiero.toJson(),
        "ImporteTengo": importeTengo,
        "ImporteQuiero": importeQuiero,
        "TcAplicado": tcAplicado,
        "Usuario": usuario != null ? usuario.toJson() : null
      };
}