import 'dart:convert';
import 'package:firstproject/main.dart';
import 'package:firstproject/notification.dart';
import 'package:firstproject/sampleNotifications.dart';
import 'package:http/http.dart' as http;

import 'package:firstproject/paketlistnew.dart';
import 'package:firstproject/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'globalspublic.dart' as globals;
import 'detailVoucher.dart';

class activePackages {
  int packageBandwith, packageTotalDevices;
  String packageName, packageExpireDate;

  activePackages({
    required this.packageBandwith,
    required this.packageTotalDevices,
    required this.packageName,
    required this.packageExpireDate,
  });

  factory activePackages.fromJson(Map<dynamic, dynamic> json) => activePackages(
        packageName: json["PackageName"],
        packageBandwith: json["PacketBandwith"],
        packageTotalDevices: json["PackageTotalDevices"],
        packageExpireDate: json["ExpireDate"],
      );

  Map<String, dynamic> toJson() => {
        "PackageName": packageName,
        "PacketBandwith": packageBandwith,
        "PackageTotalDevices": packageTotalDevices,
        "ExpireDate": packageExpireDate,
      };
}

//mainpage
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nama = "";
  String Rolenya = "Customer";
  List<activePackages> acPack = [];
  final formatCurrency =
      new NumberFormat.currency(locale: "id_ID", symbol: "Rp ");

  final String apirekomen =
      "http://phoenix.crossnet.co.id:38600/rekomenpackages";

  Future<List<dynamic>> _fecthRekomen() async {
    var result = await http.get(Uri.parse(apirekomen));
    return json.decode(result.body)['Data'];
  }

  //func news
  final String apiUrlNews = "http://saurav.tech/NewsAPI/sources.json";

  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(apiUrlNews));
    return json.decode(result.body)['sources'];
  }

  Future _fetchUsersInfo() async {
    String url =
        "http://phoenix.crossnet.co.id:38600/users?userID=${globals.getUserID()}";
    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);

    setState(() {
      globals.setUsername(data['Data']['First_name'].toString(),
          data['Data']['Last_name'].toString());
      nama = globals.getUsername();
      globals.email = data['Data']['Email'];
      globals.phoneNum = data['Data']['Phone'];
    });
  }

  Future<Null> _fetchActivePackages() async {
    String activePackURL =
        "http://phoenix.crossnet.co.id:38600/GetUserPackage?uid=${globals.getUserID()}";

    final response = await http.get(Uri.parse(activePackURL));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint(data['Data'].toString());
      setState(() {
        for (Map i in data['Data']) {
          acPack.add(activePackages.fromJson(i));
        }
      });
    } else {
      debugPrint("Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsersInfo();
    _fetchActivePackages();
  }

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
              packetCard(context),
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

  //Fix
  _appbarnya(context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 15,
          right: MediaQuery.of(context).size.width / 30,
          left: MediaQuery.of(context).size.width / 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Logo Aplikasi / Application Logo
          Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            child: Image.asset("images/crosslogo.png", scale: 5),
          ),
          //Lonceng Notifikasi / Notifications Bell
          Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.02),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => sampleNotifications()),
                );
              },
              child: Icon(
                Icons.notifications,
                size: 32,
                color: Color.fromARGB(255, 4, 32, 107),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Fix
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

  //Tunggu hex
  _judul(context) {
    return Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1, top: 20),
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

  //Tunggu hex
  _rolenya(context) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1, top: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: (GestureDetector(
          child: Text(
            "Status: $Rolenya",
            style: TextStyle(
                //decoration: TextDecoration.underline,
                color: Color.fromARGB(255, 19, 2, 115),
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            globals.numpagenya = 4;
            //print(globals.numpagenya);
          },
        )),
      ),
    );
  }

  //Section Title
  _paketAktif(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(top: 20),
      child: Container(
        alignment: Alignment.centerLeft,
        margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.085),
        child: (GestureDetector(
          child: Text(
            "Active Package",
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromARGB(255, 0, 88, 160),
                fontWeight: FontWeight.bold),
          ),
          onTap: () {},
        )),
      ),
    );
  }

  Widget packetCard(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 8,
        ),
        child: CarouselSlider.builder(
          itemCount: acPack.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => voucherDetail(
                          packetName: acPack[itemIndex].packageName,
                          expireDate: acPack[itemIndex].packageExpireDate,
                        )),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.5, vertical: 10),
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
                        offset: Offset(2, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: _isipaket(context, acPack, itemIndex),
                ),
              ),
            ),
          ),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.28,
            enableInfiniteScroll: false,
          ),
        ));
  }

  _isipaket(context, List<activePackages> data, int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //Paket Name / Card Header
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: double.infinity,
              height: 35,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(15)),
                    color: Color.fromARGB(255, 4, 32, 107)),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          data[index].packageName.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          //Paket Details / Content
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Logo
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 12,
                      top: 12,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.speed_rounded),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(Icons.phone_android_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Bandwith & Total Connections
                  Container(
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.01,
                      bottom: 15,
                      top: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(),
                          child: Text(
                            "Bandwith ",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Total Connection ",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Isi dari Bandwith & Total Connections
                  Container(
                    margin: EdgeInsets.only(right: 10, bottom: 15, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //margin: EdgeInsets.only(bottom: 4),
                          child: Text(
                            ": ${data[index].packageBandwith.toString()}MB",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            ": ${data[index].packageTotalDevices.toString()} Device",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Active Until
          Container(
            //width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              color: Colors.orange[400],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(19)),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Text(
                " Active | until ${data[index].packageExpireDate.toString()}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _rekomended(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(
          top: 25, left: MediaQuery.of(context).size.width * 0.085),
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
            //   MaterialPageRoute(builder: (context) => Profile),
            // );
          },
        )),
      ),
    );
  }

  _cardrekomen(context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      // child: CarouselSlider(
      //   options: CarouselOptions(
      //     height: 180,
      //     enableInfiniteScroll: false,
      //   ),

      // ),
      child: FutureBuilder<List<dynamic>>(
        future: _fecthRekomen(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider.builder(
              itemCount: snapshot.data.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      InkWell(
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 0, 27, 49),
                          blurRadius: 4,
                          offset: Offset(2, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      // margin: EdgeInsets.only(top: 5),
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
                                        topLeft: Radius.circular(9)),
                                    // border: Border.all(
                                    //   //color: Colors.green,
                                    //   width: 2.0,
                                    // ),
                                    color: Color.fromARGB(255, 4, 32, 107)),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 5),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          snapshot.data[itemIndex]['Name'],
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
                                        "${snapshot.data[itemIndex]['SDownload']} Mbps",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        " | ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        " ${snapshot.data[itemIndex]['Duration']} Days ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        color: Colors.grey,
                                      )
                                    ],
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
                                  "${formatCurrency.format(int.parse(snapshot.data[itemIndex]['Price']))} ",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 225, 140, 13),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
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

  _news(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(
          top: 5, left: MediaQuery.of(context).size.width * 0.1),
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
            //   MaterialPageRoute(builder: (context) => Profile),
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
