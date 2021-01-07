import 'dart:async';

const List PRODUCTOS = [{'Western Union '}, 'Transferencias', 'Pagos'];

class ProductosBloc {
  Stream<List<String>> get getProductos async* {
    final List<String> productos = [];

    for (String producto in PRODUCTOS) {
      await Future.delayed(Duration(seconds: 2)); // duracion para que aparezcan las opciones

      productos.add(producto);

      yield productos;
    }
  }

  StreamController _productosContador = new StreamController<int>();
  Stream<int> get productosContadorStream => _productosContador.stream;

  ProductosBloc() {
    this.getProductos.listen(
        (productosLista) => this._productosContador.add(productosLista.length));
  }

  dispose() {
   _productosContador.close();
  }
}
