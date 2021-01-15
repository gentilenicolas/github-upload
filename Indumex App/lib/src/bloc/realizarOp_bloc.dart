import 'package:formvalidation/src/models/RealizarOp_model.dart';

import 'package:rxdart/rxdart.dart';

class RealizarOpBloc {
  final _realizarController = BehaviorSubject<RealizarOpModel>();


 // Insertar  o enviar valores al Stream .sink
  Function(RealizarOpModel) get changeRealizarOp => _realizarController.sink.add;

  RealizarOpModel get realizarOP => _realizarController.value;

  dispose() {
  
    _realizarController?.close();
  }
}
