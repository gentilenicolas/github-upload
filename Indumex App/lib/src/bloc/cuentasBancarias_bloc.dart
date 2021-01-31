
import 'package:formvalidation/src/models/Cuenta_bancaria_model.dart';

import 'package:rxdart/rxdart.dart';

class CuentasBancariasBloc {
  final _cuentasController = BehaviorSubject<CuentaBancariaModel>();


 // Insertar  o enviar valores al Stream .sink
  Function(CuentaBancariaModel) get changeCuentasBancarias => _cuentasController.sink.add;

  CuentaBancariaModel get cuentasBancarias => _cuentasController.value;

  dispose() {_cuentasController?.close();
  }
}
