import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/Departamentos_model.dart';
import 'package:formvalidation/src/models/Localidades_model.dart';
import 'package:formvalidation/src/models/Moneda_model.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';
import 'package:formvalidation/src/utils/funciones.dart';

final String urlApi = 'http://10.1.3.215:7010/api';

//para simular op
UsuarioModel usuarioLogueado;
List<MonedaModel> monedas = new List();

TextEditingController nombre = new TextEditingController();
TextEditingController apellido = new TextEditingController();

List<String> tiposDeDocumento = new List();

String opcionSeleccionadaTipoDeDocumento = tiposDeDocumento[0];

TextEditingController nroDocumento = new TextEditingController();
String fecha = '';

List<String> paises = new List();
String opcionSeleccionadaPais = paises[0];

List<String> sexo = new List();
String opcionSeleccionadaSexo = sexo[0];
TextEditingController telefono = new TextEditingController();
TextEditingController celular = new TextEditingController();

List<String> estadoCivil = new List();
String opcionSeleccionadaEstadoCivil = estadoCivil[0];

TextEditingController email = new TextEditingController();

String paisResidencia = 'Uruguay';

List<String> departamentos = new List();

String opcionSeleccionadaDepartamento = departamentos[0];
List<DepartamentosModel> departamentosModel = new List();

//LOCALIDADES

List<LocalidadesModel> localidades = new List();
List<String> localidadesParaDepartamento = new List();
String opcionSeleccionadaLocalidad = 'AGUADA  ';

TextEditingController localidad = new TextEditingController();
TextEditingController codigoPostal = new TextEditingController();
TextEditingController manzanaSolar = new TextEditingController();
TextEditingController calle = new TextEditingController();
TextEditingController numeroPuerta = new TextEditingController();
TextEditingController apartamento = new TextEditingController();

//Sucursal de retiro

List<String> sucursales = new List();

String opcionSeleccionadaSucursal = sucursales[0];

//controlador necesario para el Widget de fecha de nacimiento

TextEditingController textEditingControllerDate =
    new TextEditingController(text: formatearFecha(DateTime(1980)));

//home tengo y quiero

List<Map> banderasJson = [
  {
    "id": 3,
    "combo": 'Pesos',
    "descripcion": 'PESOS URUGUAYOS',
    "image": "assets/images/uruguay.png",
  },
  {
    "id": 1,
    "combo": 'Dólares',
    "descripcion": 'DOLARES',
    "image": "assets/images/eeuu.png",
  },
  {
    "id": 2,
    "combo": 'Argentinos',
    "descripcion": 'PESOS ARGENTINOS',
    "image": "assets/images/argentina.png",
  },
  {
    "id": 62,
    "combo": 'Euros',
    "descripcion": 'EUROS',
    "image": "assets/images/unionEuropea.png",
  },
  {
    "id": 4,
    "combo": 'Reales',
    "descripcion": 'REALES',
    "image": "assets/images/brasil.png",
  },
];
