import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwipper extends StatelessWidget {
  final List<dynamic> transferencias;

  CardSwipper({@required this.transferencias});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 200.0,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: 250.0,
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/350x150",
            fit: BoxFit.fill, //imagen para que se adapte a las paginas que tien
          );
        },
        itemCount: 2,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }

  // final _screenSize = MediaQuery.of(context).size;

  //   return Container(
  //     padding: EdgeInsets.only(top: 10.0),
  //     child: Swiper(
  //       layout: SwiperLayout.STACK,
  //       itemWidth: _screenSize.width * 0.9,
  //       itemHeight: _screenSize.height * 0.4,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Column(
  //           children: <Widget>[

  //             _pruebaCard(),
  //              _pruebaCard(),
  //             //  _contenedorPersona(context),
  //           ],
  //         );

  //         // return new Image.network(
  //         //   "http://via.placeholder.com/350x150",
  //         //   fit: BoxFit.fill, //imagen para que se adapte a las paginas que tien
  //         // );
  //       },
  //       itemCount: 2,
  //       pagination: new SwiperPagination(),
  //       control: new SwiperControl(),
  //     ),
  //   );



}
