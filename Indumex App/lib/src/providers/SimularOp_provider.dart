import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:formvalidation/src/bloc/simular_bloc.dart';
import 'package:formvalidation/src/models/Moneda_model.dart';
import 'package:formvalidation/src/models/SimularOp_model.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';
import 'package:formvalidation/src/utils/url_api.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
export 'package:formvalidation/src/models/SimularOp_model.dart';

class SimularOpProvider extends InheritedWidget {
  static SimularOpProvider _instancia;

  factory SimularOpProvider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new SimularOpProvider._internal(
          key: key,
          child:
              child); //creo el constructor privado par aqu eno se inicialice desde afuera
    }

    return _instancia;
  }

  SimularOpProvider._internal({Key key, Widget child})
      : super(
            key: key, //es el mismo key al igual qu eel child
            child:
                child); // es un identificador unico del widget osea que dentro de mi inheritWidget voy a meter un widget child

  final simularOpBloc =
      SimularBloc(); // es una propiedad de instancia de login bloc

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      true; // esto es para que se actualice todo el dia.

  static SimularBloc of(BuildContext context) {
    //metodo estatico of y el build context es el arbol de widgets el of busca dentro del arbol del context
    //print(context);

    return context
        .dependOnInheritedWidgetOfExactType<SimularOpProvider>()
        .simularOpBloc; //el inheritedWidget cambio por el dependoOnInheritedWidgetOf....

    //ahi se cae
  }

  Future<bool> enviarSimulacionOp(
      MonedaModel monedaTengo,
      MonedaModel monedaQuiero,
      double importeTengo,
      double importeQuiero,
      double tcAplicado,
      UsuarioModel usuario,
      BuildContext context) async {
    SimularOpModel modeloSimularOp = new SimularOpModel();
    final blocSimular = SimularOpProvider.of(context);

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

    //dale ahi ,
    //segui mirando queres, tengo que largar un rato
    //tiene else?
    //hasta ahi no llega. se cae al principio

    final decodedData = json.decode(resp.body);

    modeloSimularOp = SimularOpModel.fromJson(decodedData);
    print(decodedData);
    blocSimular.changeSimularOp(modeloSimularOp);
    if (resp.statusCode == 400) return false; //null;

    // if (importeTengo == 0) {
    //   bloc.simularOP.importeTengo;
    // } else {
    //   return modelo.importeTengo;
    // }

    return true; //blocSimular.simularOP;
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
