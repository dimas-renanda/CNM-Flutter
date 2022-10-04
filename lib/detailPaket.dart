// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:auto_size_text/auto_size_text.dart';

class packetDetail extends StatefulWidget {
  String namapaket;
  String speedd1;
  String speedu1;
  String activelimit1;
  String packetSID;

  packetDetail({
    Key? key,
    required this.packetSID,
    required this.namapaket,
    required this.speedd1,
    required this.speedu1,
    required this.activelimit1,
  }) : super(key: key);

  @override
  State<packetDetail> createState() => _packetDetailState();
}

class _packetDetailState extends State<packetDetail> {
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
                //Back Button
                Container(
                  margin: EdgeInsets.only(top: 16),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Align(
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
                      SizedBox(height: 1),
                    ],
                  ),
                ),
                //Page Title
                Container(
                  child: Column(children: [
                    Text(
                      "Packet Details",
                      style: TextStyle(
                          fontSize: 15,
                          foreground: Paint()..color = Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32),
                      child: Text(
                        widget.namapaket,
                        style: TextStyle(
                          fontSize: 20,
                          foreground: Paint()..color = Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: Stack(
                    children: [
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
                              alignment: Alignment.center,
                              child: Text(
                                "QR Code",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 8,
                                bottom: 20,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Alert(
                                    buttons: [
                                      DialogButton(
                                        color: Colors.red[300],
                                        child: Text(
                                          "Close",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      )
                                    ],
                                    context: context,
                                    title:
                                        "QR Code for Package ${widget.namapaket}",
                                    content: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 20),
                                          child: PrettyQr(
                                            size: 300,
                                            data: widget.packetSID,
                                            errorCorrectLevel:
                                                QrErrorCorrectLevel.M,
                                            roundEdges: true,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                              "Content:\nSID: ${widget.packetSID}"),
                                        )
                                      ],
                                    ),
                                  ).show();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        child: PrettyQr(
                                      size: 150,
                                      data: widget.packetSID,
                                      errorCorrectLevel: QrErrorCorrectLevel.M,
                                      roundEdges: true,
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            createDetailSection(
                              activelimit: widget.activelimit1,
                              speedd: widget.speedd1,
                              speedu: widget.speedu1,
                            ),
                            createMRTG(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ))));
  }
}

class createDetailSection extends StatefulWidget {
  String speedd;
  String speedu;
  String activelimit;
  createDetailSection(
      {Key? key,
      required this.speedd,
      required this.speedu,
      required this.activelimit})
      : super(key: key);

  @override
  State<createDetailSection> createState() => _createDetailSectionState();
}

class _createDetailSectionState extends State<createDetailSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "Packet Status",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          createCard(
            packetStatus: "Active",
            connectivityStatus: "Connected to Internet",
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 8, top: 4),
            child: AutoSizeText(
              'Active until: ${widget.activelimit}',
              minFontSize: 10,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Only use for Voucher / Packet Detail
class createCard extends StatelessWidget {
  final String packetStatus, connectivityStatus;
  const createCard({
    Key? key,
    required this.packetStatus,
    required this.connectivityStatus,
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
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    packetStatus,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Connectivity: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  connectivityStatus,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
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
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 10, top: 20, left: 8),
            child: Text(
              "Daily Graph",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Image.asset(
            "images/mrtg.png",
          ),
        ],
      ),
    );
  }
}
