import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/Sucursales_model.dart';
import 'package:formvalidation/src/utils/funciones.dart' as funciones;
import 'package:formvalidation/src/utils/juego_pruebas.dart';


void main() => runApp(Sucursales());

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<Sucursales> {
//   String _selected;
class Sucursales extends StatefulWidget {
  @override
  _Sucursales createState() => _Sucursales();
}

//class Sucursales extends StatelessWidget {

class _Sucursales extends State<Sucursales> with ChangeNotifier {
 // SucursalesModel sucursal = new SucursalesModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sucursales',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          actions: <Widget>[],
          title: Image(
            image: AssetImage('assets/images/indumex-logo.png'),
            width: 200,
          ),
        ),
        body: Row(
          children: [
            Column(
              children: [
              //  _inputSucursales('Sucursal', sucursalesId),
                imagen(),
              ],
            ),
          ],
        ),
        // decoration: new BoxDecoration(
        //   gradient: new LinearGradient(
        //       colors: [estilos.gradientStart, estilos.gradientEnd],
        //       begin: const FractionalOffset(0.5, 0.0),
        //       end: const FractionalOffset(0.0, 0.5),
        //       stops: [0.0, 1.0],
        //       tileMode: TileMode.clamp),
        // ),
      ),
    );
  }

  // Widget _inputSucursales(String titulo, List<int> lista) {
  //   sucursal.id = sucursalSeleccionada;

  //   return Container(
     
  //       child: Center(
  //         child: Row(
  //           children: [
  //             SizedBox(
  //               width: 20.0,
  //             ),
  //             DropdownButton(
  //                 style: TextStyle(fontSize: 15, color: Colors.black),
  //                 value: sucursalSeleccionada,
  //                 items: funciones.obtenerValorDelDropdownList(lista),
  //                 onChanged: (opt) {
  //                   setState(() {
  //                     sucursalSeleccionada = opt;
  //                     sucursal.id = opt;
  //                   });
  //                 })
  //           ],
  //         ),
  //       ),
    
  //   );
  // }

  Widget imagen() {
    return Container(
      child: Card(
        child: Center(
          child: Image(
            image: AssetImage('assets/images/sucursales.PNG'),
            fit: BoxFit.contain,
            //fadeOutDuration: Duration(milliseconds: 9000),
            //fadeInDuration: Duration(milliseconds: 1000),
            height: 100,
            width: 170,
          ),
        ),
      ),
    );
  }
}
