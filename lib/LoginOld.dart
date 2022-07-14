import 'package:firstproject/ScanQr.dart';
import 'package:firstproject/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Container(
                      //   width: 85,
                      //   height: 85,
                      //   decoration: BoxDecoration(
                      //       color: Colors.blue[900],
                      //       borderRadius: BorderRadius.circular(30)),
                      // ),
                      // Icon(
                      //   Icons.settings,
                      //   color: Colors.grey,
                      //   size: 40,
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "Highlands Latin School",
                  //   style: TextStyle(fontSize: 25, color: Colors.blue[900]),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "Canvas Grades",
                  //   style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  // ),
                  Image.asset('images/crosslogo.jpeg'),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Email", border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        //obscureText: _obscureText,
                        decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  padding: EdgeInsets.all(15),
                  color: Colors.blue[900],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text(
                    "Scan QR",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  padding: EdgeInsets.all(15),
                  color: Color.fromARGB(255, 247, 149, 29),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRViewExample()),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
