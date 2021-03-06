import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/simular_bloc.dart';
import 'package:formvalidation/src/pages/cobrar_tranf_page.dart';
import 'package:formvalidation/src/providers/SimularOp_provider.dart';
import 'package:formvalidation/src/providers/cuentasBancarias_provider.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/utils/alertas.dart';
import 'package:formvalidation/src/utils/widgets.dart' as master;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TranfBrou extends StatelessWidget {
  final cuentasBancariasProvider = new CuentaBancariaProvider();

  @override
  Widget build(BuildContext context) {
//final blocCb = CuentaBancariaProvider.of(context);
    final blocUsuario = LoginProvider.of(context);
    final blocSimular = SimularOpProvider.of(context);

    return MaterialApp(
      title: 'Tranfe Brou',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Transferencia a Brou'),
        ),
        body:
        SingleChildScrollView(
          child: Center(
            child: 
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  _cuentasIx(context),
                  SizedBox(
                    height: 10,
                  ),
                  _infoDepo(context, blocSimular),
                  SizedBox(
                    height: 10,
                  ),
                  _contenedorTiposDetransf(context),
                  SizedBox(
                    height: 10,
                  ),
                  _swipperTranfe(context),
                  //  _contenedorEmpresa(context),

                  //_cobrar(context),
                ],
              ),

              // child: envioComprobante(context),
            ),
         ),
       ),
        endDrawer: master.menuDrawer(context, blocUsuario),
      ),
   );
  }

//contenedor DATOS DE CUENTAS iX
  Widget _cuentasIx(BuildContext context) {
    return Card(
      elevation: 24.0,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Text("Cuentas de indumex"),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              Column(
                children: [
                  Text("Brou 'S' aa6655909"),
                  Divider(),
                  Text("Brou 'USD' 44454949"),
                  Divider(color: Colors.white),
                ],
              ),
            ]),
      ),
    );
  }

//Info depo
  Widget _infoDepo(BuildContext context, SimularBloc blSimular) {
    return Card(
      elevation: 24.0,
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: [
                  Text("Informacion para deposito"),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              Text('IMPORTE A DEPOSITAR',
                  style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              Divider(),
              Text("Debes despositar : "+ blSimular.simularOP.tcAplicado.toString() + " " +blSimular.simularOP.monedaTengo.descripcion.toString()),
              Divider(color: Colors.white),
            ]),
      ),
    );
  }

  Widget _swipperTranfe(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
   padding: EdgeInsets.only(top: 10.0),
      width : double.infinity,
      height : 200.0,
      child: Swiper(
//itemWidth: _screenSize.width * 0.8,

        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/350x150",
            fit: BoxFit.fill,
          );
        },
        itemCount: 2,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
    // return Container(
    //   padding: EdgeInsets.only(top: 10.0),
    //   child: Swiper(
    //     layout: SwiperLayout.STACK,
    //     itemWidth: _screenSize.width * 0.9,
    //     itemHeight: _screenSize.height * 0.4,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Column(
    //         children: <Widget>[
    //           Image.network(
    //             "http://via.placeholder.com/350x150",
    //             fit: BoxFit
    //                 .fill, //imagen para que se adapte a las paginas que tien
    //           ),
    //           // _pruebaCard(),
    //           //  _pruebaCard(),
    //           //  _contenedorPersona(context),
    //         ],
    //       );

    //       // return new Image.network(
    //       //   "http://via.placeholder.com/350x150",
    //       //   fit: BoxFit.fill, //imagen para que se adapte a las paginas que tien
    //       // );
    //     },
    //     itemCount: 2,
    //     pagination: new SwiperPagination(),
    //     control: new SwiperControl(),
    //   ),
    // );
  }

  //contenedor tipos de transferencias

  Widget _contenedorTiposDetransf(BuildContext context) {
    return Card(
      elevation: 24.0,
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: [
                  Text("TRANSFERENCIA DESDE CUENTA PERSONA"),
                  Divider(color: Colors.white),
                  _enviarCuentaPersona2(context),
                  Divider(color: Colors.white),
                  Text("TRANSFERENCIA CON EMPRESA"),
                  _enviarCuentaEmpresa2(context),
                  Divider(color: Colors.white),
                  _cobrar(context),
                ],
              ),

              //  _enviarPersona(context),
            ]),
      ),
    );
  }

  //ENVIAR TRANFE A PERSONA   //estoy utilizando el azul

  // Widget _enviarPersona(BuildContext context) {
  //   return Container(
  //     //margin: EdgeInsets.all(05),
  //     child: Center(
  //       child: Column(
  //         children: <Widget>[
  //           Container(
  //             //largo boton
  //             height: 70.0,
  //             //ancho
  //             width: 400,
  //             child: RaisedButton(
  //               onPressed: () {
  //                 aviso(context,
  //                     "Recorda guardar una captura de pantalla o el comprobante del deposito!!");
  //                 _urlredirectPersona();
  //               },
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(15.0)),
  //               padding: EdgeInsets.all(0.0),
  //               child: Ink(
  //                 decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       colors: [Colors.deepOrange, Colors.orangeAccent],
  //                       begin: Alignment.centerLeft,
  //                       end: Alignment.centerRight,
  //                     ),
  //                     borderRadius: BorderRadius.circular(15.0)),
  //                 child: Container(
  //                   constraints:
  //                       BoxConstraints(maxWidth: 400.0, minHeight: 100.0),
  //                   alignment: Alignment.center,
  //                   child: Text(
  //                     "ENVIAR",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(color: Colors.white, fontSize: 25),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _enviarCuentaPersona2(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.blueAccent[400],
      textColor: Colors.white,
      label: Text('DEPOSITAR'),
      icon: Icon(Icons.person),
      onPressed: () {
        aviso(context,
            "Recorda guardar una captura de pantalla o el comprobante del deposito!!");
        _urlredirectPersona();
      },
    );
    //onPressed: (_guardando) ? null : _submit);
  }

  _urlredirectPersona() async {
    const url = 'https://ebanking.brou.com.uy/frontend/loginStep1';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'No pueden cargar el sitio : $url';
    }
  }

  //ENVIAR TRANFE A PERSONA

  Widget _enviarCuentaEmpresa2(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.blueAccent[400],
      textColor: Colors.white,
      label: Text('DEPOSITAR'),
      icon: Icon(Icons.store),
      onPressed: () {
        aviso(context,
            "Recorda guardar una captura de pantalla o el comprobante del deposito!!");
        _urlredirectEmpesa();
      },
    );
    //onPressed: (_guardando) ? null : _submit);
  }

  // Widget _enviarEmpresa(BuildContext context) {
  //   return Container(
  //     //margin: EdgeInsets.all(05),
  //     child: Center(
  //       child: Column(
  //         children: <Widget>[
  //           Container(
  //             //largo boton
  //             height: 70.0,
  //             //ancho
  //             width: 400,
  //             child: RaisedButton(
  //               onPressed: () {
  //                 avisoEmpresa(context,
  //                     "Recorda guardar una captura de pantalla o el comprobante del deposito!!");
  //                 //  _urlredirectEmpesa();
  //               },
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(15.0)),
  //               padding: EdgeInsets.all(0.0),
  //               child: Ink(
  //                 decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       colors: [Colors.deepOrange, Colors.orangeAccent],
  //                       begin: Alignment.centerLeft,
  //                       end: Alignment.centerRight,
  //                     ),
  //                     borderRadius: BorderRadius.circular(15.0)),
  //                 child: Container(
  //                   constraints:
  //                       BoxConstraints(maxWidth: 400.0, minHeight: 100.0),
  //                   alignment: Alignment.center,
  //                   child: Text(
  //                     "ENVIAR",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(color: Colors.white, fontSize: 25),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  _urlredirectEmpesa() async {
    const url =
        'https://www.canales.brou.com.uy/empresas/seguridad/loginFlow.htm?execution=e2s1';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'No pueden cargar el sitio : $url';
    }
  }

  void avisoEmpresa(BuildContext context, String mensaje) {
    Widget cancelBoton = FlatButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => TranfBrou(),
            ),
          );
        });
    Widget continuarBoton = FlatButton(
      child: Text("Continuar"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _urlredirectEmpesa(),
          ),
        );
      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text(mensaje),
      // content: Text(mensaje),
      actions: [
        cancelBoton,
        continuarBoton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

//boton cobrar
  Widget _cobrar(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(05),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              //largo boton
              height: 70.0,
              //ancho
              width: 400,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CobrarTranf(),
                    ),
                  );
                  // _urlredirectPersona();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orangeAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 400.0, minHeight: 100.0),
                    alignment: Alignment.center,
                    child: Text(
                      "COBRAR",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
