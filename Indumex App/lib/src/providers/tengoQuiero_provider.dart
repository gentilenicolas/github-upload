import 'package:flutter/material.dart';
import 'package:formvalidation/src/utils/juego_pruebas.dart';
//import 'dart:convert';
//import 'package:formvalidation/src/models/Localidades_model.dart';
//import 'package:http/http.dart';

class TengoQuieroProvider with ChangeNotifier {
  double tengoCalculator = 0;
  double quieroCalculator = 0;

  setearTengo(double tengo) {
    tengoCalculator = tengo;
    notifyListeners();
  }

  setearQuiero(double quiero) {
    quieroCalculator = quiero;
    notifyListeners();
  }

  // List<String> localidadesParaDepto = new List();

  // obtenerlocalidadesParaDepartamento(int idDepartamento) {
  //   List<String> lista = new List();
  //   localidades.forEach((localidad) {
  //     if (localidad.idDepartamento == idDepartamento) {
  //       lista.add(localidad.descripcion);
  //     }
  //   });
  //   localidadesParaDepto = lista;
  //   notifyListeners();
  // }
}
