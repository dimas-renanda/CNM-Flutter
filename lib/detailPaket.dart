// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:flutter/material.dart';

class packetDetail extends StatefulWidget {
  String namapaket;

  String speedd1;
  String speedu1;
  String activelimit1;

  packetDetail(
      {Key? key,
      required this.namapaket,
      required this.speedd1,
      required this.speedu1,
      required this.activelimit1})
      : super(key: key);

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
                      SizedBox(height: 10),
                    ],
                  ),
                ),
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
                          fontSize: 35,
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
                      padding: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                          color: Colors.white,
                          border: Border.all(color: Colors.white)),
                      child: ListView(
                        children: [
                          createDetailSection(
                            activelimit: widget.activelimit1,
                            speedd: widget.speedd1,
                            speedu: widget.speedu1,
                          ),
                          createMRTG(),
                        ],
                      ),
                    ),
                  ]),
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
      margin: EdgeInsets.only(top: 32, left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text(
              "Bandwith",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          createCard(
            cardText: "Download",
            limit: int.parse(widget.speedd),
            current: double.parse(widget.speedd),
          ),
          createCard(
            cardText: "Upload",
            limit: int.parse(widget.speedu),
            current: double.parse(widget.speedu),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 5, top: 5),
            child: Text(
              'Active until: ${widget.activelimit}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 10,
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
  final String cardText;
  final int limit;
  final double current;
  const createCard({
    Key? key,
    required this.cardText,
    required this.limit,
    required this.current,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  limit.toString() + " Mbps",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1),
              ),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: current / 10,
                color: Color.fromARGB(255, 19, 2, 115),
                backgroundColor: Colors.white,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Current : " + current.toString()),
            )
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
              fontSize: 20,
              decoration: TextDecoration.underline,
            ),
          ),
          Image.asset("images/crosslogo.png"),
        ],
      ),
    );
  }
}
