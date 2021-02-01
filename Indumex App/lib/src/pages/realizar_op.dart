import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/simular_bloc.dart';
import 'package:formvalidation/src/pages/sucursales_page.dart';
import 'package:formvalidation/src/pages/tranfe_money_page.dart';
import 'package:formvalidation/src/pages/transfe_brou_page.dart';
import 'package:formvalidation/src/providers/SimularOp_provider.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/utils/widgets.dart' as master;
import 'package:formvalidation/src/utils/estilos.dart' as estilos;

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
    final blocUsuario = LoginProvider.of(context);
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
              _tiposDeCambio(blocUsuario, blocSimular, context),
              SizedBox(
                width: size.width * 0.15,
              ),
              SizedBox(height: 15.0),
              _resumenOp(blocUsuario, blocSimular),

              SizedBox(height: 10.0),
              _formasDePago(blocUsuario, blocSimular),
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
      ),

      // bottomNavigationBar: _bottomNavigationBar(),
      endDrawer: master.menuDrawer(context, blocUsuario),
    );
  }

//contenedor info tipos de cambio (card)
  Widget _tiposDeCambio(
      LoginBloc blUsuario, SimularBloc blSimular, BuildContext context) {
    // final usr = bloc.usuario;

    //mostrarAlerta(context, "Debe loguearce para realizar esta accción");

    return Center(
      child: Card(
        elevation: 24.0,
        child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Divider(
                color: Colors.white,
              ),
              // ListTile(
              //   title:
              Text('TIPOS DE CAMBIO A OFRECERTE',
                  style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              //),
              Divider(
                color: Colors.white,
              ),
              Container(
                // margin: EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                          "Tc pizarra : " +
                              blSimular.simularOP.tcPizarra.toString(),
                          style: TextStyle(fontSize: 15)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                          "Tc cliente : " +
                              blSimular.simularOP.tcUsuarioApp.toString(),
                          style: TextStyle(fontSize: 20)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                          "Con moneycard : " +
                              blSimular.simularOP.tcDescuentoMax.toString(),
                          style: TextStyle(fontSize: 30)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

//contenedor resumen de operacion
  Widget _resumenOp(LoginBloc blUsuario, SimularBloc blSimular) {
    return Center(
      child: Card(
        elevation: 24.0,
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Divider(
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('RESUMEN DE OPERACIÓN',
                      style:
                          TextStyle(color: Colors.blue[400], fontSize: 20.0)),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                        "Tipo de cambio Aplicado : " +
                            blSimular.simularOP.tcPizarra.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.zero,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Text(
                          'Tengo : ' +
                              blSimular.simularOP.importeTengo.toString() +
                              " " +
                              blSimular.simularOP.monedaTengo.descripcion
                                  .toString(),
                          style: TextStyle(fontSize: 15.0)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                          'Obtengo : ' +
                              blSimular.simularOP.importeQuiero.toString() +
                              " " +
                              blSimular.simularOP.monedaQuiero.descripcion
                                  .toString(),
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Divider(
                color: Colors.white,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Divider(color: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      // child: Text(
                      //     "Con moneycard :" +
                      //         blSimular.simularOP.tcDescuentoMax.toString(),
                      //     style: TextStyle(fontSize: 30)),
                    ),
                    Divider(color: Colors.white),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  //contenedor botones tipo op
  Widget _formasDePago(LoginBloc blUsuario, SimularBloc blSimular) {
    return Card(
      elevation: 20.0,
      child: Container(
        margin: EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('FORMAS DE PAGO',
                  style: TextStyle(color: Colors.blue[400], fontSize: 20.0)),
              Divider(color: Colors.white),
              SizedBox(height: 10.0),
              Row(
                children: [
                  _crearBotonTipoLiquidacionReturarSuc(blUsuario),
                  Divider(color: Colors.white),
                  _crearBotonTipoLiquidacionMoney(blUsuario,blSimular),
                  Divider(color: Colors.white),
                  _crearBotonTipoLiquidacionBrou(blUsuario),
                ],
              )
            ]),
      ),
    );
  }

  //botones tipos de liquidacion
  //liquidacion por medio de moneycard

  Widget _crearBotonTipoLiquidacionMoney(
      LoginBloc bloc, SimularBloc blSimular) {
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
                  // onPressed: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => TranfMoney()),
                  //   );
                  // }
                  onPressed: () => (blSimular
                                  .simularOP.monedaQuiero.descripcion !=
                              "Dolares" ||
                          blSimular.simularOP.monedaQuiero.descripcion !=
                              "Pesos")
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TranfMoney()),
                        )
                      : null,
                ),
                Text('Moneycard'),
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
                Text('Prescencial'),
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
  Widget _crearBotonTipoLiquidacionBrou(LoginBloc bloc) {
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
                      Icons.food_bank_outlined,
                      size: 25.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TranfBrou()),
                      );
                    }),
                Text('Brou'),
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

  // _contenidoRealizarOp(LoginBloc blUsuario, SimularBloc blSimular, BuildContext context) {
  //   // final prefs = new PreferenciasUsuario();
  //   // await prefs.initPrefs();
  //   final usr = blUsuario.usuario;
  //   //este metodo creo no lo estoy llamando todavia.

  //   if (usr != null) {
  //     return ListView(
  //       padding: EdgeInsets.all(25),
  //       children: <Widget>[
  //         SizedBox(height: 30.0),
  //         _tiposDeCambio(blUsuario, blSimular, context),
  //         SizedBox(height: 30.0),
  //         _resumenOp(blUsuario, blSimular),
  //       ],
  //     );
  //   } else {
  //     mostrarAlerta1(
  //         context, "Debe estar logueado para realizar una operación");
  //     return scheduleMicrotask(() => Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => LoginPage())));
  //   }

  //   //else return Container (child: Text('Debe de estar logueado para poder realizar operaciones'));
  // }

}
