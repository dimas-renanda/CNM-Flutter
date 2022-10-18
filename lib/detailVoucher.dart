// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globalspublic.dart' as globals;

class AvailableUsers {
  String username;
  int userUptime, userDownload, userUpload;
  AvailableUsers({
    required this.username,
    required this.userUptime,
    required this.userDownload,
    required this.userUpload,
  });

  factory AvailableUsers.fromJson(Map<dynamic, dynamic> json) => AvailableUsers(
        username: json["Username"],
        userUptime: json["Uptime"],
        userDownload: json["Download"],
        userUpload: json["Upload"],
      );

  int getTotalUsage() {
    return userDownload + userUpload;
  }
}

class voucherDetail extends StatefulWidget {
  final String packetName, expireDate, sid;
  final int packetMaxDevice;
  const voucherDetail({
    Key? key,
    required this.packetMaxDevice,
    required this.sid,
    required this.packetName,
    required this.expireDate,
  }) : super(key: key);

  @override
  State<voucherDetail> createState() => _voucherDetailState();
}

class _voucherDetailState extends State<voucherDetail> {
  CarouselController _carouselController = CarouselController();
  int currentCarrouselIndex = 0,
      abnormalUser = 0,
      totalUpload = 0,
      totalDownload = 0;
  List<AvailableUsers> arrAvUs = [];

  @override
  void initState() {
    super.initState();
    checkConntoRadius();

    _fetchVoucherDetails();
    if (globals.radiusConnection) {
    } else {}
  }

  Future<Null> _fetchVoucherDetails() async {
    String phoenixUrl = globals.uriString, radiusUrl = globals.radiusString;

    final voucherResponse = await get(Uri.parse(radiusUrl +
        "/GetAvailableUsers?username = ${globals.getUsername()}&sid=${widget.sid}"));
    debugPrint("SID: " + widget.sid.toString());
    if (voucherResponse.statusCode == 200) {
      final data = jsonDecode(voucherResponse.body);

      if (data["Data"] != null) {
        for (Map i in data["Data"]) {
          setState(() {
            _fetchUserUsage(i["Username"]);
          });
        }
      } else {
        setState(() {
          abnormalUser = 1;
        });
        debugPrint("No Data Returned From API");
      }
    } else {
      debugPrint("Something went wrong while trying to get available users");
    }
  }

  Future<Null> _fetchUserUsage(String username) async {
    String radiusUrl = globals.radiusString;

    final usageResponse =
        await get(Uri.parse(radiusUrl + "/GetUserUsage?username=${username}"));

    if (usageResponse.statusCode == 200) {
      final data = jsonDecode(usageResponse.body);

      setState(() {
        arrAvUs.add(AvailableUsers.fromJson(data["Data"]));
        totalUpload += int.parse(data["Data"]["Upload"].toString());
        totalDownload += int.parse(data["Data"]["Download"].toString());
      });
    }
  }

  Future<void> _saveTokenString() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("tokenString", globals.tokenString);
    });
  }

  void checkConntoRadius() async {
    String testUrl = globals.radiusString;

    try {
      final response = await get(Uri.parse(testUrl)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          debugPrint("Something happened");
          throw SocketException("Address Unreachable");
        },
      );
      setState(() {
        globals.radiusConnection = true;
      });
    } on SocketException catch (e) {
      setState(() {
        globals.radiusConnection = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Abnormal: " + abnormalUser.toString());
    return Scaffold(
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
          //Page Title
          Container(
            child: Column(children: [
              Text(
                "Voucher Details",
                style: TextStyle(
                    fontSize: 15, foreground: Paint()..color = Colors.white),
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
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListView(
                      children: [
                        abnormalUser == 0
                            ? Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "QR Codes",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              top: 8,
                            ),
                            child: abnormalUser == 0
                                ? arrAvUs.length == widget.packetMaxDevice
                                    ? CarouselSlider.builder(
                                        carouselController: _carouselController,
                                        itemCount: arrAvUs.length,
                                        itemBuilder: (BuildContext context,
                                                int itemIndex,
                                                int pageViewIndex) =>
                                            InkWell(
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ],
                                              context: context,
                                              title:
                                                  "QR Code for Device - ${arrAvUs[itemIndex].username}",
                                              content: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 20),
                                                    child: PrettyQr(
                                                      size: 300,
                                                      data: arrAvUs[itemIndex]
                                                          .username,
                                                      errorCorrectLevel:
                                                          QrErrorCorrectLevel.M,
                                                      roundEdges: true,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        "Content:\nUsername: ${arrAvUs[itemIndex].username}"),
                                                  ),
                                                ],
                                              ),
                                            ).show();
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  arrAvUs[itemIndex].username,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                  child: PrettyQr(
                                                size: 150,
                                                data:
                                                    arrAvUs[itemIndex].username,
                                                errorCorrectLevel:
                                                    QrErrorCorrectLevel.M,
                                                roundEdges: true,
                                              )),
                                            ],
                                          ),
                                        ),
                                        options: CarouselOptions(
                                            enableInfiniteScroll: false,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                currentCarrouselIndex = index;
                                              });
                                            }),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: CircularProgressIndicator(),
                                      )
                                : Container(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.08,
                                      right: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 60),
                                          child: Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                            size: 150,
                                          ),
                                        ),
                                        AutoSizeText(
                                          "There seems to be a problem with this packet / voucher, please contact CS for further information",
                                          presetFontSizes: [20, 10],
                                          maxLines: 10,
                                          minFontSize: 10,
                                          wrapWords: true,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ))),

                        //Individual Usage
                        arrAvUs.length == widget.packetMaxDevice
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: 20, left: 16, right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "Total Uptime: " +
                                            arrAvUs[currentCarrouselIndex]
                                                .userUptime
                                                .toString() +
                                            " Seconds",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                    createCard(
                                      downloadValue:
                                          arrAvUs[currentCarrouselIndex]
                                              .userDownload,
                                      uploadValue:
                                          arrAvUs[currentCarrouselIndex]
                                              .userUpload,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 16, top: 8),
                                      child: Text(
                                        "Total: " +
                                            arrAvUs[currentCarrouselIndex]
                                                .getTotalUsage()
                                                .toString() +
                                            " Bytes",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ))
                            : Container(),

                        abnormalUser == 0
                            ?
                            //Total Usage
                            Container(
                                margin: EdgeInsets.only(
                                    top: 32, left: 16, right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "Total Usage",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                    createCard(
                                      downloadValue: totalDownload,
                                      uploadValue: totalUpload,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 16, top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              child: AutoSizeText(
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                "Total: " +
                                                    ((8750 + 1000000) / 1000)
                                                        .toString() +
                                                    " Gb",
                                                maxLines: 1,
                                                minFontSize: 10,
                                              )),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              child: AutoSizeText(
                                                "Active until ${widget.expireDate}",
                                                minFontSize: 5,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ))
                            : Container(),
                        //MRTG Image
                        abnormalUser == 0
                            ? Container(
                                margin: EdgeInsets.only(top: 16),
                                child: createMRTG())
                            : Container()
                      ],
                    ),
                  )),
            ]),
          ),
        ],
      ),
    )));
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
        // createCard(
        //   downloadValue: this.downloadValue,
        //   uploadValue: this.downloadValue,
        // ),
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
  final int uploadValue;
  final int downloadValue;
  const createCard({
    Key? key,
    required this.uploadValue,
    required this.downloadValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Upload : " + ((uploadValue * 8) / 1000000).toString() + " Mb",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              "Download : " +
                  ((downloadValue * 8) / 1000000).toString() +
                  " Mb",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
          Image.asset("images/mrtg.png"),
        ],
      ),
    );
  }
}
