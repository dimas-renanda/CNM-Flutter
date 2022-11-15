import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:firstproject/CustomerService.dart';
import 'package:firstproject/Login.dart';
import 'package:firstproject/ScanQr.dart';
import 'package:firstproject/cobaprofile.dart';
import 'package:firstproject/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'paketlistnew.dart';
import 'globalspublic.dart' as globals;

//run myapp
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

//MyApp State
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _loadTokenString() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      globals.tokenString = (prefs.getString("tokenString") ?? "0");
    });
  }

  Future<void> _loadUserID() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      globals.setUserID((prefs.getInt("UID") ?? 0));
    });
  }

  Widget startWidget = Scaffold(
      body: Center(
    child: Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    ),
  ));

  void verifyToken(BuildContext context) async {
    String urlString = globals.uriString;
    final response = await get(Uri.parse(
        urlString + "/VerifyToken?tokenString=${globals.tokenString}"));
    //Verify if token is still valid
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //Yes then redirect to main page with saved info
      if (data["Data"] == "Token is still valid") {
        setState(() {
          startWidget = MainPage(
            reqPage: '0',
          );
        });
      } else {
        setState(() {
          startWidget = MyLogin(
            title: "",
            loginMessage: "Token Expired, Please Login Again",
          );
        });
      }
    } else {
      debugPrint("Something happened while trying to verify token");
    }
  }

  void checkConn() async {
    String testUrl = globals.uriString;

    try {
      final response = await get(Uri.parse(testUrl)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          debugPrint("Something happened");
          throw SocketException("Address Unreachable");
        },
      );
      setState(() {
        globals.internetConnection = true;
        _loadUserID();
        _loadTokenString().then((value) => verifyToken(context));
      });
    } on SocketException catch (e) {
      setState(() {
        startWidget = MyLogin(
          title: "",
          loginMessage: "Not Connected To Internet",
        );
        globals.internetConnection = false;
      });
    }
  }

  Future<void> _savePhoenixServerString(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("phoenixString", newValue);
  }

  Future<void> _loadPhoenixServerString() async {
    final prefs = await SharedPreferences.getInstance();
    globals.uriString = (prefs.getString("phoenixString") ??
        "http://phoenix.crossnet.co.id:38600");
  }

  Future<void> _saveRadiusServerString(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("radiusString", newValue);
  }

  Future<void> _loadRadiusServerString() async {
    final prefs = await SharedPreferences.getInstance();
    globals.radiusString =
        (prefs.getString("radiusString") ?? "http://10.5.50.32:38700");
  }

  @override
  void initState() {
    super.initState();
    checkConn();
    setState(() {
      //_loadPhoenixServerString();
      //_loadRadiusServerString();
      globals.radiusString = "http://10.5.50.32:38700";
      globals.uriString = "http://phoenix.crossnet.co.id:38600";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: startWidget,
    );
  }
}

class MainPage extends StatefulWidget {
  String? reqPage;
  MainPage({Key? key, this.reqPage}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ignore: non_constant_identifier_names

  int CurPage = 0;
  List<Widget> pages = [
    HomePage(),
    packetList(),
    QRViewExample(),
    customerCareGateway(),
    profileFix(),
  ];

  @override
  void initState() {
    super.initState();

    CurPage = int.parse(widget.reqPage!);
    if (CurPage == null) {
      CurPage = 0;
    }
  }

  //Bottom Navbar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[CurPage],
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            child: NavigationBar(
              backgroundColor: Color.fromARGB(255, 1, 36, 113),
              destinations: [
                NavigationDestination(
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    label: ''),
                NavigationDestination(
                    icon: ImageIcon(
                      AssetImage("images/navbaricon/paket.png"),
                      color: Colors.white,
                      size: 30,
                    ),
                    label: ''),
                NavigationDestination(
                    icon: ImageIcon(
                      AssetImage("images/navbaricon/qr.png"),
                      color: Colors.white,
                      size: 45,
                    ),
                    label: ''),
                NavigationDestination(
                    icon: ImageIcon(
                      AssetImage("images/navbaricon/cs.png"),
                      color: Colors.white,
                      size: 35,
                    ),
                    label: ''),
                NavigationDestination(
                    icon: ImageIcon(
                      AssetImage("images/navbaricon/profile.png"),
                      color: Colors.white,
                      size: 25,
                    ),
                    label: ''),
              ],
              onDestinationSelected: (int index) {
                setState(() {
                  CurPage = index;
                });
              },
              selectedIndex: CurPage,
            ),
          ),
        ));
  }
}
