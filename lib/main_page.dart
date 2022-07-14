import 'package:firstproject/cobabelajarwidget.dart';
import 'package:firstproject/jsoncontactlist.dart';
import 'package:firstproject/paketlistnew.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firstproject/profile.dart';

import 'detailVoucher.dart';

//mainpage

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  String nama = "John Doe !";
  String Rolenya = "Customer";

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
              )
            ],
          ),
        ),
      ),
    );
  }

  _appbarnya(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      //backgroundColor: Color(0x44000000),
      elevation: 0,
      leading: Image.asset("images/crosslogo.png"),
      actions: [
        Icon(
          Icons.notifications,
          color: Colors.black87,
        )
      ],
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Text(
              "Hi, $nama",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Colors.blue),
            ),
          ],
        ));
  }

  _rolenya(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: (GestureDetector(
          child: Text(
            "$Rolenya",
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileUser()),
            );
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
            "Active Package ",
            style: TextStyle(color: Color.fromARGB(255, 0, 88, 160)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileUser()),
            );
          },
        )),
      ),
    );
  }

  _cardpaketnya(context) {
    return CarouselSlider(
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
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                      ),
                      child: _isipaket(context, i)),
                ),
              ),
            );
          },
        );
      }).toList(),
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
              width: 280,
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
                    color: Colors.blue),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(
                      "  Paket Reyna",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                                color: Color.fromARGB(255, 250, 151, 12)),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 2),
                                child: Text(
                                  " Active until xxxxxx",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
      margin: EdgeInsets.only(top: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: (GestureDetector(
          child: Text(
            "Recomended for you!",
            style: TextStyle(color: Color.fromARGB(255, 0, 88, 160)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileUser()),
            );
          },
        )),
      ),
    );
  }

  _cardrekomen(context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        enableInfiniteScroll: false,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => packetList()),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                  //padding: EdgeInsets.symmetric(horizontal: 10),
                  //margin: EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 150,
                          height: 35,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(15)),
                                // border: Border.all(
                                //   //color: Colors.green,
                                //   width: 2.0,
                                // ),
                                color: Colors.blue),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Text(
                                  "  Paket Sova",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
                                  color: Colors.orange,
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
            style: TextStyle(color: Color.fromARGB(255, 0, 88, 160)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileUser()),
            );
          },
        )),
      ),
    );
  }

  _cardnews(context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        enableInfiniteScroll: false,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset("images/crosslogo.jpeg"),
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
                              "News Topic $i",
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                                    "Putusnya jaringan kabel bawah laut yang membuat layanan internet dan tv kabel milik PT Telkom Indonesia Tbk (TLKM) terganggu.",
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
                    )));
          },
        );
      }).toList(),
    );
  }
}
