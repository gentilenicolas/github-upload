import 'package:flutter/material.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/realizar_op.dart';
import 'package:formvalidation/src/pages/solicitud_moneycard.dart';



class AyudaPage extends StatefulWidget {
  @override
  _BottomBar createState() => new _BottomBar();
}

class _BottomBar extends State<AyudaPage> {
  int _pageIndex = 0;
  PageController _pageController;

//paginas

  List<Widget> tabPages = [
    HomePage(),
    SolicitudMoneycard(),
    RealizarOp(),
   // LoginPage(),
  ];

  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("BottomNavigationBar", style: TextStyle(color: Colors.white)),
      //   backgroundColor: Colors.deepPurple,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem( icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Moneycard"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Sucursales"),
       //  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Login"),
     
        ],

      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
}

// class Pantalla1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.green,
//             child: Center(child: Text("Pantalla 1")),
//     );
//   }
// }

// class Pantalla2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.yellow,
//       child: Center(child: Text("Pantalla 2")),
//     );
//   }
// }

// class Pantalla3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.cyan,
//       child: Center(child: Text("Pantalla 3")),
//     );
//   }
// }