// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors

import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class notificationsHistoryPage extends StatefulWidget {
  notificationsHistoryPage({Key? key}) : super(key: key);

  @override
  State<notificationsHistoryPage> createState() =>
      _notificationsHistoryPageState();
}

class _notificationsHistoryPageState extends State<notificationsHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return createHistoryContainer(context);
        });
  }

  Widget createHistoryContainer(BuildContext context) {
    Random rng = new Random();
    int historyContentCount = rng.nextInt(5) + 1;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 4, 32, 107),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "31 Juli 2022",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < historyContentCount; i++)
                    createHistoryContent(context, historyContentCount, i),
                ],
              ))
        ],
      ),
    );
  }

  Widget createHistoryContent(BuildContext context, int limit, int index) {
    int historyIndex = 0;
    Random rng = new Random();
    historyIndex += index;
    var f = NumberFormat("0,000", "en_US");

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
      decoration: BoxDecoration(
          border: index < limit - 1
              ? Border(bottom: BorderSide(width: 1))
              : Border()),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4),
            alignment: Alignment.centerLeft,
            child: Text(
              "Packet ${historyIndex++}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.orange[400],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 2),
            alignment: Alignment.centerLeft,
            child: rng.nextInt(5) == 0
                ? Text("Boost  :  No")
                : Text("Boost  :  Yes"),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 2),
            alignment: Alignment.centerLeft,
            child: Text(
                "Price  :   Rp. ${f.format(rng.nextInt(1000000) + 50000)}"),
          ),
        ],
      ),
    );
  }
}
