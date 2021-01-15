import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:formvalidation/src/bloc/realizarOp_bloc.dart';
import 'package:formvalidation/src/models/Moneda_model.dart';
import 'package:formvalidation/src/models/RealizarOp_model.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';
import 'package:formvalidation/src/utils/url_api.dart';
import 'package:http/http.dart' as http;
export 'package:formvalidation/src/models/SimularOp_model.dart';

class RealizarOpProvider extends InheritedWidget {
  static RealizarOpProvider _instancia;

  factory RealizarOpProvider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new RealizarOpProvider._internal(
          key: key,
          child:
              child); //creo el constructor privado par aqu eno se inicialice desde afuera
    }

    return _instancia;
  }

  RealizarOpProvider._internal({Key key, Widget child})
      : super(
            key: key, 
            child:
                child); 

  final realizarOpBloc =RealizarOpBloc(); 

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      true; 

  static RealizarOpBloc of(BuildContext context) {


    return context.dependOnInheritedWidgetOfExactType<RealizarOpProvider>().realizarOpBloc; //el inheritedWidget cambio por el dependoOnInheritedWidgetOf....

  
  }

  Future<bool> enviarRealizarOp(
      MonedaModel monedaTengo,
      MonedaModel monedaQuiero,
      double importeTengo,
      double importeQuiero,
      double tcAplicado,
      UsuarioModel usuario,
      BuildContext context) async {
    RealizarOpModel modeloRealizarOp = new RealizarOpModel();
    final blocRealizar = RealizarOpProvider.of(context);

    final url = '$urlApi/SimularOp';

    final resp = await http.post(url,
        
        body: realizarOpModelToJson(new RealizarOpModel(
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

    modeloRealizarOp = RealizarOpModel.fromJson(decodedData);
    print(decodedData);
    blocRealizar.changeRealizarOp(modeloRealizarOp);
    if (resp.statusCode == 400) return false; //null;

    
    return true; 
  }

}