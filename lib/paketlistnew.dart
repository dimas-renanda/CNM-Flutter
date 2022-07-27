// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

class packetList extends StatelessWidget {
  const packetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsetsDirectional.only(start: 15, bottom: 15),
                title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Choose Package",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      foreground: Paint()..color = Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            actions: [
              Image.asset("images/crosslogo.png", scale: 8),
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 16),
                child: packetList_Packet(
                  indexnya: index,
                ),
              );
            },
            childCount: 10,
          ))
        ],
      ),
    );
  }
}

class packetList_Packet extends StatelessWidget {
  int indexnya;

  packetList_Packet({Key? key, required this.indexnya}) : super(key: key);
  final _numFormat = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    indexnya = indexnya + 1;
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 5,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Image.asset("images/crosslogo.png")),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration:
                      BoxDecoration(border: Border(top: BorderSide(width: 1))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                "Speed ${indexnya + 1} Mb",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(right: 28),
                              child: Text(
                                "Rp." + _numFormat.format(15000),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 18, top: 6),
                              child: Text(
                                "Valid for 30 Days",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(right: 18),
                              height: 25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    primary: Colors.orangeAccent),
                                onPressed: () {},
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text("Buy")),
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
