/*import 'dart:io';
import 'package:connectivity/connectivity.dart';

  class DataConnectionChecker {

main() async {
  // Simple check to see if we have internet
  print("'el equipo que esta conectado' es: ");
  print(await DataConnectionChecker().hasCon.nection);
  // returns a bool

  // We can also get an enum value instead of a bool
  print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected
  
    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");
  
    // actively listen for status updates
    // this will cause DataConnectionChecker to check periodically
    // with the interval specified in DataConnectionChecker().checkInterval
    // until listener.cancel() is called
    var listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
          print('Estas desconectado de internet');
          break;
      }
    });
  
    // close listener after 30 seconds, so the program doesn't run forever
    await Future.delayed(Duration(seconds: 30));
    await listener.cancel();
  }
}


*/