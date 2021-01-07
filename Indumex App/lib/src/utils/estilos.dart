import 'package:flutter/material.dart';

// estilos Home

//gradiente fondo de home

final Color gradientStart = Colors.blue[700];
final Color gradientEnd = Colors.blue[500];
/* esto va dentro de un widget mas los grandientes de arriba.
  return Container(
    child: Center(child: Center()),
    decoration: new BoxDecoration(
      gradient: new LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: const FractionalOffset(0.5, 0.0),
          end: const FractionalOffset(0.0, 0.5),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    ),
  );
*/


final textoTabla = new TextStyle(fontSize: 18, color: Colors.white);

final textoBotones = new TextStyle(
  fontSize: 22,
  color: Colors.white,
);

final valoresNumericosTabla = new TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

final monedasTabla = new TextStyle(
  fontSize: 25,
  //fontWeight: FontWeight.bold,
  color: Colors.white /*.withOpacity(0.6)*/,
);

//estilos solicitud Moneycard

//estilos solicitar op
