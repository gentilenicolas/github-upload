// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Sucursales(),
//     );
//   }
// }

// class Sucursales extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<Sucursales> {
//   String _selected;
//   List<Map> _myJson = [
//     {"id": '1', "image": "assets/images/uruguay.png", "name": "Pesos"},
//     {"id": '2', "image": "assets/images/eeuu.png", "name": "Dólares"},
//     {"id": '3', "image": "assets/images/argentina.png", "name": "Argentinos"},
//     {"id": '4', "image": "assets/images/unionEuropea.png", "name": "Euros"},
//     {"id": '5', "image": "assets/images/brasil.png", "name": "Reales"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sucursales'),
//       ),
//       body: Center(
//         child: Container(
//           width: 101,
//           padding: EdgeInsets.all(15),
//           decoration: BoxDecoration(
//               border: Border.all(width: 1, color: Colors.grey),
//               borderRadius: BorderRadius.circular(10)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Expanded(
//                 child: DropdownButtonHideUnderline(
//                   child: ButtonTheme(
//                     alignedDropdown: true,
//                     child: DropdownButton<String>(
//                       isDense: true,
//                       //hint: new Text("Seleccione una moneda"),
//                       value: _selected,
//                       onChanged: (String newValue) {
//                         setState(() {
//                           _selected = newValue;
//                         });

//                         print(_selected);
//                       },
//                       items: _myJson.map((Map map) {
//                         return new DropdownMenuItem<String>(
//                           value: map["id"].toString(),
//                           // value: _mySelection,
//                           child: Row(
//                             children: <Widget>[
//                               Image.asset(
//                                 map["image"],
//                                 width: 25,
//                               ),
//                               Container(
//                                   //margin: EdgeInsets.only(left: 10),
//                                   child: Text('')),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/Moneycard_model.dart';
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
  MoneycardModel moneycard = new MoneycardModel();

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
                _inputSucursales('Sucursal', sucursales),
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

  Widget _inputSucursales(String titulo, List<String> lista) {
    moneycard.sucursalRetiro = opcionSeleccionadaSucursal;

    return Container(
     
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: 20.0,
              ),
              DropdownButton(
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  value: opcionSeleccionadaSucursal,
                  items: funciones.obtenerValorDelDropdownList(lista),
                  onChanged: (opt) {
                    setState(() {
                      opcionSeleccionadaSucursal = opt;
                      moneycard.sucursalRetiro = opt;
                    });
                  })
            ],
          ),
        ),
    
    );
  }

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
