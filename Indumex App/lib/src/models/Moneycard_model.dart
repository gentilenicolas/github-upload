// To parse this JSON data, do
//
//     final moneycardModel = moneycardModelFromJson(jsonString);

import 'dart:convert';

MoneycardModel moneycardModelFromJson(String str) =>
    MoneycardModel.fromJson(json.decode(str));

String moneycardModelToJson(MoneycardModel data) => json.encode(data.toJson());

class MoneycardModel {
  String nombre;
  String apellido;
  String segundoNombre;
  String segundoApellido;
  String tipoDeDoc;
  String numeroDeDoc;
  DateTime fechaNacimiento;
  String sexo;
  String tel;
  String estadoCivil;
  String cel;
  String paisDeNacimiento;
  String ocupacion;
  String paisDeResidencia;
  String localidad;
  String zona;
  String codigoPostal;
  String solar;
  String direccion;
  String numeroPuerta;
  String piso;
  String apto;
  String email;
  String departamento;
  String codigoDpto;
  String codigoLocalidad;
  String sucursalRetiro;

  MoneycardModel({
    this.nombre,
    this.apellido,
    this.segundoNombre,
    this.segundoApellido,
    this.tipoDeDoc,
    this.numeroDeDoc,
    this.fechaNacimiento,
    this.sexo,
    this.tel,
    this.estadoCivil,
    this.cel,
    this.paisDeNacimiento,
    this.ocupacion,
    this.paisDeResidencia,
    this.localidad,
    this.zona,
    this.codigoPostal,
    this.solar,
    this.direccion,
    this.numeroPuerta,
    this.piso,
    this.apto,
    this.email,
    this.departamento,
    this.codigoDpto,
    this.codigoLocalidad,
    this.sucursalRetiro,
  });

  factory MoneycardModel.fromJson(Map<String, dynamic> json) => MoneycardModel(
        nombre          : json["Nombre"],
        apellido        : json["Apellido"],
        segundoNombre   : json["SegundoNombre"],
        segundoApellido : json["SegundoApellido"],
        tipoDeDoc       : json["TipoDeDoc"],
        numeroDeDoc     : json["NumeroDeDoc"],
        fechaNacimiento : DateTime.parse(json["FechaNacimiento"]),
        sexo            : json["Sexo"],
        tel             : json["Tel"],
        estadoCivil     : json["EstadoCivil"],
        cel             : json["Cel"],
        paisDeNacimiento: json["PaisDeNacimiento"],
        ocupacion       : json["Ocupacion"],
        paisDeResidencia: json["PaisDeResidencia"],
        localidad       : json["Localidad"],
        zona            : json["Zona"],
        codigoPostal    : json["CodigoPostal"],
        solar           : json["Solar"],
        direccion       : json["Direccion"],
        numeroPuerta    : json["NumeroPuerta"],
        piso            : json["Piso"],
        apto            : json["Apto"],
        email           : json["Email"],
        departamento    : json["Departamento"],
        codigoDpto      : json["CodigoDpto"],
        codigoLocalidad : json["CodigoLocalidad"],
        sucursalRetiro  : json["SucursalRetiro"],
      );

  Map<String, dynamic> toJson() => {
        "Nombre"          : nombre,
        "Apellido"        : apellido,
        "SegundoNombre"   : segundoNombre,
        "SegundoApellido" : segundoApellido,
        "TipoDeDoc"       : tipoDeDoc,
        "NumeroDeDoc"     : numeroDeDoc,
        "FechaNacimiento" : fechaNacimiento.toIso8601String(),
        "Sexo"            : sexo,
        "Tel"             : tel,
        "EstadoCivil"     : estadoCivil,
        "Cel"             : cel,
        "PaisDeNacimiento": paisDeNacimiento,
        "Ocupacion"       : ocupacion,
        "PaisDeResidencia": paisDeResidencia,
        "Localidad"       : localidad,
        "Zona"            : zona,
        "CodigoPostal"    : codigoPostal,
        "Solar"           : solar,
        "Direccion"       : direccion,
        "NumeroPuerta"    : numeroPuerta,
        "Piso"            : piso,
        "Apto"            : apto,
        "Email"           : email,
        "Departamento"    : departamento,
        "CodigoDpto"      : codigoDpto,
        "CodigoLocalidad" : codigoLocalidad,
        "SucursalRetiro"  : sucursalRetiro,
      };
}
