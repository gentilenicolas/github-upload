import 'dart:convert';
import 'package:formvalidation/src/models/Departamentos_model.dart';
import 'package:formvalidation/src/models/EstadoCivil_model.dart';
import 'package:formvalidation/src/models/Localidades_model.dart';
import 'package:formvalidation/src/models/Moneycard_model.dart';
import 'package:formvalidation/src/models/PaisNacimiento_model.dart';
import 'package:formvalidation/src/models/Sexo_model.dart';
import 'package:formvalidation/src/models/Sucursales_model.dart';
import 'package:formvalidation/src/models/TipoDocumento_model.dart';
import 'package:formvalidation/src/utils/url_api.dart';
import 'package:http/http.dart' as http;

class MoneycardProvider {
  //para hacer un post, siempre envias un objeto convertido a json
  //entonces lo recibo y para enviarlo lo convierto

  Future<bool> crearMoneycard(MoneycardModel modelo) async {
    //urlApi = 'http://localhost:44322/api';

    final url = '$urlApi/MoneyCard';

    //try {
    final resp = await http.post(url,
        body: moneycardModelToJson(modelo),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    final decodedData = json.decode(resp.body);

    print(decodedData);

    if (resp.statusCode == 400) return false;

    return true;
    //} catch (e) {
    //  print(e);
    //  return false;
    // }
  }

  Future<List<String>> obtenerTiposDeDocumentos() async {
    final url = '$urlApi/TipoDocumento';

    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<TipoDocumentoModel> listaModel = new List();
    final List<String> listaString = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dato) {
      final datoTemp = TipoDocumentoModel.fromJson(dato);
      listaModel.add(datoTemp);
    });

    listaModel.forEach((dato) {
      listaString.add(dato.descripcion);
    });

    return listaString;
  }

  Future<List<String>> obtenerPaisNacimiento() async {
    final url = '$urlApi/PaisNacimiento';

    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<PaisNacimientoModel> listaModel = new List();
    final List<String> listaString = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dato) {
      final datoTemp = PaisNacimientoModel.fromJson(dato);
      listaModel.add(datoTemp);
    });

    listaModel.forEach((dato) {
      listaString.add(dato.descripcion);
    });

    return listaString;
  }

  Future<List<String>> obtenerSexos() async {
    final url = '$urlApi/Sexo';

    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<SexoModel> listaModel = new List();
    final List<String> listaString = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dato) {
      final datoTemp = SexoModel.fromJson(dato);
      listaModel.add(datoTemp);
    });

    listaModel.forEach((dato) {
      listaString.add(dato.descripcion);
    });

    return listaString;
  }

  Future<List<String>> obtenerEstadoCivil() async {
    final url = '$urlApi/EstadoCivil';

    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<EstadoCivilModel> listaModel = new List();
    final List<String> listaString = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dato) {
      final datoTemp = EstadoCivilModel.fromJson(dato);
      listaModel.add(datoTemp);
    });

    listaModel.forEach((dato) {
      listaString.add(dato.descripcion);
    });

    return listaString;
  }

  Future<List<String>> obtenerSucursales() async {
    final url = '$urlApi/sucursal?agrupadas=true';

    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<SucursalesModel> listaModel = new List();
    final List<String> listaString = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dato) {
      final datoTemp = SucursalesModel.fromJson(dato);
      listaModel.add(datoTemp);
    });

    listaModel.forEach((dato) {
      listaString.add(dato.descripcion);
    });

    return listaString;
  }

  Future<List<String>> obtenerDepartamentos() async {
    final url = '$urlApi/Departamento';

    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<DepartamentosModel> listaModel = new List();
    final List<String> listaString = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dato) {
      final datoTemp = DepartamentosModel.fromJson(dato);
      listaModel.add(datoTemp);
    });

    listaModel.forEach((dato) {
      listaString.add(dato.descripcion);
    });

    return listaString;
  }

  Future<List<DepartamentosModel>> obtenerDepartamentosModel() async {
    final url = '$urlApi/Departamento';

    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<DepartamentosModel> listaModel = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dato) {
      final datoTemp = DepartamentosModel.fromJson(dato);
      listaModel.add(datoTemp);
    });

    return listaModel;
  }

  Future<List<LocalidadesModel>> obtenerLocalidades() async {
    final url = '$urlApi/localidad';

    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<LocalidadesModel> listaModel = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dato) {
      final datoTemp = LocalidadesModel.fromJson(dato);
      listaModel.add(datoTemp);
    });
    return listaModel;
  }
}
