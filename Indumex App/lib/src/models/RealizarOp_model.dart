
import 'dart:convert';

import 'package:formvalidation/src/models/EntregoPago_model.dart';

//nuevo modelo op

RealizarOpModel realizarOpFromJson(String str) => RealizarOpModel.fromJson(json.decode(str));

String realizarOpToJson(RealizarOpModel data) => json.encode(data.toJson());

class RealizarOpModel {
    RealizarOpModel({
        this.opSimulada,
        this.fecha,
        this.comentarios,
        this.suc,
        this.reciboPago,
        this.entregoPago,
        this.cuentaBancaria,
        this.comprobanteDepo,
        this.nroDepo,
    });

    OpSimulada opSimulada;
    DateTime fecha;
    String comentarios;
    Suc suc;
    EntregoPago reciboPago;
    EntregoPago entregoPago;
    CuentaBancaria cuentaBancaria;
    String comprobanteDepo;
    String nroDepo;

    factory RealizarOpModel.fromJson(Map<String, dynamic> json) => RealizarOpModel(
        opSimulada: OpSimulada.fromJson(json["opSimulada"]),
        fecha: DateTime.parse(json["Fecha"]),
        comentarios: json["comentarios"],
        suc: Suc.fromJson(json["suc"]),
        reciboPago: EntregoPago.fromJson(json["ReciboPago"]),
        entregoPago: EntregoPago.fromJson(json["EntregoPago"]),
        cuentaBancaria: CuentaBancaria.fromJson(json["cuentaBancaria"]),
        comprobanteDepo: json["comprobanteDepo"],
        nroDepo: json["nroDepo"],
    );

    Map<String, dynamic> toJson() => {
        "opSimulada": opSimulada.toJson(),
        "Fecha": fecha.toIso8601String(),
        "comentarios": comentarios,
        "suc": suc.toJson(),
        "ReciboPago": reciboPago.toJson(),
        "EntregoPago": entregoPago.toJson(),
        "cuentaBancaria": cuentaBancaria.toJson(),
        "comprobanteDepo": comprobanteDepo,
        "nroDepo": nroDepo,
    };
}

class CuentaBancaria {
    CuentaBancaria({
        this.id,
        this.usuario,
        this.banco,
        this.nroCuenta,
        this.nombreBenef,
        this.moneda,
    });

    int id;
    Usuario usuario;
    EntregoPago banco;
    String nroCuenta;
    String nombreBenef;
    Moneda moneda;

    factory CuentaBancaria.fromJson(Map<String, dynamic> json) => CuentaBancaria(
        id: json["Id"],
        usuario: Usuario.fromJson(json["Usuario"]),
        banco: EntregoPago.fromJson(json["Banco"]),
        nroCuenta: json["NroCuenta"],
        nombreBenef: json["NombreBenef"],
        moneda: Moneda.fromJson(json["Moneda"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Usuario": usuario.toJson(),
        "Banco": banco.toJson(),
        "NroCuenta": nroCuenta,
        "NombreBenef": nombreBenef,
        "Moneda": moneda.toJson(),
    };
}

class EntregoPago {
    EntregoPago({
        this.id,
        this.descripcion,
    });

    int id;
    String descripcion;

    factory EntregoPago.fromJson(Map<String, dynamic> json) => EntregoPago(
        id: json["Id"],
        descripcion: json["Descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
    };
}

class Moneda {
    Moneda({
        this.id,
        this.descripcion,
        this.tipoParidad,
        this.codigoIso,
        this.imagen,
        this.habilitaOp,
    });

    int id;
    String descripcion;
    int tipoParidad;
    String codigoIso;
    String imagen;
    bool habilitaOp;

    factory Moneda.fromJson(Map<String, dynamic> json) => Moneda(
        id: json["Id"],
        descripcion: json["Descripcion"],
        tipoParidad: json["TipoParidad"],
        codigoIso: json["CodigoIso"],
        imagen: json["Imagen"],
        habilitaOp: json["HabilitaOP"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        "TipoParidad": tipoParidad,
        "CodigoIso": codigoIso,
        "Imagen": imagen,
        "HabilitaOP": habilitaOp,
    };
}

class Usuario {
    Usuario({
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
        this.tipoDescuento,
        this.pass,
        this.telefono,
        this.celular,
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
    int tipoDescuento;
    String pass;
    String telefono;
    String celular;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["Nombre"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        nombreCompleto: json["NombreCompleto"],
        email: json["Email"],
        tipodoc: Tipodoc.fromJson(json["tipodoc"]),
        nroDoc: json["NroDoc"],
        nroCliente: json["NroCliente"],
        tieneMoneyCar: json["tieneMoneyCar"],
        habilitadoOperar: json["habilitadoOperar"],
        tipoDescuento: json["TipoDescuento"],
        pass: json["Pass"],
        telefono: json["telefono"],
        celular: json["celular"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Nombre": nombre,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "NombreCompleto": nombreCompleto,
        "Email": email,
        "tipodoc": tipodoc.toJson(),
        "NroDoc": nroDoc,
        "NroCliente": nroCliente,
        "tieneMoneyCar": tieneMoneyCar,
        "habilitadoOperar": habilitadoOperar,
        "TipoDescuento": tipoDescuento,
        "Pass": pass,
        "telefono": telefono,
        "celular": celular,
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
    EntregoPago pais;

    factory Tipodoc.fromJson(Map<String, dynamic> json) => Tipodoc(
        id: json["Id"],
        descripcion: json["Descripcion"],
        pais: EntregoPago.fromJson(json["Pais"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        "Pais": pais.toJson(),
    };
}

class OpSimulada {
    OpSimulada({
        this.idSimulacion,
        this.monedaTengo,
        this.monedaQuiero,
        this.importeTengo,
        this.importeQuiero,
        this.tcAplicado,
        this.tcPizarra,
        this.tcUsuarioApp,
        this.tcClientePref,
        this.tcDescuentoMax,
        this.usuario,
    });

    int idSimulacion;
    Moneda monedaTengo;
    Moneda monedaQuiero;
    double importeTengo;
    double importeQuiero;
    double tcAplicado;
    double tcPizarra;
    double tcUsuarioApp;
    double tcClientePref;
    double tcDescuentoMax;
    Usuario usuario;

    factory OpSimulada.fromJson(Map<String, dynamic> json) => OpSimulada(
        idSimulacion: json["idSimulacion"],
        monedaTengo: Moneda.fromJson(json["MonedaTengo"]),
        monedaQuiero: Moneda.fromJson(json["MonedaQuiero"]),
        importeTengo: json["ImporteTengo"].toDouble(),
        importeQuiero: json["ImporteQuiero"].toDouble(),
        tcAplicado: json["TcAplicado"].toDouble(),
        tcPizarra: json["TcPizarra"].toDouble(),
        tcUsuarioApp: json["TcUsuarioApp"].toDouble(),
        tcClientePref: json["TcClientePref"].toDouble(),
        tcDescuentoMax: json["TcDescuentoMax"].toDouble(),
        usuario: Usuario.fromJson(json["Usuario"]),
    );

    Map<String, dynamic> toJson() => {
        "idSimulacion": idSimulacion,
        "MonedaTengo": monedaTengo.toJson(),
        "MonedaQuiero": monedaQuiero.toJson(),
        "ImporteTengo": importeTengo,
        "ImporteQuiero": importeQuiero,
        "TcAplicado": tcAplicado,
        "TcPizarra": tcPizarra,
        "TcUsuarioApp": tcUsuarioApp,
        "TcClientePref": tcClientePref,
        "TcDescuentoMax": tcDescuentoMax,
        "Usuario": usuario.toJson(),
    };
}

class Suc {
    Suc({
        this.id,
        this.descripcion,
        this.suc,
        this.mail,
        this.direccion,
        this.telefono,
        this.telefono2,
        this.telefono3,
        this.celular,
        this.departamento,
    });

    int id;
    String descripcion;
    int suc;
    String mail;
    String direccion;
    String telefono;
    String telefono2;
    String telefono3;
    String celular;
    EntregoPagoModel departamento;

    factory Suc.fromJson(Map<String, dynamic> json) => Suc(
        id: json["Id"],
        descripcion: json["Descripcion"],
        suc: json["suc"],
        mail: json["mail"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        telefono2: json["telefono2"],
        telefono3: json["telefono3"],
        celular: json["celular"],
        departamento: EntregoPagoModel.fromJson(json["departamento"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        "suc": suc,
        "mail": mail,
        "direccion": direccion,
        "telefono": telefono,
        "telefono2": telefono2,
        "telefono3": telefono3,
        "celular": celular,
        "departamento": departamento.toJson(),
    };
}
