import 'package:formvalidation/src/models/SimularOp_model.dart';
import 'package:rxdart/rxdart.dart';

class SimularBloc {
  final _simularController = BehaviorSubject<SimularOpModel>();


 // Insertar  o enviar valores al Stream .sink
  Function(SimularOpModel) get changeSimularOp => _simularController.sink.add;

  SimularOpModel get simularOP => _simularController.value;

  dispose() {
  
    _simularController?.close();
  }
}
