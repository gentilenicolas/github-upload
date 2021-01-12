import 'dart:async';
import 'dart:convert';
import 'package:formvalidation/src/models/Moneda_model.dart';
import 'package:formvalidation/src/models/SimularOp_model.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';
import 'package:formvalidation/src/utils/url_api.dart';
import 'package:http/http.dart' as http;

class SimularOpProvider {
  Future<bool> enviarSimulacionOp(
      MonedaModel monedaTengo,
      MonedaModel monedaQuiero,
      double importeTengo,
      double importeQuiero,
      double tcAplicado,
      UsuarioModel usuario) async {
    final url = '$urlApi/SimularOp';

    final resp = await http.post(url,
        // body: jsonEncode(<String, dynamic>{
        //   "idSimulacion": 10000,
        //   "MonedaTengo": json.decode(monedaModelToJson(monedaTengo)),
        //   "MonedaQuiero": json.decode(monedaModelToJson(monedaQuiero)),
        //   "ImporteTengo": importeTengo,
        //   "ImporteQuiero": importeQuiero,
        //   "TcAplicado": tcAplicado,
        //   "Usuario": json.decode(usuarioToJson(usuario))
        // }),
        body: simularOpModelToJson(new SimularOpModel(
            monedaTengo: monedaTengo,
            monedaQuiero: monedaQuiero,
            importeTengo: importeTengo,
            importeQuiero: importeQuiero,
            tcAplicado: tcAplicado,
            usuario: usuario)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    final decodedData = json.decode(resp.body);

    print(decodedData);

    if (resp.statusCode == 400) return false;

    return true;
  }

  // Future<List<DatoModel>> recibirSimulacionOp() async {
  //   final url = '$urlApi/SimularOp';

  //   try {
  //     final resp = await http.get(url);

  //     final List<dynamic> decodedData = json.decode(resp.body);
  //     //final List<DatoModel> datos = new List();

  //     if (decodedData == null) return [];

  //     decodedData.forEach((dato) {
  //       //final datoTemp = DatoModel.fromJson(dato);
  //       //datos.add(datoTemp);
  //     });

  //     //return datos;
  //   } on TimeoutException catch (_) {
  //     print(_);
  //     return [];
  //   } on SocketException catch (_) {
  //     print(_);
  //     return [];
  //   }
  // }
}
