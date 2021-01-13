import 'package:formvalidation/src/models/SimularOp_model.dart';
import 'package:rxdart/rxdart.dart';

class SimularBloc {
  final _simularController = BehaviorSubject<SimularOpModel>();

  Function(SimularOpModel) get changeUsuario => _simularController.sink.add;

  SimularOpModel get usuario => _simularController.value;

  dispose() {
  
    _simularController?.close();
  }
}
