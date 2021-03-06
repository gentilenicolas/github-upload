import 'package:flutter/material.dart';
import 'dart:io';

import 'package:formvalidation/src/models/Pizarra_model.dart';
import 'package:formvalidation/src/providers/Pizarra_provider.dart';
import 'package:formvalidation/src/utils/funciones.dart' as funciones;
import 'package:image_picker/image_picker.dart';

class MonedaPage extends StatefulWidget {
  @override
  _MonedaPageState createState() => _MonedaPageState();
}

class _MonedaPageState extends State<MonedaPage> {
  PizarraModel moneda = new PizarraModel();
  bool _guardando = false;
  File foto;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final monedaProvider = new PizarraProvider();

  @override
  Widget build(BuildContext context) {
    final PizarraModel moneData = ModalRoute.of(context).settings.arguments;

    if (moneData != null) {
      moneda = moneData;
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Monedas'),
          actions: [
            IconButton(
                icon: Icon(Icons.photo_size_select_actual),
                onPressed: _seleccionarFoto),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _tomarFoto,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  _mostrarFoto(),
                  _crearMoneda(),
                  _crearCompra(),
                  _crearVenta(),
                  //_crearDisponible(),
                  _crearBoton()
                ],
              ),
            ),
          ),
        ));
  }

  Widget _crearMoneda() {
    return TextFormField(
      initialValue: moneda.moneda,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (valor) => moneda.moneda = valor,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre de la moneda';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(labelText: 'Moneda'),
    );
  }

  Widget _crearCompra() {
    return TextFormField(
      initialValue: moneda.compra.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onSaved: (valor) => moneda.compra = double.parse(valor),
      validator: (value) {
        if (funciones.esNumerico(value)) {
          return null;
        } else {
          return 'solo numeros';
        }
      },
      decoration: InputDecoration(labelText: 'Compra'),
    );
  }

  Widget _crearVenta() {
    return TextFormField(
      initialValue: moneda.venta.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onSaved: (valor) => moneda.venta = double.parse(valor),
      validator: (value) {
        if (funciones.esNumerico(value)) {
          return null;
        } else {
          return 'solo numeros';
        }
      },
      decoration: InputDecoration(labelText: 'Venta'),
    );
  }

  // Widget _crearDisponible() {
  //   return SwitchListTile(
  //     value: producto.disponible,
  //     title: Text('Disponible'),
  //     activeColor: Colors.deepPurple,
  //     onChanged: (value) {
  //       setState(() {
  //         producto.disponible = value;
  //       });
  //     },
  //   );
  // }

  Widget _crearBoton() {
    return RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.blueAccent[400],
        textColor: Colors.white,
        label: Text('Guardar'),
        icon: Icon(Icons.save),
        onPressed: (_guardando) ? null : _submit);
  }

  void mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje), duration: Duration(milliseconds: 1500));

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      //si la moneda tuviese foto o quisieramos cargarle foto:
      //moneda.fotoURL = await monedaProvider.subirImagen(foto);
    }

    final monProv= monedaProvider.crearMoneda(moneda);

    if ( monProv == true)
      mostrarSnackBar('Registro Guardado');
    else {
      monedaProvider.editarMoneda(moneda);
      mostrarSnackBar('Registro Actualizado');
    }

    //Navigator.pop(context);
  }

  Future _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  void _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  Widget _mostrarFoto() {
    //if (moneda.fotoURL!=null) {
    return Image(
        image: AssetImage(foto?.path ?? 'assets/images/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover);
    //}
  }

  _procesarImagen(ImageSource origen) async {
    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(source: origen);

    foto = File(pickedFile.path);

    if (foto != null) {
      //si la moneda tuviese imagen
      //moneda.urlImg = null;
    }

    setState(() {});
  }
}
