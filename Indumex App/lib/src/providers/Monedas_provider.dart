import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:formvalidation/src/models/Moneda_model.dart';
import 'package:formvalidation/src/utils/juego_pruebas.dart';
import 'package:http/http.dart' as http;

class MonedasProvider {
  Future<List<MonedaModel>> getMonedas() async {
    final url = '$urlApi/Moneda';

    try {
      final resp = await http.get(url);

      final List<dynamic> decodedData = json.decode(resp.body);
      final List<MonedaModel> monedas = new List();

      if (decodedData == null) return [];

      decodedData.forEach((moneda) {
        final monedaTemp = MonedaModel.fromJson(moneda);
        monedas.add(monedaTemp);
      });

      return monedas;
    } on TimeoutException catch (_) {
      print(_);
      return [];
    } on SocketException catch (_) {
      print(_);
      return [];
    }
  }

  MonedaModel buscarMoneda(String descripcion) {
    MonedaModel retorno;
    // int recorrida = 0;
    // while (recorrida < monedas.length) {
    //   if (monedas[recorrida].descripcion == descripcion.toUpperCase()) {
    //     recorrida = monedas.length;
    //     retorno = monedas[recorrida];
    //   }
    //   recorrida++;
    // }
    // return retorno;

    for (int i = 0; i < monedas.length; i++) {
      if (monedas[i].descripcion == descripcion.toUpperCase()) {
        retorno = monedas[i];
      }
    }
    return retorno;
  }
}
