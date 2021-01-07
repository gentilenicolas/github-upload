

//I/flutter ( 9123): {id: 3, Nombre: NICOLAS, Apellido1: GENTILE, Apellido2: LISTRE, NombreCompleto: GENTILE LISTRE,NICOLAS, 
//Email: nggentile@hotmail.com, tipodoc: {Id: 1, Descripcion: C I, Pais: {Id: 1, Descripcion: URUGUAY}},
// NroDoc: 41804390, NroCliente: 14093, tieneMoneyCar: false, habilitadoOperar: true, Pass: }

// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

//import 'package:formvalidation/src/providers/usuario_provider.dart';

UsuarioModel usuarioFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    UsuarioModel({
        this.id,
        this.nombre,
        this.apellido1,
        this.apellido2,
        this.nombreCompleto,
        this.email,
        this.tipodoc,
        this.nroDoc,
        this.nroCliente,
        this.tieneMoneyCar,
        this.habilitadoOperar,
        this.pass,
    });

    int id;
    String nombre;
    String apellido1;
    String apellido2;
    String nombreCompleto;
    String email;
    Tipodoc tipodoc;
    String nroDoc;
    int nroCliente;
    bool tieneMoneyCar;
    bool habilitadoOperar;
    String pass;

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id              : json["id"],
        nombre          : json["Nombre"],
        apellido1       : json["Apellido1"],
        apellido2       : json["Apellido2"],
        nombreCompleto  : json["NombreCompleto"],
        email           : json["Email"],
        tipodoc         : Tipodoc.fromJson(json["tipodoc"]),
        nroDoc          : json["NroDoc"],
        nroCliente      : json["NroCliente"],
      tieneMoneyCar     : json["tieneMoneyCar"],
        habilitadoOperar: json["habilitadoOperar"],
        pass            : json["Pass"],
    );

    Map<String, dynamic> toJson() => {
        "id"              : id,
        "Nombre"          : nombre,
        "Apellido1"       : apellido1,
        "Apellido2"       : apellido2,
        "NombreCompleto"  : nombreCompleto,
        "Email"           : email,
        "tipodoc"         : tipodoc.toJson(),
        "NroDoc"          : nroDoc,
        "NroCliente"      : nroCliente,
        "tieneMoneyCar"   : tieneMoneyCar,
        "habilitadoOperar": habilitadoOperar,
        "Pass"            : pass,
    };
}

class Tipodoc {
    Tipodoc({
        this.id,
        this.descripcion,
        this.pais,
    });

    int id;
    String descripcion;
    Pais pais;

    factory Tipodoc.fromJson(Map<String, dynamic> json) => Tipodoc(
        id         : json["Id"],
        descripcion: json["Descripcion"],
        pais       : Pais.fromJson(json["Pais"]),
    );

    Map<String, dynamic> toJson() => {
        "Id"         : id,
        "Descripcion": descripcion,
        "Pais"       : pais.toJson(),
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



