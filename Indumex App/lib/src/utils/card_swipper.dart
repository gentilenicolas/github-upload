import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwipper extends StatelessWidget {
  final List<dynamic> transferencias;

  CardSwipper({@required this.transferencias});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.8,
        itemHeight: _screenSize.height * 0.3,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Card(
              //"http://via.placeholder.com/350x150",
           //   fit: BoxFit
                 // .fill, //imagen para que se adapte a las paginas que tien
            ),
          );
        },
        itemCount: 2, //o lista.length , en nuestro caso tenemos solo 2 opciones
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}
