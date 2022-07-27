// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';

class ticketingForm extends StatelessWidget {
  const ticketingForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
            Color.fromARGB(255, 19, 2, 115),
            Color.fromARGB(255, 196, 118, 2)
          ])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 48, top: 32),
          child: Column(children: [
            Text(
              "Tell us your problem",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                foreground: Paint()..color = Colors.white,
              ),
            ),
          ]),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: Container(
              margin: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "ID",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    height: 30,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 223, 219, 219),
                          contentPadding:
                              EdgeInsets.only(left: 8, bottom: 1, right: 8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Package SID",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    height: 30,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 223, 219, 219),
                          contentPadding:
                              EdgeInsets.only(left: 8, bottom: 1, right: 8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Topic",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    height: 30,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 223, 219, 219),
                          contentPadding:
                              EdgeInsets.only(left: 8, bottom: 1, right: 8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 223, 219, 219),
                          contentPadding:
                              EdgeInsets.only(left: 8, bottom: 1, right: 8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ))),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.blueGrey,
                      ),
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Text("Submit")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    ))));
  }
}
