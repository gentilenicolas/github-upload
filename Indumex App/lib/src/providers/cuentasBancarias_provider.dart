import 'dart:async';
import 'dart:convert';
import 'package:formvalidation/src/models/cuentas_bancarias_model.dart';
import 'package:formvalidation/src/utils/url_api.dart';
import 'package:http/http.dart' as http;
export 'package:formvalidation/src/models/cuentas_bancarias_model.dart';

 class CuentasBancariasProvider 
//extends InheritedWidget 
{



  Future<List<String>> obtenerCuentasBancacias() async {
    final url = '$urlApi/CuentasBancarias';

    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<CuentasBancariasModel> listaModel = new List();
    final List<String> listaString = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dato) {
      final datoTemp = CuentasBancariasModel.fromJson(dato);
      listaModel.add(datoTemp);
    });

       return listaString;
  }


  //si tuvieramos que enviarles lkas cuentas descomentamos esto de abajo
  // static CuentasBancariasProvider _instancia;

  // factory CuentasBancariasProvider({Key key, Widget child}) {
  //   if (_instancia == null) {
  //     _instancia = new CuentasBancariasProvider._internal(key: key, child: child);
  //   }

  //   return _instancia;
  // }

  // CuentasBancariasProvider._internal({Key key, Widget child})
  //     : super(key: key, child: child);

  // final cuentasBancariasBloc = CuentasBancariasBloc();

  // @override
  // bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // static CuentasBancariasBloc of(BuildContext context) {
  //   return context
  //       .dependOnInheritedWidgetOfExactType<CuentasBancariasProvider>()
  //       .cuentasBancariasBloc;
  // }

  // Future<bool> enviarCuentasBancarias(
  //     CuentasBancariasModel id,
  //     CuentasBancariasModel idbanco,
  //     CuentasBancariasModel nroCuenta ,
  //     CuentasBancariasModel nombreBenef,
  //     CuentasBancariasModel idMoneda,
  //     CuentasBancariasModel alias,

    
  //     BuildContext context) async {


  //   CuentasBancariasModel modeloCuentasBancacias = new CuentasBancariasModel();
  //   final blocCuentasBancarias = CuentasBancariasProvider.of(context);

  //   //final url = '$urlApi/CuentasBancacias';
  //   // final resp = await http.post(url,
  //   //     body: cuentasModelToJson(   new CuentasBancariasModel(id: id,
  //   //                                 idbanco: idbanco, 
  //   //                                 nroCta: nroCuenta,
  //   //                                 nombreBeneficiario: nombreBenef,
  //   //                                 idMoneda: idMoneda,
  //   //                                 alias: alias ,
  //   //                                 )),
  //   //     headers: <String, String>{
  //   //       'Content-Type': 'application/json; charset=UTF-8'
  //   //     });
  //   // if (resp.statusCode == 400) return false;
  //   // final decodedData = json.decode(resp.body);
  //   //modeloCuentasBancacias = CuentasBancariasModel.fromJson(decodedData);

  //   blocCuentasBancarias.changeCuentasBancarias(modeloCuentasBancacias);

  //   return true;
  // }
}


