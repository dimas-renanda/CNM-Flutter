// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'notificationsHistory.dart';
import 'notificationsUpdate.dart';

class notificationsGateway extends StatefulWidget {
  const notificationsGateway({Key? key}) : super(key: key);

  @override
  State<notificationsGateway> createState() => _notificationsGatewayState();
}

class _notificationsGatewayState extends State<notificationsGateway> {
  int curPage = 0;
  List<Widget> pages = [
    notificationsUpdatePage(),
    notificationsHistoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
              Color.fromARGB(255, 19, 2, 115),
              Color.fromARGB(255, 196, 118, 2)
            ])),
        child: Column(
          children: [
            //Back Button
            Container(
              padding: EdgeInsets.only(top: 32),
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            //Page Title
            Container(
                padding: EdgeInsets.only(top: 16, bottom: 32),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )),
            //Content
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                //Content
                child: Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08,
                    right: MediaQuery.of(context).size.width * 0.08,
                    top: MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.1),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    curPage = 0;
                                  });
                                },
                                child: Text(
                                  "Updates",
                                  style: TextStyle(
                                      color: curPage == 0
                                          ? Colors.white
                                          : Color.fromARGB(255, 4, 32, 107)),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: curPage == 0
                                        ? MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 4, 32, 107))
                                        : MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context).size.width *
                                                0.05)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide(color: Color.fromARGB(255, 4, 32, 107))))),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.15),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    curPage = 1;
                                  });
                                },
                                child: Text(
                                  "History",
                                  style: TextStyle(
                                      color: curPage == 1
                                          ? Colors.white
                                          : Color.fromARGB(255, 4, 32, 107)),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: curPage == 1
                                        ? MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 4, 32, 107))
                                        : MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context).size.width *
                                                0.05)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide(color: Color.fromARGB(255, 4, 32, 107))))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: pages[curPage],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
