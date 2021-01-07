import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaVacia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
                            Container(
                child: FractionallySizedBox(
                  heightFactor: 1.0,
                  widthFactor: 1.0,
                  //full screen 
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                       image: AssetImage('assets/images/MVDShoppingWeb.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
