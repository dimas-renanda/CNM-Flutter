import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firstproject/ScanQr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'globalspublic.dart' as globals;

import 'main.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _isObscure = true;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _isObscure = true;
  }

  void loginToAPI() async {
    //Encoding
    var plainText = utf8.encode(passwordController.text);
    var hashedVal = sha512.convert(plainText);
    String url =
        "http://10.5.50.22:38500/login?email=${usernameController.text}&&password=${hashedVal}";
    final response = await get(Uri.parse(url));
    print(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint("First " + data['Data']['Id'].toString());
      globals.setUserID(data['Data']['Id']);
      if (data['Data']['Message'] == "Success") {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(
                    reqPage: "0",
                  )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
      margin: EdgeInsets.only(left: 50, right: 50, bottom: 50, top: 50),
      child: Column(children: [
        Image.asset('images/crosslogo.png'),
      ]),
    );
  }

  _Username(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(children: [
        TextField(
            controller: usernameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Email or username",
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
            )),
      ]),
    );
  }

  _Password(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(children: [
        TextField(
            controller: passwordController,
            autocorrect: false,
            enableSuggestions: false,
            obscureText: _isObscure,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure == false ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
            )),
      ]),
    );
  }

  _buttonLogin(context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => MainPage(
              //             reqPage: "0",
              //           )),
              // );
              loginToAPI();
            },
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 32, 107),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buttonQR(context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 32, 107),
              ),
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
            begin: Alignment.topCenter,
            end: Alignment(0.8, 1),
            colors: [
              Color.fromARGB(255, 19, 2, 115),
              Color.fromARGB(255, 196, 118, 2)
            ]),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              SizedBox(height: 40),
              _Username(context),
              _Password(context),
              _buttonLogin(context),
              _buttonQR(
                context,
              )
            ],
          ),
        ),
      ),
    );
  }
}
