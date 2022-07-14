import 'package:firstproject/Login.dart';
import 'package:firstproject/LoginOld.dart';
import 'package:firstproject/ScanQr.dart';
import 'package:firstproject/contact_list.dart';
import 'package:firstproject/cobabelajarwidget.dart';
import 'package:firstproject/main_page.dart';
import 'package:firstproject/new_list_paket.dart';
import 'package:firstproject/jsoncontactlist.dart';
import 'package:firstproject/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'paketlistnew.dart';

//run myapp
void main() {
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
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ignore: non_constant_identifier_names
  int CurPage = 0;
  List<Widget> pages = [
    HomePage(),
    packetList(),
    //const MyLogin(title: 'Login Page'),
    QRViewExample(),
    ProfileUser(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[CurPage],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('floating di klik');
          },
          child: Icon(Icons.add_box_outlined),
        ),
        bottomNavigationBar: Container(
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
                      Icons.home_filled,
                      color: Colors.white,
                    ),
                    label: ''),
                NavigationDestination(
                    icon: Icon(Icons.list_alt_rounded, color: Colors.white),
                    label: ''),
                NavigationDestination(
                    icon: Image.asset('images/icon/Vector-9.png'), label: ''),
                NavigationDestination(
                    icon: Icon(Icons.chat_bubble, color: Colors.white),
                    label: ''),
                NavigationDestination(
                    icon: Icon(Icons.person, color: Colors.white), label: ''),
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
