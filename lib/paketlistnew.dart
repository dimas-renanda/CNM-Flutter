// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'dart:convert';
import 'package:firstproject/cobabelajarwidget.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

class packetList extends StatefulWidget {
  const packetList({Key? key}) : super(key: key);

  @override
  State<packetList> createState() => _packetListState();
}

class _packetListState extends State<packetList> {
  int index = 0;
  var _numFormat = NumberFormat("#,##0", "en_US");
  List<Packages> listPackages = [];

  Future<Null> _fetchDataProduct() async {
    String url = "http://phoenix.crossnet.co.id:38600/packages";

    var loading = true;
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      loading = true;
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        for (Map i in data['Data']) {
          listPackages.add(Packages.fromJson(i));
        }

        loading = false;
      });
    } else {
      debugPrint("Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDataProduct();
  }

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
              Image.asset("images/crosslogo.png", scale: 6),
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final getData = listPackages[index];
              return Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 16),
                child: loadPackages(
                  context,
                  getData.packetName,
                  getData.packetPrice,
                  getData.packetDuration,
                ),
              );
            },
            childCount: listPackages.length,
          ))
        ],
      ),
    );
  }

  Widget loadPackages(BuildContext context, String packetName,
      String packetPrice, String packetDuration) {
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
                //Package Logo
                Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Image.asset("images/crosslogo.png")),
                //Package Details
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration:
                      BoxDecoration(border: Border(top: BorderSide(width: 1))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Packet Name
                          Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                packetName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )),
                          //Packet Price
                          Container(
                              margin: EdgeInsets.only(right: 28),
                              child: Text(
                                packetPrice,
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
                          //Packet Duration
                          Container(
                              margin: EdgeInsets.only(left: 18, top: 6),
                              child: Text(
                                "$packetDuration Days",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          //Buy Button
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

class Packages {
  int packetId, totalDevices;
  String packetName,
      packetPrice,
      packetType,
      packetDownloadSpeed,
      packetUploadSpeed,
      packetDuration;

  Packages({
    required this.packetId,
    required this.totalDevices,
    required this.packetName,
    required this.packetPrice,
    required this.packetType,
    required this.packetDownloadSpeed,
    required this.packetUploadSpeed,
    required this.packetDuration,
  });

  factory Packages.fromJson(Map<dynamic, dynamic> json) => Packages(
        packetId: json["Id"],
        packetName: json["Name"],
        packetPrice: json["Price"],
        packetType: json["Type"],
        packetDownloadSpeed: json["SDownload"],
        packetUploadSpeed: json["SUpload"],
        totalDevices: json["TotalDevices"],
        packetDuration: json["Duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": packetId,
        "total_devices": totalDevices,
        "name": packetName,
        "price": packetPrice,
        "type": packetPrice,
        "s_download": packetDownloadSpeed,
        "s_upload": packetUploadSpeed,
        "duration_days": packetDuration,
      };
}
