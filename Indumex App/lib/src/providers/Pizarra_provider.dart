import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:formvalidation/src/models/Pizarra_model.dart';
import 'package:formvalidation/src/utils/url_api.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
//import 'package:formvalidation/src/utils/funciones.dart';

class PizarraProvider {
//enviar (insert )
  Future<bool> crearMoneda(PizarraModel moneda) async {
    final url = '$urlApi/pizarra';

    final resp = await http.post(url,
        body: pizarraModelToJson(moneda),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    final decodedData = json.decode(resp.body);

    print(decodedData);

    if (resp.statusCode == 400) return false;

    return true;
  }

//recibir
  Future<List<PizarraModel>> cargarPizarra() async {
    final url = '$urlApi/Pizarra';

    try {
      final resp = await http.get(url);

      final List<dynamic> decodedData = json.decode(resp.body);
      final List<PizarraModel> monedas = new List();

      if (decodedData == null) return [];

      decodedData.forEach((moneda) {
        final monedaTemp = PizarraModel.fromJson(moneda);
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

//delete
  Future<String> borrarMoneda(String moneda) async {
    final url = '$urlApi/pizarra?moneda=$moneda';

    final resp = await http.delete(url);
    final decodedData = json.decode(resp.body);
    print(decodedData);

    return decodedData;
  }

//update
  Future<bool> editarMoneda(PizarraModel moneda) async {
    final url = '$urlApi/pizarra';

    final resp = await http.put(url,
        body: pizarraModelToJson(moneda),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse('url de la imagen a subir');
    final mineType = mime(imagen.path).split('/');
    //con el split divido entre imagen y path
    //por ejemplo: imagen/jpg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mineType[0], mineType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
