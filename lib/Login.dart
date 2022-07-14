import 'package:firstproject/ScanQr.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          _icon(context),
          Expanded(child: _Gradien(context)),
        ],
      )),
    );
  }

  _icon(context) {
    return Container(
      margin: EdgeInsets.all(50),
      child: Column(children: [
        Image.asset('images/crosslogo.jpeg'),
      ]),
    );
  }

  _Username(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(children: [
        TextField(
            decoration: InputDecoration(
          labelText: "Username Or Email",
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.white, width: 2)),
        )),
      ]),
    );
  }

  _Password(context) {
    return Container(
      child: Column(children: [
        TextField(
            decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.white, width: 2)),
        )),
      ]),
    );
  }

  _buttonLogin(context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
            child: Text(
              "Login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _buttonQR(context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRViewExample()),
              );
            },
            child: Text(
              "QR",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _Gradien(context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: [
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ]),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          _Username(context),
          _Password(context),
          _buttonLogin(context),
          _buttonQR(
            context,
          )
        ],
      ),
    );
  }
}
