import 'dart:convert';
import 'dart:async';
import 'package:crypto/crypto.dart';
import 'package:firstproject/ScanQr.dart';
import 'package:firstproject/connecteddevice.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'globalspublic.dart' as globals;

import 'main.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _isObscure = true, _veryfyingToken = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    debugPrint(globals.tokenString);
    super.initState();
    _isObscure = true;
    _loadUserID();
    _loadTokenString().then((value) => verifyToken());
  }

  //File Handling
  Future<void> _loadUserID() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      globals.setUserID((prefs.getInt("UID") ?? 0));
    });
  }

  Future<void> _saveUserID() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("UID", globals.getUserID());
    });
  }

  Future<void> _loadTokenString() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      globals.tokenString = (prefs.getString("tokenString") ?? "0");
    });
  }

  Future<void> _saveTokenString() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("tokenString", globals.tokenString);
    });
  }

  Future<void> _saveUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("Username", globals.getUsername());
    });
  }

  //Fresh Login
  dynamic loginToAPI() async {
    String urlString = globals.uriString;
    //Encoding
    var plainText = utf8.encode(passwordController.text);
    var hashedVal = sha512.convert(plainText);
    var loginResponse = await get(Uri.parse(urlString +
        "/TestToken?email=${usernameController.text}&password=${hashedVal}"));

    if (loginResponse.statusCode == 200) {
      final altData = jsonDecode(loginResponse.body);
      if (altData["Message"] == "Login Success") {
        globals.tokenString = altData["Data"]["Token"];
        globals.setUserID(int.parse(altData["Data"]["Obj"]["Id"]));
        globals.firstName = altData["Data"]["Obj"]["Firstname"];
        globals.lastName = altData["Data"]["Obj"]["Lastname"];
        globals.username = globals.firstName + globals.lastName;

        //Write to local file for further uses
        _saveTokenString();
        _saveUserID();
        _saveUsername();

        setState(() {
          _veryfyingToken = false;
        });
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      reqPage: "0",
                    )),
          );
        });
      } else {
        debugPrint("Login Failed !");
      }
    } else {
      debugPrint("Something went wrong while trying to create new token");
    }
  }

  //Verify Token First, If expired then check function above ^
  void verifyToken() async {
    _veryfyingToken = true;
    String urlString = globals.uriString;
    final response = await get(Uri.parse(
        urlString + "/VerifyToken?tokenString=${globals.tokenString}"));

    //Verify if token is still valid
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //Yes then redirect to main page with saved info
      if (data["Data"] == "Token is still valid") {
        setState(() {
          _veryfyingToken = false;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      reqPage: "0",
                    )),
          );
        });
      } else {
        Alert(
          context: context,
          buttons: [],
          title: "Failed to verify token, Please Login again",
          closeIcon: Container(),
        ).show();
      }
    } else {
      debugPrint("Something happened while trying to verify token");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          _icon(context),
          Expanded(
            child: _Gradien(context),
          ),
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
