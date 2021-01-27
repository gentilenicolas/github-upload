import 'dart:async';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/sucursales_page.dart';
import 'package:formvalidation/src/pages/tranfe_money_page.dart';
import 'package:formvalidation/src/pages/transfe_brou_page.dart';
import 'package:formvalidation/src/providers/SimularOp_provider.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/utils/alertas.dart';
import 'package:formvalidation/src/utils/widgets.dart' as master;

/*void main() async {
  final prefs = new PreferenciasLogin();
  await prefs.initPrefs();
  if (prefs.nombre != null) {
    runApp(RealizarOp());
  }
  //luego de que se autentica y esta todo ok deberia de mostrar a realizar operacion
}*/

class RealizarOp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);
    final size = MediaQuery.of(context).size;
    final blocSimular = SimularOpProvider.of(context);

    //final _prefs = new PreferenciasUsuario();
    //  print (_prefs.nombre);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[],
        title: Image(
          image: AssetImage('assets/images/indumex-logo.png'),
          width: 200,
        ),
      ),
      //fondo gradiente
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              //_contenidoRealizarOp(context , bloc)/*
              _tiposDeCambio(bloc, context),
              SizedBox(
                width: size.width * 0.15,
              ),
              // Text('RESUMEN DE OPERACION',
              //     style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              SizedBox(height: 15.0),
              _resumenOp(bloc),

              SizedBox(height: 10.0),
              Text('FORMAS DE PAGO',
                  style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              SizedBox(height: 10.0),
              _formasDePago(bloc),
             
           
            ],
          ), /*
        //decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [estilos.gradientStart, estilos.gradientEnd],
              begin: const FractionalOffset(0.5, 0.0),
              end: const FractionalOffset(0.0, 0.5),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
       // ),*/
        ),
      ),

      // bottomNavigationBar: _bottomNavigationBar(),
      endDrawer: master.menuDrawer(context, bloc),
    );
  }

//contenedor info tipos de cambio (card)
  Widget _tiposDeCambio(LoginBloc bloc, BuildContext context) {
    // final usr = bloc.usuario;

    //mostrarAlerta(context, "Debe loguearce para realizar esta accción");

    return Center(
      child: Card(
        elevation: 24.0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ListTile(
                title: Text('Moneda :' /*+ usr.nombreCompleto*/),
                subtitle: Text('Cotizaciones para distinto tipo de usuario:'),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tc pizarra : xxxxhhhhhxxxxxxxxxx",
                          style: TextStyle(fontSize: 15)),
                    ),
                    Padding(
                      child: Text("Tc cliente : xxddddddffffrrrrrxxxxxxxx",
                          style: TextStyle(fontSize: 15)),
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tc moneycard :xrrrxxffffffffssssxxx",
                          style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

//contenedor resumen de operacion
  Widget _resumenOp(LoginBloc bloc) {
    return Center(
      child: Card(
        elevation: 24.0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
               Text('RESUMEN DE OPERACION',
                  style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              ListTile(
                title: Text('Entrego y recibo :' /*+ usr.nombreCompleto*/),
                              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tc pizarra : xxxxhhhhhxxxxxxxxxx",
                          style: TextStyle(fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tc moneycard :xrrrxxffffffffssssxxx",
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  //contenedor botones tipo op
  Widget _formasDePago(LoginBloc bloc) {
    return Card(
      elevation: 24.0,
      child: Container(
         margin: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: <Widget>[
          Row(
            children: [
              _crearBotonTipoLiquidacionMoney(bloc),
              _crearBotonTipoLiquidacionReturarSuc(bloc),
              _crearBotonTipoLiquidacionTransf(bloc),
            ],
          )
        ]),
      ),
    );
  }

 
  _contenidoRealizarOp(BuildContext context, LoginBloc bloc) {
    // final prefs = new PreferenciasUsuario();
    // await prefs.initPrefs();
    final usr = bloc.usuario;
    //este metodo creo no lo estoy llamando todavia.

    if (usr != null) {
      return ListView(
        padding: EdgeInsets.all(25),
        children: <Widget>[
          SizedBox(height: 30.0),
          _tiposDeCambio(bloc, context),
          SizedBox(height: 30.0),
          _resumenOp(bloc),
        ],
      );
    } else {
      mostrarAlerta1(
          context, "Debe estar logueado para realizar una operación");
      return scheduleMicrotask(() => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage())));
    }

    //else return Container (child: Text('Debe de estar logueado para poder realizar operaciones'));
  }

  //botones tipos de liquidacion
  //liquidacion por medio de moneycard

  Widget _crearBotonTipoLiquidacionMoney(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Flexible(
          flex: 4,
          child: Container(
            child: Column(
              children: <Widget>[
                MaterialButton(
                    shape: CircleBorder(
                        side: BorderSide(
                            width: 1,
                            color: Colors.orange[600],
                            style: BorderStyle.solid)),
                    elevation: 24.0,
                    color: Colors.orange[500],
                    textColor: Colors.white,
                    child: Icon(
                      Icons.credit_card,
                      size: 25.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TranfMoney()),
                      );
                    }),
                Text('Deposito Moneycard'),
              ],
            ),

            width: 100,
            height: 100,
            alignment: Alignment.center,

            //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          ),
        );
      },
    );
  }
  //liquidacion por surcursal

  Widget _crearBotonTipoLiquidacionReturarSuc(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Flexible(
          flex: 4,
          child: Container(
            child: Column(
              children: <Widget>[
                MaterialButton(
                    shape: CircleBorder(
                        side: BorderSide(
                            width: 1,
                            color: Colors.orange[600],
                            style: BorderStyle.solid)),
                    elevation: 24.0,
                    color: Colors.orange[500],
                    textColor: Colors.white,
                    child: Icon(
                      Icons.map,
                     size: 25.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sucursales()),
                      );
                    }),
                Text('Retirar por sucursal'),
              ],
            ),

            width: 100,
            height: 100,
            alignment: Alignment.center,

            //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          ),
        );
      },
    );
  }

//liquidacion por transferencia brou
  Widget _crearBotonTipoLiquidacionTransf(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Flexible(
          flex: 4,
          child: Container(
            child: Column(
              children: <Widget>[
                MaterialButton(
                    shape: CircleBorder(
                        side: BorderSide(
                            width: 1,
                            color: Colors.orange[600],
                            style: BorderStyle.solid)),
                    elevation: 24.0,
                    color: Colors.orange[500],
                    textColor: Colors.white,
                    child: Icon(
                      Icons.credit_card,
                      size: 25.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TranfBrou()),
                      );
                    }),
                Text('Transferencia bancaria'),
              ],
            ),

            width: 100,
            height: 100,
            alignment: Alignment.center,

            //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          ),
        );
      },
    );
  }

/*
 Function _habilitarBotonesTransaccion() {
    if (     ) {
      return null;
    } else {
      return () {
       
      };
    }
  }
*/

  // navigationBar
  Widget _bottomNavigationBar() {
    return Container(
      //alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.orange[50],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Algo',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Algo',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Login',
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:formvalidation/src/bloc/simular_bloc.dart';
// import 'package:formvalidation/src/models/Usuario_model.dart';
// import 'package:formvalidation/src/pages/login_page.dart';
// import 'package:formvalidation/src/pages/sucursales_page.dart';
// import 'package:formvalidation/src/pages/tranfe_money_page.dart';
// import 'package:formvalidation/src/pages/transfe_brou_page.dart';
// import 'package:formvalidation/src/providers/SimularOp_provider.dart';
// import 'package:formvalidation/src/providers/login_provider.dart';
// import 'package:formvalidation/src/utils/alertas.dart';
// import 'package:formvalidation/src/utils/widgets.dart' as master;
// import 'package:formvalidation/src/utils/estilos.dart' as estilos;

// /*void main() async {
//   final prefs = new PreferenciasLogin();

//   await prefs.initPrefs();
//   if (prefs.nombre != null) {
//     runApp(RealizarOp());
//   }

//   //luego de que se autentica y esta todo ok deberia de mostrar a realizar operacion
// }*/

// class RealizarOp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //final blocLogin = LoginProvider.of(context);
//     final blocLogin = LoginBloc();
//     final simularBl = SimularOpProvider.of(context);
//     final size = MediaQuery.of(context).size;

//     //final _prefs = new PreferenciasUsuario();
//     //  print (_prefs.nombre);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         actions: <Widget>[],
//         title: Image(
//           image: AssetImage('assets/images/indumex-logo.png'),
//           width: 200,
//         ),
//       ),
//       //fondo gradiente
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           child: Column(
//             children: <Widget>[
//               //_contenidoRealizarOp(context , bloc)/*
//               _tiposDeCambio(blocLogin, context, simularBl),
//               SizedBox(
//                 width: size.width * 0.10,
//               ),
//               SizedBox(height: 10.0),
//               Center(
//                 child: Text('RESUMEN DE OPERACION',
//                     style: TextStyle(color: Colors.white, fontSize: 20.0)),
//               ),
//               SizedBox(height: 10.0),
//               _resumenOp(blocLogin),
//               Center(
//                 child: Text('FORMAS DE PAGO',
//                     style: TextStyle(color: Colors.white, fontSize: 20.0)),
//               ),

//               Center(
//                 child: Row(
//                   children: [
//                     SizedBox(height: 10.0),
//                     // _formasDePago(blocLogin),
//                     _crearBotonTipoLiquidacionReturarSuc(blocLogin),
//                     _crearBotonTipoLiquidacionMoney(blocLogin),
//                     _crearBotonTipoLiquidacionTransf(blocLogin),
//                     prueba(),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 10.0),
//               _btnRealizarOp(context),
//             ],
//           ),
//           decoration: new BoxDecoration(
//             gradient: new LinearGradient(
//                 colors: [estilos.gradientStart, estilos.gradientEnd],
//                 begin: const FractionalOffset(0.5, 0.0),
//                 end: const FractionalOffset(0.0, 0.5),
//                 stops: [0.0, 1.0],
//                 tileMode: TileMode.clamp),
//           ),
//         ),
//       ),

//       bottomNavigationBar: _bottomNavigationBar(),
//       endDrawer: master.menuDrawer(context, blocLogin),
//     );
//   }

// //validarion usuario

//   // UsuarioModel _existeUsuario(
//   //     LoginBloc bloc, BuildContext context, SimularBloc blSimular) {
//   //       print(bloc.usuario);
//   //   if (bloc != null) {
//   //     _tiposDeCambio(bloc, context, blSimular);
//   //   } else {
//   //     mostrarAlerta(context, 'Debe estar logueado para realizar la operacion');
//   //     // Navigator.push(
//   //     //     context, MaterialPageRoute(builder: (context) => LoginPage()));
//   //   }
//   // }

// //contenedor info tipos de cambio (card)
//   Widget _tiposDeCambio(LoginBloc bloc, BuildContext context, SimularBloc simularBloc) {
//    // final usr = _existeUsuario(bloc, context, simularBloc);

//     // if (usr == null) {
//     //   // usr.nombreCompleto = "";
//     //   mostrarAlerta(context, "");
//     // } else {
//       return Card(
//         elevation: 24.0,
//         child: Column(children: <Widget>[
//           ListTile(
//             title: Text('Moneda :' /*+ usr.nombreCompleto*/),
//             subtitle: Text('para abajo los distintos tipos de cambio'),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text("Tc pizarra : XXXXXXXXXXX", textAlign: TextAlign.start),
//                   SizedBox(height: 5.0),
//                   Text("Tc cliente : XXXXXXXXXXX"),
//                   SizedBox(height: 5.0),
//                   Text("Tc moneycard : XXXXXXXXXX"),
//                   SizedBox(height: 5.0),
//                 ],
//               )
//             ],
//           )
//         ]),
//       );
//     }
//   }

// //contenedor resumen de operacion
//   Widget _resumenOp(LoginBloc bloc) {
//     return Card(
//       elevation: 24.0,
//       child: Column(children: <Widget>[
//         ListTile(
//           title: Text('Resumen de operacion'),
//           subtitle: Text('resumen'),
//         ),
//         Column(
//           children: <Widget>[
//             Column(
//               children: [
//                 SizedBox(height: 5.0),
//                 Text("Entrega :XXXXXXXXX"),
//                 SizedBox(height: 5.0),
//                 Text("Tipo de cambio :XXXXXXXX "),
//                 SizedBox(height: 10.0),
//                 SizedBox(height: 5.0),
//               ],
//             )
//           ],
//         ),
//       ]),
//     );
//   }

//   Widget _formasDePago(LoginBloc bloc) {
//     return Container(
//       child: Card(
//         elevation: 24.0,
//         child: Column(children: <Widget>[
//           ListTile(
//             title: Text('Excoja forma de pago '),
//           ),
//           Column(
//             children: <Widget>[
//               Column(
//                 children: [],
//               )
//             ],
//           ),
//           Column(
//             children: [
//               // _crearBotonTipoLiquidacionReturarSuc(bloc),
//               // _crearBotonTipoLiquidacionTransf(bloc),
//               // _crearBotonTipoLiquidacionMoney(bloc),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }

//   //botones tipos de liquidacion
//   //liquidacion por medio de moneycard

// Widget _crearBotonTipoLiquidacionMoney(LoginBloc bloc) {
//   return StreamBuilder(
//     stream: bloc.formValidStream,
//     builder: (BuildContext context, AsyncSnapshot snapshot) {
//       return Flexible(
//         flex: 4,
//         child: Container(
//           child: Column(
//             children: <Widget>[
//               MaterialButton(
//                   shape: CircleBorder(
//                       side: BorderSide(
//                           width: 1,
//                           color: Colors.orange[600],
//                           style: BorderStyle.solid)),
//                   elevation: 24.0,
//                   color: Colors.orange[500],
//                   textColor: Colors.white,
//                   child: Icon(
//                     Icons.credit_card,
//                     size: 20.0,
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => TranfMoney()),
//                     );
//                   }),
//               Text('Deposito Moneycard'),
//             ],
//           ),

//           width: 100,
//           height: 100,
//           alignment: Alignment.center,

//           //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
//         ),
//       );
//     },
//   );
// }

//   //liquidacion por surcursal

//   Widget _crearBotonTipoLiquidacionReturarSuc(LoginBloc bloc) {
//     return StreamBuilder(
//       stream: bloc.formValidStream,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         return Flexible(
//           flex: 4,
//           child: Container(
//             child: Column(
//               children: <Widget>[
//                 MaterialButton(
//                     shape: CircleBorder(
//                         side: BorderSide(
//                             width: 1,
//                             color: Colors.orange[600],
//                             style: BorderStyle.solid)),
//                     elevation: 24.0,
//                     color: Colors.orange[500],
//                     textColor: Colors.white,
//                     child: Icon(
//                       Icons.store,
//                       size: 20.0,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Sucursales()),
//                       );
//                     }),
//                 Text('Retirar por sucursal'),
//               ],
//             ),

//             width: 100,
//             height: 100,
//             alignment: Alignment.center,

//             //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
//           ),
//         );
//       },
//     );
//   }

// //liquidacion por transferencia brou
//   Widget _crearBotonTipoLiquidacionTransf(LoginBloc bloc) {
//     return StreamBuilder(
//       stream: bloc.formValidStream,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         return Flexible(
//           flex: 4,
//           child: Container(
//             child: Column(
//               children: <Widget>[
//                 MaterialButton(
//                     shape: CircleBorder(
//                         side: BorderSide(
//                             width: 1,
//                             color: Colors.orange[600],
//                             style: BorderStyle.solid)),
//                     elevation: 24.0,
//                     color: Colors.orange[500],
//                     textColor: Colors.white,
//                     child: Icon(
//                       Icons.comment_bank,
//                       size: 20.0,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => TranfBrou()),
//                       );
//                     }),
//                Text('Transferencia bancaria'),
//                   ],
//             ),

//             width: 100,
//             height: 100,
//             alignment: Alignment.center,

//             //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
//           ),
//         );
//       },
//     );
//   }

//   Widget prueba() {
//     return Container(
//       margin: EdgeInsets.all(8.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(8.0))),
//         child: InkWell(
//           onTap: () => print("Chau"),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch, // add this
//             children: <Widget>[
//               ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8.0),
//                   topRight: Radius.circular(8.0),
//                 ),
//                 child: Image.network('https://placeimg.com/640/480/any',
//                     // width: 300,
//                     height: 150,
//                     fit: BoxFit.fill),
//               ),
//               ListTile(
//                 title: Text('Pub 1'),
//                 subtitle: Text('Location 1'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// /*
//  Function _habilitarBotonesTransaccion() {
//     if (     ) {
//       return null;
//     } else {
//       return () {

//       };
//     }
//   }
// */

//   // navigationBar
//   Widget _bottomNavigationBar() {
//     return Container(
//       //alignment: Alignment.bottomCenter,
//       margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: BottomNavigationBar(
//         backgroundColor: Colors.orange[50],
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//         elevation: 0,
//         items: [
//           new BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           new BottomNavigationBarItem(
//             icon: Icon(Icons.local_activity),
//             label: 'Algo',
//           ),
//           new BottomNavigationBarItem(
//             icon: Icon(Icons.inbox),
//             label: 'Algo',
//           ),
//           new BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Login',
//           ),
//         ],
//       ),
//     );
//   }

// //
//   _contenidoRealizarOp(
//       BuildContext context, LoginBloc bloc, SimularBloc simula) {
//     // final prefs = new PreferenciasUsuario();
//     // await prefs.initPrefs();
//     final usr = bloc.usuario;

//     if (usr.id != null) {
//       return ListView(
//         padding: EdgeInsets.all(25),
//         children: <Widget>[
//           SizedBox(height: 30.0),
//          // _tiposDeCambio(bloc, context, simula),
//           SizedBox(height: 30.0),
//           _resumenOp(bloc),
//         ],
//       );
//     } else {
//       mostrarAlerta1(
//           context, "Debe estar logueado para realizar una operación");
//       return /*scheduleMicrotask(() =>*/ Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => LoginPage()));
//     }

//     //else return Container (child: Text('Debe de estar logueado para poder realizar operaciones'));
//   }
