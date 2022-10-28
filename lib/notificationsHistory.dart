// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors

import 'dart:collection';
import 'dart:math';

import 'package:firstproject/cobabelajarwidget.dart';
import 'package:firstproject/linkeddevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'globalspublic.dart' as globals;
import 'package:http/http.dart';

class notificationsHistoryPage extends StatefulWidget {
  notificationsHistoryPage({Key? key}) : super(key: key);

  @override
  State<notificationsHistoryPage> createState() =>
      _notificationsHistoryPageState();
}

class _notificationsHistoryPageState extends State<notificationsHistoryPage> {
  List<History> listHistory = [];
  int currentArrayIndex = 0;

  Future<Null> _fetchUserHistory() async {
    String urlString = globals.uriString;
    debugPrint("User ID: " + globals.getUserID().toString());
    final response = await get(Uri.parse(
            urlString + "/UserHistory?uid=${globals.getUserID().toString()}"))
        .timeout(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data['Data']) {
          listHistory.add(History.fromJson(i));
        }
      });
    } else {
      debugPrint("Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserHistory();
  }

  @override
  Widget build(BuildContext context) {
    var uniques = new LinkedHashMap<String, bool>();
    for (var s in listHistory) {
      uniques[s.paymentCreationDate] = true;
    }
    return ListView.builder(
        itemCount: uniques.length,
        itemBuilder: (BuildContext context, int index) {
          return createHistoryContainer(
              context, listHistory, uniques.keys.elementAt(index));
        });
  }

  Widget createHistoryContainer(
      BuildContext context, List<History> arrHistory, String currentIndex) {
    int historyContentCount = listHistory
        .where((x) => x.paymentCreationDate.toString() == currentIndex)
        .length;
    // debugPrint(
    //     "Length for ${currentIndex} : " + historyContentCount.toString());
    // debugPrint("Total Length: " + listHistory.length.toString());
    currentArrayIndex += historyContentCount;
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
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
                currentIndex,
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
                    createHistoryContent(
                        context, historyContentCount, i, arrHistory[i]),
                ],
              ))
        ],
      ),
    );
  }

  Widget createHistoryContent(
      BuildContext context, int limit, int index, History historyObj) {
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
              historyObj.packageName,
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
            child: Text(
              "Payment Option:\t ${historyObj.paymentOption}",
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 2),
            alignment: Alignment.centerLeft,
            child: Text(
                "Price  :   Rp. ${f.format(historyObj.historyPaymentValue)}"),
          ),
        ],
      ),
    );
  }
}

class History {
  int historyPaymentValue;
  String packageName, paymentOption, paymentCreationDate;

  History({
    required this.historyPaymentValue,
    required this.packageName,
    required this.paymentOption,
    required this.paymentCreationDate,
  });

  factory History.fromJson(Map<dynamic, dynamic> json) => History(
        historyPaymentValue: json["TotalPayment"],
        packageName: json["PacketName"],
        paymentOption: json["PaymentChoice"],
        paymentCreationDate: json["Date"],
      );
}
