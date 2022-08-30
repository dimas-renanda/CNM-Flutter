// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, camel_case_types, unused_import
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'globalspublic.dart' as globals;
import 'package:http/http.dart';

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
  List<Chats> chatLog = [];
  int currentCSID = -1;
  var loading = true;
  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Stream<Map<String, dynamic>> chatStream = (() {
    late final StreamController<Map<String, dynamic>> controller;
    controller = StreamController<Map<String, dynamic>>(
      onListen: () async {
        while (globals.inChatSession == true) {
          await Future.delayed(Duration(milliseconds: 500));
          String urlString = globals.uriString;

          final response = await get(
              Uri.parse(urlString + "/GetChat?uid=${globals.getUserID()}"));

          if (controller.isClosed == false) {
            if (response.statusCode == 200) {
              final data = jsonDecode(response.body);
              controller.add(data);
            } else {
              debugPrint(
                  "Something went wrong while trying to get the chat logs");
            }
          }
        }
      },
    );
    // controller.close();
    return controller.stream;
  })();

  //Fetch Chat Data from API
  Future<Null> _fetchChatLogs() async {
    String urlString = globals.uriString;

    final response =
        await get(Uri.parse(urlString + "/GetChat?uid=${globals.getUserID()}"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        chatLog.clear();
        if (data["Data"] != null) {
          for (Map i in data["Data"]) {
            chatLog.add(Chats.fromJson(i));

            if (i["CSID"] != "-1") {
              currentCSID = int.parse(i["CSID"]);
            }
          }
        }
        loading = false;
      });
    } else {
      debugPrint("Something went wrong while trying to get the chat logs");
    }
  }

  //Start New CS Session
  Future<Null> _startNewCSSession(String timestamp) async {
    String urlString = globals.uriString;
    String chat = textController.text;

    final response = await post(Uri.parse(urlString + "/StartChat"), body: {
      "uid": globals.getUserID().toString(),
      "chat": chat,
      "timestamp": timestamp,
    });

    if (response.statusCode == 200) {
      debugPrint("Here");
      final data = jsonDecode(response.body);

      if (data["Message"] == "Failed") {
        debugPrint(data["Data"]);
        _AddChat(timestamp, chat);
      }
    } else {
      debugPrint("Something went terribiy wrong");
    }
  }

  //To API, NOT TO Chat Bubble !!!
  Future<Null> _AddChat(String timestamp, String chat) async {
    String urlString = globals.uriString;

    final response = await post(Uri.parse(urlString + "/AddChat"), body: {
      "uid": globals.getUserID().toString(),
      "csid": currentCSID.toString(),
      "chat": chat,
      "timestamp": timestamp,
      "sent_by": "User",
    });
  }

  @override
  void initState() {
    super.initState();
    //_fetchChatLogs();
    setState(() {
      globals.inChatSession = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          //Back Button
          Container(
            margin: EdgeInsets.only(top: 16),
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  globals.inChatSession = false;
                });
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
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                    padding: EdgeInsets.only(top: 16),
                    child: StreamBuilder<Map<String, dynamic>>(
                      stream: chatStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        List<Widget> _children = [];
                        if (snapshot.hasError) {
                          debugPrint("Error in Accessing Snapshots");
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              debugPrint("Waiting for data");
                              break;
                            case ConnectionState.active:
                              debugPrint("Connection is Active");
                              chatLog.clear();
                              if (snapshot.data!["Data"] != null) {
                                for (Map i in snapshot.data!["Data"]) {
                                  chatLog.add(Chats.fromJson(i));

                                  if (i["CSID"] != "-1") {
                                    currentCSID = int.parse(i["CSID"]);
                                  }
                                }
                              }
                              for (int i = 0; i < chatLog.length; i++) {
                                //User who receives
                                if (chatLog[i].sendBy == 2) {
                                  _children.add(createChatBubble(
                                    2,
                                    chatLog[i].senderName,
                                    chatLog[i].chatContent,
                                  ));
                                }
                                //User who sends
                                else {
                                  _children.add(createChatBubble(
                                    1,
                                    chatLog[i].senderName,
                                    chatLog[i].chatContent,
                                  ));
                                }
                              }
                              ;

                              break;
                            case ConnectionState.done:
                              debugPrint("Done loading data");
                              break;
                            case ConnectionState.none:
                              debugPrint("None triggered");
                              break;
                          }
                        }
                        return Column(
                          children: _children,
                        );
                      },
                    )),
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
                                  _startNewCSSession(
                                      DateFormat('yyyy-MM-dd HH:mm:ss')
                                          .format(DateTime.now()));
                                  setState(() {});
                                  //_fetchChatLogs();
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
      )),
    );
  }

  Widget createChatBubble(int userRole, String username, String content) {
    return userRole == 2
        ?
        //User who receives
        Container(
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
        :
        //User who sends
        Container(
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

class Chats {
  String senderName, chatContent, chatTimestamp;
  int sendBy;
  Chats({
    required this.senderName,
    required this.sendBy,
    required this.chatContent,
    required this.chatTimestamp,
  });

  factory Chats.fromJson(Map<dynamic, dynamic> json) {
    Chats temp = new Chats(
      senderName: json["SentBy"] == "User" ? json["UID"] : json["CSID"],
      sendBy: json["SentBy"] == "User" ? 1 : 2,
      chatContent: json["Chat"],
      chatTimestamp: json["Timestamp"],
    );

    return temp;
  }
}
