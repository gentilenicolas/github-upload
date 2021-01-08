import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';
import 'package:formvalidation/src/pages/paginaVacia.dart';
import 'package:formvalidation/src/pages/productos_page.dart';
import 'package:formvalidation/src/pages/realizar_op.dart';
import 'package:formvalidation/src/pages/solicitud_moneycard.dart';
import 'package:formvalidation/src/pages/sucursales_page.dart';

//class MasterMenu {
Drawer menuDrawer(BuildContext context, LoginBloc bloc) {
//incluye menu de navegacion , bottom y fondo gradiente

  return Drawer(
    child: ListView(
      //padding: EdgeInsets.zero,
      children: <Widget>[
        tamanoDeNotch(context),
        incio(bloc),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text('NOTIFICACIONES'),
          leading: Icon(Icons.add_alert),
          onTap: () {
            Navigator.pushReplacementNamed(context, '');
          },
        ),
        Divider(),
        ListTile(
          title: Text('LOGIN'),
          leading: Icon(Icons.accessibility),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text('HOME'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text('REALIZAR OPERACION'),
          leading: Icon(Icons.monetization_on_sharp),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RealizarOp(),
              ),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text('SOLICITUD DE MONEYCARD'),
          leading: Icon(Icons.credit_card),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SolicitudMoneycard(),
              ),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text('SUCURSALES'),
          leading: Icon(Icons.location_city),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Sucursales(),
              ),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text('PRODUCTOS'),
          leading: Icon(Icons.mood),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Productos(),
              ),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text('AYUDA'),
          leading: Icon(Icons.help),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'ayuda');
          },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text('SALIR', style: TextStyle(color: Colors.blue)),
          leading: Icon(
            Icons.sensor_door,
            color: Colors.blue,
          ),
        onTap: () {
            Navigator.pushReplacementNamed(context, 'logout');
          },
            
        ),
        ListTile(
          title: Text('PAGINA DE PRUEBAS'),
          leading: Icon(Icons.sensor_door),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PaginaVacia(),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget tamanoDeNotch(BuildContext context) {
  final notch = MediaQuery.of(context).viewPadding;
  double bottom = notch.bottom;

  if (notch != null) {
    return SizedBox(
      height: bottom + 10.0,
      child: Container(
        color: Colors.black,
      ),
    );
  } else
    return Container();
}

//mensaje bienveida
String bienvenido(LoginBloc bloc) {
  if (bloc.nombre != null) {
    return "Hola " + bloc.nombre + " !";
  } else
    return "";
}

 _salir(BuildContext context, LoginBloc bloc) {
  return Card(
    child: Column(children: <Widget>[
      ListTile(
        leading: Icon(
          Icons.phone,
          color: Colors.brown,
        ),
        title: Text('Esta seguro que desea salir?'),
        subtitle: Text('kjljljljljllkñlklñkñlkñlklñlkjlkjkljlkjlkjklsdlfkj'),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              FlatButton(
                child: Text('No'),
                onPressed: () {},
              ),
            ],
          ),
          VerticalDivider(),
          Column(
            children: [
              FlatButton(
                child: Text('Si'),
                onPressed: () {
                  bloc.dispose();
                },
              ),
            ],
          )
        ],
      )
    ]),
  );
}

Widget incio(LoginBloc bloc) {
  if (bloc.nombre != null) {
    return ListTile(
        // leading: Icon(Icons.account_box,color: Colors.white),
        tileColor: Colors.black,
        title: new Row(
          children: <Widget>[
            new Text(
              bienvenido(bloc),
              style: new TextStyle(color: Colors.white, fontSize: 19.0),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        leading: Image(
          height: 24,
          image: AssetImage('assets/images/fill-1.png'),
        ));
  } else {
    return ListTile(
        tileColor: Colors.black,
        title: Text(
          'Indumex App',
          style: TextStyle(color: Colors.white, fontSize: 19.0),
        ),
        leading: Image(
          height: 24,
          image: AssetImage('assets/images/fill-1.png'),
        ));
  }
}

//fondo gradiente , debe ir dentro del body
Widget fondoGradiente() {
  Color gradientStart = Colors.blue[900]; //para cambiar los colores aca
  Color gradientEnd = Colors.blue[200]; // y aca

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
}
