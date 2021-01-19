//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formvalidation/src/models/Pizarra_model.dart';
import 'package:formvalidation/src/models/Usuario_model.dart';
import 'package:formvalidation/src/pages/solicitud_moneycard.dart';
import 'package:formvalidation/src/pages/sucursales_page.dart';
import 'package:formvalidation/src/providers/Monedas_provider.dart';
import 'package:formvalidation/src/providers/SimularOp_provider.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:formvalidation/src/pages/realizar_op.dart';
import 'package:formvalidation/src/providers/Pizarra_provider.dart';
import 'package:formvalidation/src/providers/tengoQuiero_provider.dart';
import 'package:formvalidation/src/utils/estilos.dart' as estilos;
import 'package:formvalidation/src/utils/widgets.dart' as master;
import 'package:formvalidation/src/utils/juego_pruebas.dart' as jp;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:input_calculator/input_calculator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
  //final String routeName = 'home';
}

class _HomePageState extends State<HomePage> {
  double importeTengoCalculator = 0;
  double importeQuieroCalculator = 0;

  final importeTengoController = new TextEditingController();
  final importeQuieroController = new TextEditingController();

  final bloc = LoginBloc();
  final simularOpProvider = new SimularOpProvider();
  String _monedaSeleccionadaTengo = jp.monedas[1].descripcion; //pesos uru 2
  String _monedaSeleccionadaQuiero = jp.monedas[0].descripcion; // dólares 0
  final pizarraProvider = new PizarraProvider();
  int _selectedIndex = 0; // bottom

  @override
  Widget build(BuildContext context) {
    //_prefs.ultimaPagina = HomePage().routeName = 'home';
    final bloc = LoginProvider.of(context);
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
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                _sucursales(bloc),
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
                _btnTengoQuiero(bloc),
                //boton generar operacion
                _btnGenerarOp(),
                //banner
                _imagenBottom(),
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
        // bottomNavigationBar: _bottomNavigator(
        //  //_widgetOptions.elementAt(_selectedIndex),
        //         ),
        //menu hamburguesa
        endDrawer: master.menuDrawer(context, bloc));
  }

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
                        " busca aqui tu sucursal más proxima !",
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
                'Busca aqui la sucursal mas proxima !',
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

    final blocSimular = SimularOpProvider.of(context);

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
                            child: FocusScope(
                              onFocusChange: (value) {
                                // if (!value) {
                                if (importeQuieroController.text == '' &&
                                    importeTengoController.text != '') {
                                  simularOp(bloc, context);
                                  importeQuieroController.text = blocSimular
                                      .simularOP.importeQuiero
                                      .toString();
                                }
                                if (importeTengoController.text == '' &&
                                    importeQuieroController.text != '') {
                                  simularOp(bloc, context);
                                  importeTengoController.text = blocSimular
                                      .simularOP.importeTengo
                                      .toString();
                                }
                                //  }
                              },
                              child: DropdownButton(
                                  // hint: Image.asset(
                                  //   'assets/images/uruguay.png',
                                  //   width: 25,
                                  // ),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 140,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: FocusScope(
                    onFocusChange: (value) {
                      if (!value) {
                        if (importeTengoController.text != '') {
                          importeQuieroController.text = '';
                          simularOp(bloc, context);
                          importeQuieroController.text =
                              blocSimular.simularOP.importeQuiero.toString();
                        }
                      }
                    },

                    // child: CalculatorTextField(
                    //   controller: importeTengoController,
                    //   key: Key('tengo'),
                    //   initialValue: tengoQuieroProvider
                    //       .tengoCalculator, //importeQuieroCalculator,
                    //   onSubmitted: (value) {
                    //     setState(() {
                    //       importeTengoController.text = '$value';
                    //       tengoQuieroProvider.tengoCalculator = value;
                    //       //CalculatorTextField(key: Key('quiero'))
                    //       //    .onSubmitted(importeTengoCalculator = 2.5);
                    //       tengoQuieroProvider.setearQuiero(1);
                    //     });
                    //   },
                    // )
                    child: TextField(
                      controller: importeTengoController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      // inputFormatters: [
                      //   new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      // ],
                      autofocus: false,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          labelStyle: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.blueAccent[500]),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                          //contador de letras, ver si sirve y lo agregamos
                          //counter: Text('Letras ${_nombre.length}'),
                          // hintText: '',
                          labelText: '$_monedaSeleccionadaTengo',
                          //'$opcionMonedaSeleccionadaTengo',
                          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
                          //helperText: 'Solo el $dato',
                          suffixIcon: Icon(
                            Icons.attach_money,
                            color: Colors.white,
                          )),
                      onChanged: (valor) {
                        setState(() {
                          importeQuieroController.text = '';
                          //importeTengoController.text = '';
                        });
                      },
                    ),
                  ),
                )
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
                            child: FocusScope(
                              onFocusChange: (value) {
                                // if (!value) {
                                if (importeQuieroController.text == '' &&
                                    importeTengoController.text != '') {
                                  simularOp(bloc, context);
                                  importeQuieroController.text = blocSimular
                                      .simularOP.importeQuiero
                                      .toString();
                                }
                                if (importeTengoController.text == '' &&
                                    importeQuieroController.text != '') {
                                  simularOp(bloc, context);
                                  importeTengoController.text = blocSimular
                                      .simularOP.importeTengo
                                      .toString();
                                }
                                //}
                              },
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 140,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: FocusScope(
                    onFocusChange: (value) {
                      if (!value) {
                        if (importeQuieroController.text != '') {
                          importeTengoController.text = '';
                          simularOp(bloc, context);
                          importeTengoController.text =
                              blocSimular.simularOP.importeTengo.toString();
                        }
                      }
                    },
                    child: TextField(
                      //enabled: false,

                      //Use focusNode and enableInteractiveSelection to make a
                      //TextField in Flutter readonly so that it can respond to the onTap events:

                      //focusNode: FocusNode(),
                      //enableInteractiveSelection: false,
                      controller: importeQuieroController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      //autofocus: false,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                          //contador de letras, ver si sirve y lo agregamos
                          //counter: Text('Letras ${_nombre.length}'),
                          // hintText: '',
                          labelText: '$_monedaSeleccionadaQuiero',
                          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
                          //helperText: 'Solo el $dato',
                          suffixIcon: Icon(
                            Icons.attach_money,
                            color: Colors.white,
                          )),
                      onChanged: (valor) {
                        setState(() {
                          importeTengoController.text = '';
                        });
                      },
                    ),
                  ),
                  // child: CalculatorTextField(
                  //   controller: importeQuieroController,
                  //   key: Key('quiero'),
                  //   initialValue: tengoQuieroProvider
                  //       .quieroCalculator, //importeTengoCalculator,
                  //   onSubmitted: (value) {
                  //     setState(() {
                  //       importeQuieroController.text = '$value';
                  //       tengoQuieroProvider.quieroCalculator = value;
                  //       //CalculatorTextField(key: Key('ponele'))
                  //       //  .onSubmitted(importeQuieroCalculator = 1.0);
                  //       tengoQuieroProvider.setearTengo(1111111);
                  //     });
                  //   },
                  // )
                )
              ]),
        ],
      ),
    );
  }

  void simularOp(LoginBloc bloc, BuildContext context) {
    if (importeQuieroController.text != '' ||
        importeTengoController.text != '') {
      double importeTengo;
      double importeQuiero;
      String tengoString;
      String quieroString;

      if (importeTengoController.text == '') {
        tengoString = '0';
      } else {
        tengoString = importeTengoController.text;
      }

      if (importeQuieroController.text == '') {
        quieroString = '0';
      } else {
        quieroString = importeQuieroController.text;
      }

      try {
        importeTengo = double.parse(tengoString);
      } catch (e) {
        importeTengo = 0;
        //print(e);
      }

      try {
        importeQuiero = double.parse(quieroString);
      } catch (e) {
        importeQuiero = 0;
        //print(e);
      }

      simularOpProvider.enviarSimulacionOp(
          jp.monedaTengo,
          jp.monedaQuiero,
          importeTengo,
          importeQuiero,
          //0, //TC APLICADO, lo calcula la API : en nuevo modelo no va mas, lo dejo comentado
          bloc.usuario != null ? bloc.usuario : null,
          context); //UsuarioModel(tipodoc: Tipodoc(pais: Pais()))
    }
  }

  Widget _btnGenerarOp() {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RealizarOp(),
                    ),
                  );
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

  


Widget _imagenBottom() {
    LoginBloc bloc = new LoginBloc();
    //  final size = MediaQuery.of(context).size;
    // if (bloc.usuario != null) {
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
    // } else {
    //   return Expanded(
    //     child: Align(
    //       alignment: FractionalOffset.bottomCenter,
    //       child: MaterialButton(
    //           onPressed: () => {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => SolicitudMoneycard(),
    //                   ),
    //                 ),
    //               },
    //           child: Image.asset(
    //             'assets/images/MoneyBottom.png',
    //             fit: BoxFit.cover,
    //             alignment: FractionalOffset.bottomCenter,
    //           )),
    //     ),
    //   );
    // }
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

//bottom navigator
/*
  Widget _bottomNavigator() {
    return BottomNavigationBar(
     
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          
        ),
        BottomNavigationBarItem(
                    icon: Icon(Icons.local_activity),
          label: 'Sucursales',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          label: 'Solicitud Moneycard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Login',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.orange[800],
      onTap: _onItemTapped,
      
    );
  }
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[

    Text(
      'Index 0: home',
      style: optionStyle,
    ),
    Text(
      'Index 1: sucursales',
      style: optionStyle,
    ),
    Text(
      'Index 2: solicitudMoneyCard',
      style: optionStyle,
    ),
    Text(
      'Index 2: login',
      style: optionStyle,
    ),
  ];*/
}
