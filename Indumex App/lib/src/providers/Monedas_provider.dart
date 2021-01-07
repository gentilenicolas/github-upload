import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:formvalidation/src/models/Moneda_model.dart';
import 'package:formvalidation/src/utils/url_api.dart';
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
}
