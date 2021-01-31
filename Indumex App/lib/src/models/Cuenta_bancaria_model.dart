import 'dart:convert';

CuentaBancariaModel cuentasModelFromJson(String str) =>
    CuentaBancariaModel.fromJson(json.decode(str));

String cuentasModelToJson(CuentaBancariaModel data) =>
    json.encode(data.toJson());

class CuentaBancariaModel {
  CuentaBancariaModel({
    this.id,
    this.idusuario,
    this.idbanco,
    this.nroCta,
    this.nombreBeneficiario,
    this.idMoneda,
    this.alias,
  });

  int id;
  int idusuario;
  int idbanco;
  int nroCta;
  String nombreBeneficiario;
  int idMoneda;
  String alias;

  factory CuentaBancariaModel.fromJson(Map<String, dynamic> json) =>
      CuentaBancariaModel(
        id: json["id"],
        idusuario: json["idusuario"],
        idbanco: json["idbanco"],
        nroCta: json["nroCuenta"],
        nombreBeneficiario: json["nombrebenef"],
        idMoneda: json["idmoneda"],
        alias: json["alias"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idbanco": idbanco,
        "nroCuenta": nroCta,
        "nombreBenef": nombreBeneficiario,
        "idmoneda": idMoneda,
        "Alias": alias,
      };
}
