import 'package:firstproject/CustomerService.dart';
import 'package:firstproject/Login.dart';
import 'package:firstproject/ScanQr.dart';
import 'package:firstproject/cobaprofile.dart';
import 'package:firstproject/main_page.dart';
import 'package:flutter/material.dart';
import 'globalspublic.dart';
import 'package:flutter/services.dart';
import 'paketlistnew.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyLogin(title: 'Login Page'),
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
          height: MediaQuery.of(context).size.height * 0.1,
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
                      size: 40,
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
