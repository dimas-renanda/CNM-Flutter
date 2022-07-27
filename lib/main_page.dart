import 'dart:convert';
import 'package:firstproject/main.dart';
import 'package:firstproject/notification.dart';
import 'package:http/http.dart' as http;

import 'package:firstproject/cobabelajarwidget.dart';
import 'package:firstproject/jsoncontactlist.dart';
import 'package:firstproject/paketlistnew.dart';
import 'package:firstproject/webview_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firstproject/oldprofile.dart';
import 'package:intl/intl.dart';
import 'globalspublic.dart' as globals;
import 'detailVoucher.dart';

//mainpage

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

//func news
  final String apiUrlNews = "http://saurav.tech/NewsAPI/sources.json";
  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(apiUrlNews));
    //print(json.decode(result.body)['sources']);
    return json.decode(result.body)['sources'];
  }

  String nama = "John Doe !";
  String Rolenya = "Customer";

  var harga = 25000;

  late String arrayNews =
      '[{"name": "dart1","quantity": 12 },{"name": "flutter2","quantity": 25 }]';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _appbarnya(context),
              _judul(context),
              _rolenya(context),
              _paketAktif(context),
              _cardpaketnya(context),
              _rekomended(context),
              _cardrekomen(
                context,
              ),
              _news(context),
              _cardnews(
                context,
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  _appbarnya(context) {
    // return AppBar(
    //   backgroundColor: Colors.transparent,
    //   //backgroundColor: Color(0x44000000),
    //   elevation: 0,
    //   leading: Image.asset("images/crosslogo.png"),
    //   actions: [
    //     Icon(
    //       Icons.notifications,
    //       color: Colors.black87,
    //     )
    //   ],
    // );

    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 15,
          right: MediaQuery.of(context).size.width / 30,
          left: MediaQuery.of(context).size.width / 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset("images/crosslogo.png", scale: 6),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => notificationsGateway()),
                  );
                },
                child: Icon(
                  Icons.notifications,
                  size: 32,
                  color: Color.fromARGB(255, 19, 2, 115),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _notifikasi(context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  debugPrint('Notifikasi ditekan');
                },
                icon: Icon(Icons.notification_add_rounded),
              )),
        ],
      ),
    );
  }

  _judul(context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Text(
              "Hi, $nama",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 88, 160)),
            ),
          ],
        ));
  }

  _rolenya(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 2),
      child: Align(
        alignment: Alignment.topLeft,
        child: (GestureDetector(
          child: Text(
            "$Rolenya",
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromARGB(255, 19, 2, 115),
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            globals.numpagenya = 4;
            print(globals.numpagenya);
          },
        )),
      ),
    );
  }

  _paketAktif(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(top: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: (GestureDetector(
          child: Text(
            "Aktive Package",
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromARGB(255, 0, 88, 160),
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProfileUser()),
            // );
          },
        )),
      ),
    );
  }

  _cardpaketnya(context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 160,
          enableInfiniteScroll: false,
        ),
        items: [1, 2].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => voucherDetail()),
                  );
                },
                child: Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        //width: 210,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                            color: Color.fromARGB(255, 0, 88, 160),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 0, 27, 49),
                              blurRadius: 4,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                        ),
                        child: _isipaket(context, i)),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  _isipaket(context, int x) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 10),
      //margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: double.infinity,
              height: 35,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        //bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(15)),
                    // border: Border.all(
                    //   //color: Colors.green,
                    //   width: 2.0,
                    // ),
                    color: Color.fromARGB(255, 0, 88, 160)),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "  Paket Reyna",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.speed_rounded),
                    ),
                    Text("Bandwith "),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "2MB",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.phone_android_rounded),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Total Connection "),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "2 Device(s)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 25,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    //bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(19)),

                                // border: Border.all(
                                //   //color: Colors.green,
                                //   width: 2.0,
                                // ),
                                color: Color.fromARGB(255, 255, 127, 7)),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 8),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      " Active | until 30 February 2023",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),

          //Image.asset("images/crosslogo.jpeg"),
          //Text("Harga $x"),
        ],
      ),
    );
  }

  _rekomended(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(top: 25),
      child: Align(
        alignment: Alignment.topLeft,
        child: (GestureDetector(
          child: Text(
            "Recomended for you !",
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromARGB(255, 0, 88, 160),
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProfileUser()),
            // );
          },
        )),
      ),
    );
  }

  _cardrekomen(context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.25,
        enableInfiniteScroll: false,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage(
                            reqPage: "1",
                          )),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                    color: Color.fromARGB(255, 0, 88, 160),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 0, 27, 49),
                      blurRadius: 4,
                      offset: Offset(4, 8), // Shadow position
                    ),
                  ],
                ),
                child: Container(
                  //padding: EdgeInsets.symmetric(horizontal: 10),
                  //margin: EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 130,
                          height: 25,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(15)),
                                // border: Border.all(
                                //   //color: Colors.green,
                                //   width: 2.0,
                                // ),
                                color: Color.fromARGB(255, 0, 88, 160)),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 5),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      "  Paket Sova",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "2 Mbps ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [Text(" | ")],
                              ),
                              Row(
                                children: [
                                  Text(
                                    " 30 Days ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [Icon(Icons.phone_android)],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Text(
                              "Rp 25.000",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 225, 140, 13),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  _news(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(top: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: (GestureDetector(
          child: Text(
            "News",
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromARGB(255, 0, 88, 160),
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProfileUser()),
            // );
          },
        )),
      ),
    );
  }

  _cardnews(context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      // child: CarouselSlider(
      //   options: CarouselOptions(
      //     height: 180,
      //     enableInfiniteScroll: false,
      //   ),

      // ),
      child: FutureBuilder<List<dynamic>>(
        future: _fecthDataUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int itemIndex,
                      int pageViewIndex) =>
                  Container(
                      //width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          color: Color.fromARGB(255, 0, 88, 160),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 27, 49),
                            blurRadius: 4,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              GestureDetector(
                                child: Container(
                                  child: Image.asset("images/icon/newsimg.png"),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => webviewpage(
                                              urlnya: snapshot.data[itemIndex]
                                                  ['url'],
                                              judulnya: 'News',
                                            )),
                                  );
                                },
                              ),
                              Divider(
                                color: Colors.black54,
                                height: 25,
                                thickness: 2,
                                indent: 5,
                                endIndent: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    snapshot.data[itemIndex]['name'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 255.0,
                                        child: Text(
                                          snapshot.data[itemIndex]
                                              ['description'],
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          softWrap: false,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ))),
              options: CarouselOptions(
                height: 180,
                enableInfiniteScroll: false,
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
