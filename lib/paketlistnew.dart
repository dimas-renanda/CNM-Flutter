// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firstproject/detailVoucher.dart';

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
                title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "Choose Package",
                style: TextStyle(
                  foreground: Paint()..color = Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
              return Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: packetList_Packet(),
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
  const packetList_Packet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Image.asset("images/crosslogo.png"),
                Container(
                  padding: EdgeInsets.only(top: 3, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(width: 1.0))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                "Speed 2 Mb",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(right: 28),
                              child: Text(
                                "Rp. 15000",
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
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                "Valid for 30 Dayss",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(right: 24),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    primary: Colors.orangeAccent),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => voucherDetail()),
                                  );
                                },
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
