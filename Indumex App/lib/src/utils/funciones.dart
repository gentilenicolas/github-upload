import 'package:flutter/material.dart';
import 'package:formvalidation/src/providers/Monedas_provider.dart';

import 'package:formvalidation/src/utils/juego_pruebas.dart';
import 'package:formvalidation/src/providers/moneycard_provider.dart';

bool esNumerico(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

String formatearFecha(DateTime fechaSinFormato) {
  String fecha = fechaSinFormato.toString();
  String anio = fecha.substring(0, 4);
  String mes = fecha.substring(5, 7);
  String dia = fecha.substring(8, 10);

  return '$dia/$mes/$anio';

  //.split('').reversed.join(); para invertir la cadena de texto
}

List<DropdownMenuItem<dynamic>> obtenerValorDelDropdownList(List lista) {
  List<DropdownMenuItem<dynamic>> listaDrop = new List();

  lista.forEach((item) {
    listaDrop.add(DropdownMenuItem(
      child: Text(item.toString()),
      value: item,
    ));
  });

  return listaDrop;
}

int buscarIdDepartamento(String deptoString) {
  int retorno;
  departamentosModel.forEach((depto) {
    if (depto.descripcion == deptoString) {
      retorno = depto.id;
      return retorno;
    }
  });
  return retorno;
}

void cargoDataInicial() async {
  MoneycardProvider moneycardProvider = new MoneycardProvider();
  MonedasProvider monedasProvider = MonedasProvider();

  try {
    //combos Moneycard
    tiposDeDocumento = await moneycardProvider.obtenerTiposDeDocumentos();
    paises = await moneycardProvider.obtenerPaisNacimiento();
    sexo = await moneycardProvider.obtenerSexos();
    estadoCivil = await moneycardProvider.obtenerEstadoCivil();
    departamentos = await moneycardProvider.obtenerDepartamentos();
    departamentosModel = await moneycardProvider.obtenerDepartamentosModel();
    localidades = await moneycardProvider.obtenerLocalidades();
    sucursales = await moneycardProvider.obtenerSucursales();
    //monedas para simularOp y RealizarOp
    monedas = await monedasProvider.getMonedas();
  } catch (excepcion) {
    print(excepcion);
  }
}
