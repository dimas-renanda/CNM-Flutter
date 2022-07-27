// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, camel_case_types, unused_import
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class customerCareChat extends StatelessWidget {
  final int userRole;
  final String username;
  customerCareChat({
    Key? key,
    required this.userRole,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customerChat(userRole: this.userRole, username: this.username),
    );
  }
}

class customerChat extends StatefulWidget {
  final int userRole;
  final String username;
  customerChat({
    Key? key,
    required this.userRole,
    required this.username,
  }) : super(key: key);

  @override
  _customerChatState createState() => _customerChatState();
}

class _customerChatState extends State<customerChat> {
  List _contents = [];
  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //Get Local File Path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //Get Local File
  Future<File> get _localFile async {
    final path = await _localPath;
    if (File("$path/chatHistory.json").exists() == true) {
      return File("$path/chatHistory.json");
    } else {
      new File("$path/chatHistory.json").createSync(recursive: true);
      return File("$path/chatHistory.json");
    }
  }

  //Fetch data from json file
  Future<void> readJSON2() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    if (contents.isNotEmpty) {
      final data = await json.decode(contents);
      setState(() {
        _contents = data;
      });
    } else {
      setState(() {});
    }
  }

  //Write it to file
  Future<void> writeJSON() async {
    final file = await _localFile;

    return file.writeAsStringSync(json.encode(_contents));
  }

  @override
  void initState() {
    super.initState();
    readJSON2();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
        //Back Button
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
        //Page Title
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
        //Chat Main Page
        Container(
          child: Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    for (var i = 0; i < _contents.length; i++)
                      (createChatBubble(
                        userRole: _contents[i][0], //userRole
                        username: _contents[i][1], //username
                        content: _contents[i][2], //Content
                      )),
                  ],
                ),
              ),
            ),
          )),
        ),
        //Chat Controller
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.attach_file,
                    color: Color.fromARGB(255, 2, 35, 63),
                  ),
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(left: 4, top: 4, bottom: 4),
                        child: TextFormField(
                          controller: textController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Please enter a message",
                            filled: true,
                            fillColor: Color.fromARGB(255, 223, 219, 219),
                            contentPadding:
                                EdgeInsets.only(left: 8, bottom: 1, right: 8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 0.1,
                        margin: EdgeInsets.only(left: 5),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (textController.text.isNotEmpty) {
                                var arr = [
                                  widget.userRole,
                                  widget.username,
                                  textController.text
                                ];
                                _contents.add(arr);
                                writeJSON();
                                setState(() {});
                                textController.clear();
                              }
                            }
                          },
                          child: Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 2, 35, 63),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    ));
  }
}

class getTimeStamp extends StatelessWidget {
  const getTimeStamp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    return Text(currentPhoneDate.toString());
  }
}

class createChatBubble extends StatelessWidget {
  final String username;
  final String content;
  final int userRole;
  createChatBubble({
    Key? key,
    required this.username,
    required this.content,
    required this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: curly_braces_in_flow_control_structures
    return userRole == 1
        ? Container(
            margin:
                EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
            child: Row(children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 2, 35, 63),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            )),
                        child: Icon(
                          Icons.person,
                          size: 28,
                          color: Colors.white,
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        username,
                        maxLines: 10,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Text(content),
                ),
              ),
            ]))
        : Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.2,
            ),
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 2, 35, 63),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 2, 35, 63),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 28,
                          color: Colors.white,
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        username,
                        maxLines: 10,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
  }
}
