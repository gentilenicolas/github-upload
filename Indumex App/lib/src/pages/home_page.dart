//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/simular_bloc.dart';
import 'package:formvalidation/src/models/Pizarra_model.dart';
import 'package:flutter/src/rendering/box.dart';

import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/solicitud_moneycard.dart';
import 'package:formvalidation/src/pages/sucursales_page.dart';
import 'package:formvalidation/src/providers/Monedas_provider.dart';
import 'package:formvalidation/src/providers/SimularOp_provider.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/pages/realizar_op.dart';
import 'package:formvalidation/src/providers/Pizarra_provider.dart';
import 'package:formvalidation/src/utils/estilos.dart' as estilos;
import 'package:formvalidation/src/utils/widgets.dart' as master;
import 'package:formvalidation/src/utils/juego_pruebas.dart' as jp;
import 'package:formvalidation/src/providers/tengoQuiero_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:input_calculator/input_calculator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
  //final String routeName = 'home';
}

// otro comentario pedorro
class _HomePageState extends State<HomePage> {
  // final importeTengoController = new TextEditingController();
  //final importeQuieroController = new TextEditingController();

  //final bloc = LoginBloc();
  //final blocS = SimularBloc();
  final simularOpProvider = new SimularOpProvider();
  final pizarraProvider = new PizarraProvider();
  String _monedaSeleccionadaTengo = jp.monedas[2].descripcion; //pesos uru 2
  String _monedaSeleccionadaQuiero = jp.monedas[0].descripcion; // dólares 0
  // int _selectedIndex = 0; // bottom

  @override
  Widget build(BuildContext context) {
    //_prefs.ultimaPagina = HomePage().routeName = 'home';
    final blocLogin = LoginProvider.of(context);
    final blocSimular = SimularOpProvider.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueAccent[400],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          actions: <Widget>[],
          title: Image(
            image: AssetImage('assets/images/indumex-logo.png'),
            width: 200,
          ),
        ),
        //body Home
        body: 
        // SingleChildScrollView(
        //   child: SizedBox(
        //     height: 750,
            //child: 
            Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    _sucursales(blocLogin),
                    Container(
                      //Pizzarra
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: _crearPizarra(),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    //contenedor para los tres botones de operacion
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      //texto en mitad de pantalla home2
                      child: Text(
                        'SIMULADOR DE OPERACIONES',
                        style: estilos.textoBotones,
                      ),
                    ),
                    //Boton tengo & quiero
                    _btnTengoQuiero(blocLogin),
                    //boton generar operacion
                    _btnGenerarOp(blocLogin, blocSimular),
                    //banner
                    _imagenBottom(blocLogin),
                  ],
                ),
              ),

              //gradiente de scaffold
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [estilos.gradientStart, estilos.gradientEnd],
                    begin: const FractionalOffset(0.5, 0.0),
                    end: const FractionalOffset(0.0, 0.5),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
         // ),
        //),
        // bottomNavigationBar: _bottomNavigator(
        //  //_widgetOptions.elementAt(_selectedIndex),
        //         ),
        //menu hamburguesa
        endDrawer: master.menuDrawer(context, blocLogin));
  }

//link a sucursales de la pagina
  Widget _sucursales(LoginBloc bloc) {
    if (bloc.nombre != null) {
      return
          // leading: Icon(Icons.account_box,color: Colors.white),
          Center(
        child: Row(
          children: <Widget>[
            MaterialButton(
              child: Row(
                children: <Widget>[
                  new Icon(
                    Icons.person_pin_circle,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  Text(
                    "Hola " +
                        bloc.nombre +
                        " buscá aquí tu sucursal más próxima !",
                    //_bienvenidoHome(bloc),
                    style: new TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ],
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sucursales(),
                  ),
                ),
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    } else {
      return Center(
        child: Row(
          children: <Widget>[
            Icon(Icons.person_pin_circle, size: 20, color: Colors.white),
            InkWell(
              child: Text(
                'Buscá aquí la sucursal más próxima !',
                style: new TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              onTap: () async {
                if (await canLaunch(_urlredirect())) {
                  await launch(_urlredirect());
                }
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }

  _urlredirect() async {
    const url = 'https://www.indumex.com/sucursales';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'No pueden cargar las sucursales : $url';
    }
  }

  //Pizarra
  Widget _crearPizarra() {
    final size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: pizarraProvider.cargarPizarra(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PizarraModel>> listaMonedas) {
          if (listaMonedas.hasData) {
            final monedas = listaMonedas.data;

            //valores numericos de la tabla (cotizaciones)
            Widget crearTabla(
                BuildContext context, List<PizarraModel> monedas) {
              List<TableRow> filas = [];
              //Cabezal tabla
              TableRow cabezal = TableRow(children: [
                TableCell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: <Widget>[
                          new Text('Cotizaciones', style: estilos.textoTabla),
                        ],
                      ),
                    ],
                  ),
                ),
                TableCell(
                  child: Row(
                    //centra el cabezal
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //si se descomenta centra para la izquierda
                    // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('Compra', style: estilos.textoTabla),
                    ],
                  ),
                ),
                TableCell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text('Venta', style: estilos.textoTabla),
                    ],
                  ),
                ),
              ], decoration: BoxDecoration(color: Colors.blueAccent[400]));
              filas.add(cabezal);

              for (int i = 0; i < monedas.length; ++i) {
                filas.add(TableRow(children: [
                  SizedBox(
                    //monedas
                    //height: 45,
                    height: size.height * 0.0555,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.blueAccent[400]),
                      child: TableCell(
                        child: Center(
                          child: Text(
                            '${monedas[i].moneda.trim()}',
                            textAlign: TextAlign.start,
                            style: estilos.monedasTabla,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //valores compra
                  Column(children: [
                    Text('${monedas[i].compra}',
                        style: estilos.valoresNumericosTabla,
                        textAlign: TextAlign.start),
                  ]),
                  //valores venta
                  Column(children: [
                    Text('${monedas[i].venta}',
                        style: estilos.valoresNumericosTabla),
                  ]),
                ]));
              }

              return Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: filas,
                  border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.white)));
            }

            //contendedor de tabla pizarra
            return Container(
                //height: 200,
                height: size.height * 0.245,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                          offset: Offset(4.0, 5.0))
                    ]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: crearTabla(context, monedas)));
          } else {
            return Center(
              child: Image(
                image: AssetImage('assets/images/dollar.gif'),
                fit: BoxFit.contain,
                //fadeOutDuration: Duration(milliseconds: 9000),
                //fadeInDuration: Duration(milliseconds: 1000),
                height: 100,
                width: 170,
              ),
            );
          }
        });
  }

  Widget _btnTengoQuiero(LoginBloc bloc) {
    final tengoQuieroProvider = Provider.of<TengoQuieroProvider>(context);

    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        //centrado de la celda
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('TENGO ',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(width: 5),
                Container(
                  width: 101,
                  height: 61,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                                isDense: true,
                                //hint: new Text("Seleccione una moneda"),
                                value: _monedaSeleccionadaTengo,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _monedaSeleccionadaTengo = newValue;
                                    jp.monedaTengo = MonedasProvider()
                                        .buscarMoneda(newValue);
                                  });
                                },
                                items: monedasMenuItem()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                    width: 140,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: CalculatorTextField(
                      allowNegativeResult: false,
                      style: TextStyle(color: Colors.white),
                      key: UniqueKey(),
                      initialValue: tengoQuieroProvider.tengoCalculator,
                      onSubmitted: (value) {
                        setState(() {
                          if (value != 0) {
                            tengoQuieroProvider.quieroCalculator = 0;
                            tengoQuieroProvider.tengoCalculator = value;
                            simularOp(
                                bloc,
                                context,
                                tengoQuieroProvider.tengoCalculator,
                                tengoQuieroProvider.quieroCalculator);
                            // Timer(Duration(milliseconds: 300), () {
                            //   tengoQuieroProvider.setearQuiero(
                            //       blocSimular.simularOP.importeQuiero);
                            // });
                          }
                        });
                      },
                    ))
              ]),
          SizedBox(
            height: 4,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('QUIERO',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(width: 5),
                Container(
                  width: 101,
                  height: 61,
                  //selector
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                                isDense: true,
                                //hint: new Text("Seleccione una moneda"),
                                value: _monedaSeleccionadaQuiero,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _monedaSeleccionadaQuiero = newValue;
                                    jp.monedaQuiero = MonedasProvider()
                                        .buscarMoneda(newValue);
                                    // if (importeQuieroController.text != '' ||
                                    //     importeTengoController.text != '') {
                                    //   simularOp(bloc, context);
                                    // }
                                  });
                                },
                                items: monedasMenuItem()

                                //harcodeado!:

                                // jp.banderasJson.map((Map map) {
                                //   return new DropdownMenuItem(
                                //     value: map["combo"].toString(),
                                //     child: Image.asset(
                                //       map["image"],
                                //       width: 25,
                                //     ),
                                //   );
                                // }).toList(),

                                ),
                          ),
                        ),
                      ),
                      //),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                    width: 140,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: CalculatorTextField(
                      allowNegativeResult: false,
                      style: TextStyle(color: Colors.white),
                      key: UniqueKey(),
                      initialValue: tengoQuieroProvider.quieroCalculator,
                      onSubmitted: (value) {
                        setState(() {
                          if (value != 0) {
                            tengoQuieroProvider.tengoCalculator = 0;
                            tengoQuieroProvider.quieroCalculator = value;
                            simularOp(
                                bloc,
                                context,
                                tengoQuieroProvider.tengoCalculator,
                                tengoQuieroProvider.quieroCalculator);
                            // Timer(Duration(milliseconds: 300), () {
                            //   tengoQuieroProvider.setearTengo(
                            //       blocSimular.simularOP.importeTengo);
                            // });
                          }
                          // }
                        });
                      },
                    ))
              ]),
        ],
      ),
    );
  }

  void simularOp(
      LoginBloc bloc, BuildContext context, double tengo, double quiero) {
    simularOpProvider.enviarSimulacionOp(jp.monedaTengo, jp.monedaQuiero, tengo,
        quiero, bloc.usuario != null ? bloc.usuario : null, context);
  }

  Widget _btnGenerarOp(LoginBloc bloc, SimularBloc blo) {
    final usuario = bloc.usuario;
    final simular = blo.simularOP;
    print(simular);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      child: Center(
        child: Column(
          children: <Widget>[
            // Container(
            //   //largo boton
            //   height: 70.0,
            //   //ancho
            //   width: 167,
            //   child: RaisedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => RealizarOp(),
            //         ),
            //       );
            //     },
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15.0)),
            //     padding: EdgeInsets.all(0.0),
            //     child: Ink(
            //       decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             colors: [Colors.deepOrange, Colors.orangeAccent],
            //             begin: Alignment.centerLeft,
            //             end: Alignment.centerRight,
            //           ),
            //           borderRadius: BorderRadius.circular(15.0)),
            //       child: Container(
            //         constraints:
            //             BoxConstraints(maxWidth: 400.0, minHeight: 100.0),
            //         alignment: Alignment.center,
            //         child: Text(
            //           "SIMULAR OPERACIÓN",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(color: Colors.white, fontSize: 20),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: 10,
            // ),

            Container(
              //largo boton
              height: 70.0,
              //ancho
              width:
                  400, //167,   //medida para hacerlo con 2 botones en lugar de 1

              child: RaisedButton(
                onPressed: () {
                  if (usuario == null || simular == null) {
                    if (usuario == null) {
                      alertaLogin(context,
                          "Luego de ingresar al LOGIN veras los distintos tipos de cambio a ofrecerte");
                    }
                    if (simular == null) {
                      alertaSimular(context,"No simulaste una operacion!!",
                          "Recuerda que todavia no has simulado una combersion de dinero!, utiliza a TENGO y QUIERO");
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RealizarOp(),
                      ),
                    );
                  }
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
                      "REALIZAR OPERACIÓN",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
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

  void alertaSimular(BuildContext context, String mensajeTitulo, String mensajeCuerpo) {
    Widget cancelBoton = FlatButton(
        child: Text("Ok"),
        onPressed: () {
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
    // Widget continuarBoton = FlatButton(
    //   child: Text("Continuar"),
    //   onPressed: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => HomePage(),
    //       ),
    //     );
    //    },
    // );

    AlertDialog alerta = AlertDialog(
      title: Text(mensajeTitulo),
      content: Text(mensajeCuerpo),
      actions: [
        cancelBoton,
        // continuarBoton,
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

  void alertaLogin(BuildContext context, String mensaje) {
    Widget cancelBoton = FlatButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
    Widget continuarBoton = FlatButton(
      child: Text("Continuar"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text("Deberias loguearte para realizar esta acción!!"),
      content: Text(mensaje),
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

  Widget _imagenBottom(LoginBloc bloc) {
    final usuario = bloc.usuario;

    //  final size = MediaQuery.of(context).size;
    if (usuario == null) {
      return Expanded(
        child: Stack(
          children: [
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: RaisedButton(onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SolicitudMoneycard(),
                      ));
                })),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              // height:
              //     87 /*size.height * 0.1*/, // no se porque me saca un cachito..
              child: Container(
                // child: RaisedButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => SolicitudMoneycard(),
                //         ));
                //   },
                child: Image.asset(
                  'assets/images/MoneyBottom.png',
                  fit: BoxFit.cover,
                  alignment: FractionalOffset.bottomCenter,
                ),
              ),
            ),
            //),
          ],
        ),
      );
    } else {
      return Container(
        child: Image.asset(""),
      );
      // tengo que hacerle un push al ayuda , para que aparezca el menu
    }
  }

  monedasMenuItem() {
    List<DropdownMenuItem<String>> lista = new List();
    for (int i = 0; i < jp.monedas.length; i++) {
      lista.add(DropdownMenuItem<String>(
        value: jp.monedas[i].descripcion,
        child: Image.asset(
          'assets/${jp.monedas[i].imagen}',
          width: 25,
        ),
      ));

      // jp.banderasJson.map((Map map) {
      //   return new DropdownMenuItem(
      //     value: map["combo"].toString(),
      //     child: Image.asset(
      //       map["image"],
      //       width: 25,
      //     ),
      //   );
      // }).toList(),

    }
    return lista;
  }
}
