import 'package:flutter/material.dart';
import 'package:formvalidation/src/providers/login_provider.dart';
import 'package:provider/provider.dart';

import 'package:formvalidation/src/models/Moneycard_model.dart';
import 'package:formvalidation/src/providers/localidades_provider.dart';
import 'package:formvalidation/src/providers/moneycard_provider.dart';
import 'package:formvalidation/src/utils/funciones.dart' as funciones;
import 'package:formvalidation/src/utils/funciones.dart';
import 'package:formvalidation/src/utils/widgets.dart' as master;
import 'package:formvalidation/src/utils/juego_pruebas.dart';
import 'package:formvalidation/src/utils/estilos.dart' as estilos;

class SolicitudMoneycard extends StatefulWidget {
  @override
  _SolicitudMoneycardState createState() => _SolicitudMoneycardState();
}

//usando Provider para los combos Departamentos/Localidades

class _SolicitudMoneycardState extends State<SolicitudMoneycard>
    with ChangeNotifier {
  //VALIDACIONES

  bool _validarNombre = true;
  bool _validarApellido = true;
  bool _validarDocumento = true;
  bool _validarTelefono = true;
  bool _validarCalle = true;
  bool _validarNroPuerta = true;
  bool _validarCodigoPostal = true;
  bool _validarEmail = true;
  bool _validarFormulario = false;

  MoneycardModel moneycard = new MoneycardModel();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final moneycardProvider = new MoneycardProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);

    final MoneycardModel moneycardData =
        ModalRoute.of(context).settings.arguments;

    if (moneycardData != null) {
      moneycard = moneycardData;
    }
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            backgroundColor: Colors.blue, title: Text('Solicitud Moneycard')),
        body: Container(
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: [
                _inputNombre('Nombre', Icon(Icons.accessibility)),
                Divider(),
                _inputApellido('Apellido', Icon(Icons.accessibility)),
                _errorCantidadLetrasNombreApellido(),
                Divider(),
                _inputTipoDocumento('Tipo de documento: ', tiposDeDocumento),
                Divider(),
                _inputDocumento('$opcionSeleccionadaTipoDeDocumento',
                    Icon(Icons.perm_identity)),
                Divider(),
                _inputFechaDeNacimiento(context),
                Divider(),
                _inputPais('País de nacimiento:', paises),
                Divider(),
                _inputSexo('Sexo:', sexo),
                Divider(),
                _inputTelefono('Teléfono', Icon(Icons.phone)),
                Divider(),
                _inputEstadoCivil('Estado civil:', estadoCivil),
                Divider(),
                _inputCelular('Celular', Icon(Icons.phone_iphone)),
                Divider(),
                _inputEmail(),
                Divider(),
                _inputPaisDeResidencia('País de residencia:', ['Uruguay']),
                Divider(),
                _inputDepartamento('Departamento: ', departamentos),
                Divider(),
                _inputLocalidades(1, Icon(Icons.house)),
                Divider(color: Colors.white, height: 4),
                _inputCodigoPostal('Código postal', null),
                Divider(color: Colors.white, height: 4),
                _inputManzanaSolar('Solar/manzana', null),
                Divider(color: Colors.white, height: 4),
                _inputCalle('Calle', null),
                Divider(color: Colors.white, height: 4),
                _inputNroPuerta('Número de puerta', null),
                Divider(color: Colors.white, height: 4),
                _inputApartamento('Apartamento', null),
                Divider(),
                Text('Sucursal de retiro',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(color: Colors.white, height: 5),
                _inputSucursales('Sucursal', sucursales),
                //_botonEnviar()
                _crearBoton()
              ],
            ),
          ),
       ),
        //menu hamburguesa
        endDrawer: master.menuDrawer(context, bloc));
  }

  //comentario para commit

  //especializado para recibir que va a completar (sea nombre, apellido, etc.)
  //tambien recibe los iconos que se muestran en el input (cabezal y el del final)
  //es un textField que utiliza varias propiedades, algunas comentadas para ver si se usan o no
  //en el evento onChanged captura lo que completa el cliente

  Widget _inputNombre(String dato, Icon iconoAlFinal) {
    return TextFormField(
      //initialValue: moneycard.nombre,
      controller: nombre,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (valor) {
        setState(() {
          if (nombre.text.isNotEmpty)
            _validarNombre = true;
          else
            _validarNombre = false;

          moneycard.nombre = valor;
        });
      },
      decoration: InputDecoration(
          errorText: !_validarNombre
              ? 'Debe de ingresar su ${dato.toLowerCase()}'
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          suffixIcon: iconoAlFinal),
    );
  }

  Widget _inputApellido(String dato, Icon iconoAlFinal) {
    int contador = nombre.text.length + apellido.text.length;

    return TextField(
      controller: apellido,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          errorText: !_validarApellido
              ? 'Debe de ingresar su ${dato.toLowerCase()}'
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          counter: contador > 21
              ? Text('Cantidad de caracteres: $contador')
              : Text(''),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          suffixIcon: iconoAlFinal),
      onChanged: (valor) {
        setState(() {
          if (apellido.text.isNotEmpty)
            _validarApellido = true;
          else
            _validarApellido = false;
          moneycard.apellido = valor;
        });
      },
    );
  }

  Widget _inputTipoDocumento(String titulo, List<String> lista) {
    moneycard.tipoDeDoc = opcionSeleccionadaTipoDeDocumento;

    return Row(
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 20.0,
        ),
        DropdownButton(
            value: opcionSeleccionadaTipoDeDocumento,
            items: funciones.obtenerValorDelDropdownList(tiposDeDocumento),
            onChanged: (opt) {
              setState(() {
                opcionSeleccionadaTipoDeDocumento = opt;
                moneycard.tipoDeDoc = opt;
              });
            })
      ],
    );
  }

  Widget _inputDocumento(String dato, Icon iconoAlFinal) {
    return TextField(
      controller: nroDocumento,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          errorText: !_validarDocumento
              ? 'Debe de ingresar su ${dato.toLowerCase()}'
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          //contador de letras, ver si sirve y lo agregamos
          //counter: Text('Letras ${_nombre.length}'),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
          //helperText: 'Solo el $dato',
          suffixIcon: iconoAlFinal),
      onChanged: (valor) {
        setState(() {
          if (nroDocumento.text.isNotEmpty)
            _validarDocumento = true;
          else
            _validarDocumento = false;
          moneycard.numeroDeDoc = valor;
        });
      },
    );
  }

  Widget _inputFechaDeNacimiento(BuildContext context) {
    moneycard.fechaNacimiento = DateTime(1980, 1, 1);

    return TextField(
      controller: textEditingControllerDate,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
          suffixIcon: Icon(Icons.perm_contact_calendar)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _seleccionarFecha(context);
      },
    );
  }

  _seleccionarFecha(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(1980), //DateTime.now(),
        firstDate: new DateTime(1980),
        lastDate: new DateTime(2021),
        locale: Locale('es', 'ES'));
    if (picked != null) {
      fecha = funciones.formatearFecha(picked);
      textEditingControllerDate.text = fecha;
      moneycard.fechaNacimiento = picked;
    }
  }

  Widget _inputTelefono(String dato, Icon iconoAlFinal) {
    return TextField(
      controller: telefono,
      keyboardType: TextInputType.phone,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          errorText: !_validarTelefono
              ? 'Debe de ingresar su ${dato.toLowerCase()}'
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          //contador de letras, ver si sirve y lo agregamos
          //counter: Text('Letras ${_nombre.length}'),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
          //helperText: 'Solo el $dato',
          suffixIcon: iconoAlFinal),
      onChanged: (valor) {
        setState(() {
          if (telefono.text.isNotEmpty)
            _validarTelefono = true;
          else
            _validarTelefono = false;
          moneycard.tel = valor;
        });
      },
    );
  }

  Widget _inputCelular(String dato, Icon iconoAlFinal) {
    return TextField(
      controller: celular,
      keyboardType: TextInputType.phone,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          //contador de letras, ver si sirve y lo agregamos
          //counter: Text('Letras ${_nombre.length}'),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
          //helperText: 'Solo el $dato',
          suffixIcon: iconoAlFinal),
      onChanged: (valor) {
        setState(() {
          moneycard.cel = valor;
        });
      },
    );
  }

  Widget _inputDepartamento(String titulo, List<String> lista) {
    moneycard.departamento = opcionSeleccionadaDepartamento;

    final localidadesParaDepto = Provider.of<LocalidadesProvider>(context);

    return Row(
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 15),
        ),
        DropdownButton(
            value: opcionSeleccionadaDepartamento,
            items: funciones.obtenerValorDelDropdownList(lista),
            onChanged: (opt) {
              setState(() {
                opcionSeleccionadaDepartamento = opt;
                moneycard.departamento = opt;
                //capturar departamento y disparar de nuevo el _inputLocalidades()
                localidadesParaDepto.obtenerlocalidadesParaDepartamento(
                    buscarIdDepartamento(opcionSeleccionadaDepartamento));

                localidadesParaDepartamento =
                    localidadesParaDepto.localidadesParaDepto;
                opcionSeleccionadaLocalidad = localidadesParaDepartamento[0];
              });
            })
      ],
    );
  }

  Widget _inputLocalidades(int idDepartamento, Icon iconoAlFinal) {
    moneycard.localidad = opcionSeleccionadaLocalidad;

    final localidadesParaDepto = Provider.of<LocalidadesProvider>(context);

    localidadesParaDepto.obtenerlocalidadesParaDepartamento(
        buscarIdDepartamento(opcionSeleccionadaDepartamento));

    localidadesParaDepartamento = localidadesParaDepto.localidadesParaDepto;

    return Row(
      children: [
        Text(
          'Localidad',
          style: TextStyle(fontSize: 11),
        ),
        SizedBox(
          width: 20,
        ),
        DropdownButton(
            hint: Container(
              width: 150, //and here
              child: Text("Selecciona una localidad",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.end),
            ),
            value: opcionSeleccionadaLocalidad,
            items: funciones
                .obtenerValorDelDropdownList(localidadesParaDepartamento),
            onChanged: (opt) {
              setState(() {
                opcionSeleccionadaLocalidad = opt;
                moneycard.localidad = opt;
              });
            })
      ],
    );
  }

  Widget _inputCodigoPostal(String dato, Icon iconoAlFinal) {
    return TextField(
      controller: codigoPostal,
      keyboardType: TextInputType.phone,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          errorText: !_validarCodigoPostal
              ? 'Debe de ingresar su ${dato.toLowerCase()}'
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          //contador de letras, ver si sirve y lo agregamos
          //counter: Text('Letras ${_nombre.length}'),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
          //helperText: 'Solo el $dato',
          suffixIcon: iconoAlFinal),
      onChanged: (valor) {
        setState(() {
          if (codigoPostal.text.isNotEmpty)
            _validarCodigoPostal = true;
          else
            _validarCodigoPostal = false;
          moneycard.codigoPostal = valor;
        });
      },
    );
  }

  Widget _inputManzanaSolar(String dato, Icon iconoAlFinal) {
    return TextField(
      controller: manzanaSolar,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          //contador de letras, ver si sirve y lo agregamos
          //counter: Text('Letras ${_nombre.length}'),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
          //helperText: 'Solo el $dato',
          suffixIcon: iconoAlFinal),
      onChanged: (valor) {
        setState(() {
          moneycard.solar = valor;
        });
      },
    );
  }

  Widget _inputCalle(String dato, Icon iconoAlFinal) {
    return TextField(
      controller: calle,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          errorText: !_validarCalle
              ? 'Debe de ingresar su ${dato.toLowerCase()}'
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          //contador de letras, ver si sirve y lo agregamos
          //counter: Text('Letras ${_nombre.length}'),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
          //helperText: 'Solo el $dato',
          suffixIcon: iconoAlFinal),
      onChanged: (valor) {
        if (calle.text.isNotEmpty)
          _validarCalle = true;
        else
          _validarCalle = false;
        setState(() {
          moneycard.direccion = valor;
        });
      },
    );
  }

  Widget _inputNroPuerta(String dato, Icon iconoAlFinal) {
    return TextField(
      controller: numeroPuerta,
      keyboardType: TextInputType.phone,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          errorText: !_validarNroPuerta
              ? 'Debe de ingresar su ${dato.toLowerCase()}'
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          //contador de letras, ver si sirve y lo agregamos
          //counter: Text('Letras ${_nombre.length}'),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
          //helperText: 'Solo el $dato',
          suffixIcon: iconoAlFinal),
      onChanged: (valor) {
        setState(() {
          if (numeroPuerta.text.isNotEmpty)
            _validarNroPuerta = true;
          else
            _validarNroPuerta = false;
          moneycard.numeroPuerta = valor;
        });
      },
    );
  }

  Widget _inputEmail() {
    return TextField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          errorText: !_validarEmail ? 'Debe de ingresar su email' : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Email',
          labelText: 'Email',
          suffixIcon: Icon(Icons.alternate_email)),
      onChanged: (valor) {
        setState(() {
          if (email.text.isNotEmpty)
            _validarEmail = true;
          else
            _validarEmail = false;

          moneycard.email = valor;
        });
      },
    );
  }

  Widget _inputPais(String titulo, List<String> lista) {
    moneycard.paisDeNacimiento = opcionSeleccionadaPais;

    return Row(
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 20.0,
        ),
        DropdownButton(
            value: opcionSeleccionadaPais,
            items: funciones.obtenerValorDelDropdownList(lista),
            onChanged: (opt) {
              setState(() {
                opcionSeleccionadaPais = opt;
                moneycard.paisDeNacimiento = opt;
              });
            })
      ],
    );
  }

  Widget _inputSexo(String titulo, List<String> lista) {
    moneycard.sexo = opcionSeleccionadaSexo;

    return Row(
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 20.0,
        ),
        DropdownButton(
            value: opcionSeleccionadaSexo,
            items: funciones.obtenerValorDelDropdownList(lista),
            onChanged: (opt) {
              setState(() {
                opcionSeleccionadaSexo = opt;
                moneycard.sexo = opt;
              });
            })
      ],
    );
  }

  Widget _inputEstadoCivil(String titulo, List<String> lista) {
    moneycard.estadoCivil = opcionSeleccionadaEstadoCivil;
    return Row(
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 20.0,
        ),
        DropdownButton(
            value: opcionSeleccionadaEstadoCivil,
            items: funciones.obtenerValorDelDropdownList(lista),
            onChanged: (opt) {
              setState(() {
                opcionSeleccionadaEstadoCivil = opt;
                moneycard.estadoCivil = opt;
              });
            })
      ],
    );
  }

  Widget _inputPaisDeResidencia(String titulo, List<String> lista) {
    moneycard.paisDeResidencia = paisResidencia;
    return Row(
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 20.0,
        ),
        DropdownButton(
            value: paisResidencia,
            items: funciones.obtenerValorDelDropdownList(lista),
            onChanged: (opt) {
              setState(() {
                paisResidencia = opt;
                moneycard.paisDeResidencia = opt;
              });
            })
      ],
    );
  }

  Widget _inputApartamento(String dato, Icon iconoAlFinal) {
    return TextFormField(
      controller: apartamento,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          //contador de letras, ver si sirve y lo agregamos
          //counter: Text('Letras ${_nombre.length}'),
          hintText: 'Completa tu ${dato.toLowerCase()}',
          labelText: '$dato',
          //ayuda al completar, lo saco. si quieren lo probamos. para mi no suma
          //helperText: 'Solo el $dato',
          suffixIcon: iconoAlFinal),
      onChanged: (valor) {
        setState(() {
          moneycard.apto = valor;
        });
      },
    );
  }

  Widget _inputSucursales(String titulo, List<String> lista) {
    moneycard.sucursalRetiro = opcionSeleccionadaSucursal;

    return Row(
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
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.blueAccent[400],
        textColor: Colors.white,
        label: Text('Enviar Solicitud'),
        icon: Icon(Icons.save),
        onPressed: () {
          _submit();
        });
    //onPressed: (_guardando) ? null : _submit);
  }

  void mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje), duration: Duration(milliseconds: 1500));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scaffoldKey.currentState.showSnackBar(snackbar);
    });
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _validarFormulario = validarFormulario();
    });

    if (_validarFormulario &&
        await moneycardProvider.crearMoneycard(moneycard)) {
      mostrarSnackBar('Solicitud de Moneycard enviada');
    } else {
      mostrarSnackBar('Solicitud no enviada, corrija errores');
    }

    //Navigator.pop(context);
  }

  bool validarTexto(String string) {
    if (string.isEmpty)
      return false;
    else
      return true;
  }

  bool validarNumero(String dato) {
    int datoAInt = 0;
    try {
      datoAInt = int.parse(dato);
    } catch (e) {
      return false;
    }
    if (datoAInt <= 0)
      return false;
    else
      return true;
  }

  bool validarFormulario() {
    _validarNombre = validarTexto(nombre.text);
    _validarApellido = validarTexto(apellido.text);
    _validarDocumento = validarTexto(nroDocumento.text);
    _validarTelefono = validarTexto(telefono.text);
    _validarCalle = validarTexto(calle.text);
    _validarNroPuerta = validarTexto(numeroPuerta.text);
    _validarCodigoPostal = validarTexto(codigoPostal.text);
    _validarEmail = validarTexto(email.text);

    return _validarNombre &&
        _validarApellido &&
        _validarDocumento &&
        _validarTelefono &&
        _validarCalle &&
        _validarNroPuerta &&
        _validarCodigoPostal &&
        _validarEmail;
  }

  _errorCantidadLetrasNombreApellido() {
    if (nombre.text.length + apellido.text.length > 21) {
      return Column(
        children: [
          ListTile(
            title: Text(
              'La cantidad de caracteres entre nombre y apellido no puede ser mayor a 21',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    } else {
      return Container(
          child: Text(
        'Su tarjeta MoneyCard se grabara: APELLIDO, NOMBRE',
        textAlign: TextAlign.center,
      ));
    }
  }
}
