// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings
import 'dart:ui';

import 'package:flutter/material.dart';

class voucherDetail extends StatefulWidget {
  final String packetName, expireDate;
  const voucherDetail({
    Key? key,
    required this.packetName,
    required this.expireDate,
  }) : super(key: key);

  @override
  State<voucherDetail> createState() => _voucherDetailState();
}

class _voucherDetailState extends State<voucherDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 19, 2, 115),
                Color.fromARGB(255, 196, 118, 2)
              ])),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  alignment: Alignment.centerLeft,
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
                Container(
                  child: Column(children: [
                    Text(
                      "Voucher Details",
                      style: TextStyle(
                          fontSize: 15,
                          foreground: Paint()..color = Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32),
                      child: Text(
                        widget.packetName,
                        style: TextStyle(
                          fontSize: 20,
                          foreground: Paint()..color = Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                          color: Colors.white,
                          border: Border.all(color: Colors.white)),
                      child: ListView(
                        children: [
                          Container(
                              margin:
                                  EdgeInsets.only(top: 5, left: 16, right: 16),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Today's Usage",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  createCard(
                                    downloadValue: 1500,
                                    uploadValue: 800,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 16, top: 8),
                                    child: Text(
                                      "Total: " +
                                          ((1500 + 800) / 1000).toString() +
                                          " Gb",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              margin:
                                  EdgeInsets.only(top: 32, left: 16, right: 16),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Total Usage",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  createCard(
                                    downloadValue: 8750,
                                    uploadValue: 1000000,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 16, top: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Total: " +
                                                ((8750 + 1000000) / 1000)
                                                    .toString() +
                                                " Gb",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Text(
                                            "Active until ${widget.expireDate}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 16),
                              child: createMRTG()),
                        ],
                      ),
                    ),
                  ]),
                ),
              ]),
        ))));
  }
}

class createDetailSection extends StatelessWidget {
  final String cardText;
  final double uploadValue;
  final double downloadValue;
  const createDetailSection({
    Key? key,
    required this.cardText,
    required this.uploadValue,
    required this.downloadValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Text(
            cardText,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.underline),
          ),
        ),
        createCard(
          downloadValue: this.downloadValue,
          uploadValue: this.downloadValue,
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 16),
          child: Text(
              "Total: " + (downloadValue + uploadValue).toString() + " Gb"),
        ),
      ],
    );
  }
}

//Only use for Voucher / Packet Detail
class createCard extends StatelessWidget {
  final double uploadValue;
  final double downloadValue;
  const createCard({
    Key? key,
    required this.uploadValue,
    required this.downloadValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload | " + uploadValue.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 12),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
              ),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: 0.3,
                color: Color.fromARGB(255, 19, 2, 115),
                backgroundColor: Colors.white,
              ),
            ),
            Text(
              "Download | " + downloadValue.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 6),
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: 0.6,
                color: Color.fromARGB(255, 19, 2, 115),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class createMRTG extends StatelessWidget {
  const createMRTG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Text(
            "Daily Graph",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              decoration: TextDecoration.underline,
            ),
          ),
          Image.asset("images/crosslogo.png"),
        ],
      ),
    );
  }
}
