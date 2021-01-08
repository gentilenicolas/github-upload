import 'package:flutter/material.dart';
import 'package:formvalidation/src/pages/Moneda_page.dart';
import 'package:formvalidation/src/pages/ayuda_page.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/paginaVacia.dart';
import 'package:formvalidation/src/pages/productos_page.dart';
import 'package:formvalidation/src/pages/realizar_op.dart';
import 'package:formvalidation/src/pages/registro_cliente.dart';
import 'package:formvalidation/src/pages/solicitud_moneycard.dart';


//metodo que contiene todas las redirecciones a las paginas de la aplicacion para que no queden en el Main

Map<String, WidgetBuilder> getApplicatiosnRoutes() {
  
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'moneda': (BuildContext context) => MonedaPage(),
    'solicitudMoneyCard': (BuildContext context) => SolicitudMoneycard(),
    'realizarOp': (BuildContext context) => RealizarOp(),
    'ayuda': (BuildContext context) => Ayuda(),
    'registro':(BuildContext context) => RegistroCliente(),
    'productos': (BuildContext context) => Productos(),
   // 'logout': (BuildContext context) => LogOut(),
    'paginaPruebas': (BuildContext context) => PaginaVacia(),
    
  };
}
