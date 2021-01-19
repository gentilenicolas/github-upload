import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/productos_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

final productosBloc = new ProductosBloc();

class Productos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          /*appBar: AppBar(
                  title: StreamBuilder(
               stream: productosBloc.productosContadorStream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Text('Productos (${snapshot.data ?? 0})');
                }),s
          ),*/
          body: StreamBuilder(
        stream: productosBloc.getProductos,
        builder: (_, AsyncSnapshot snapshot) {
          final productos = snapshot.data ?? [];
          //contador de productos
          return ListView.builder(
              // itemCount: productos.length,
              itemBuilder: (_, i) {
            return ListTile(
                title: Text(productos[i]),
                onTap: () {
                  const url = 'https://www.google.com';
                  launch(url);
                });
          });
        },
      )),
    );
  }
/*
  _redirectURL(String url) async {

    const url = 'https://www.google.com';
    
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/
}
