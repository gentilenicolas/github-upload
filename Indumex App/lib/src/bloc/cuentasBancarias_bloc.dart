
import 'package:formvalidation/src/models/cuentas_bancarias_model.dart';
import 'package:rxdart/rxdart.dart';

class CuentasBancariasBloc {
  final _cuentasController = BehaviorSubject<CuentasBancariasModel>();


 // Insertar  o enviar valores al Stream .sink
  Function(CuentasBancariasModel) get changeCuentasBancarias => _cuentasController.sink.add;

  CuentasBancariasModel get cuentasBancarias => _cuentasController.value;

  dispose() {_cuentasController?.close();
  }
}
