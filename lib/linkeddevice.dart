import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'globalspublic.dart' as globals;
import 'detailPaket.dart';

class linkedDevice extends StatefulWidget {
  linkedDevice({Key? key}) : super(key: key);

  @override
  State<linkedDevice> createState() => _linkedDeviceState();
}

class _linkedDeviceState extends State<linkedDevice> {
  final myControllerstatus = TextEditingController();
  final myControlleremail = TextEditingController();
  final myControllerphone = TextEditingController();

  final String apimypackage =
      globals.uriString + "/GetUserPackage?uid=${globals.getUserID()}";

  Future<List<dynamic>> _fecthMyPackage() async {
    var result = await http.get(Uri.parse(apimypackage));
    return json.decode(result.body)['Data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: covercolour(),
    ));
  }

  Widget covercolour() => SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 25,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: [
                  Color.fromARGB(255, 19, 2, 115),
                  Color.fromARGB(255, 196, 118, 2)
                ]),
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  Column(
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
                      Text(
                        "MY PACKAGE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _isibawah(context),
                          // _isibawah(context),
                          Column(children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: MediaQuery.of(context).size.height,
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.2),
                                child: _cardDevice(context)),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget profilebulat() => CircleAvatar(
      // radius: 40,
      // backgroundColor: Colors.grey,
      // backgroundImage: NetworkImage(
      //     "https://www.jobstreet.co.id/en/cms/employer/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
      );

  _isibawah(context) {
    return SingleChildScrollView(
      child: Column(children: [
        Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Package List",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 24, 38, 126),
                  decoration: TextDecoration.underline),
            ),
          ],
        ),
      ]),
    );
  }

  _fstatus(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(children: [
        TextField(
            enabled: false,
            controller: myControllerstatus..text = "Reseller",
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Status",
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 1, 34, 143),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 52, 48, 48), width: 2)),
            )),
      ]),
    );
  }

  _femail(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(children: [
        TextField(
            enabled: false,
            controller: myControlleremail..text = "dxxxx@crossnet.co.id",
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 1, 34, 143),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 52, 48, 48), width: 2)),
            )),
      ]),
    );
  }

  _fphone(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(children: [
        TextField(
            enabled: false,
            controller: myControllerphone..text = "0812345678123",
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Phone Number",
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 1, 34, 143),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 52, 48, 48), width: 2)),
            )),
      ]),
    );
  }

  _buttonlinkdevice(context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 40, 52, 189),
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MainPage()),
              // );
            },
            child: Text(
              "Linked Devices",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _connectedDevice(context) {
    return Container(
      padding: EdgeInsets.only(top: 6),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 40, 52, 189),
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MainPage()),
              // );
            },
            child: Text(
              "Connected Devices",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _cardDevice(context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: FutureBuilder<List<dynamic>>(
        future: _fecthMyPackage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int itemIndex) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => packetDetail(
                                  namapaket:
                                      "${snapshot.data[itemIndex]['PackageName']}",
                                  activelimit1: '3-12-22',
                                  speedd1: '3',
                                  speedu1: '1',
                                  packetSID: snapshot.data[itemIndex]["SID"]
                                      .toString(),
                                )),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.laptop),
                          title: Text(
                              "${snapshot.data[itemIndex]['PackageName']}"),
                          subtitle: Text(
                              "${snapshot.data[itemIndex]['PackageName']}"),
                          trailing: IconButton(
                            icon: new Icon(Icons.qr_code_scanner_rounded),
                            highlightColor: Colors.pink,
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.INFO,
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                                buttonsBorderRadius: const BorderRadius.all(
                                  Radius.circular(2),
                                ),
                                dismissOnTouchOutside: true,
                                dismissOnBackKeyPress: false,
                                // onDissmissCallback: (type) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text('Dismissed by $type'),
                                //     ),
                                //   );
                                // },
                                headerAnimationLoop: false,
                                animType: AnimType.TOPSLIDE,
                                title: 'Package Info ',
                                body: Container(
                                  child: Column(
                                    children: [
                                      PrettyQr(
                                        data: snapshot.data[itemIndex]["SID"]
                                            .toString(),
                                        size: 200,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: Text(
                                          "SID: ${snapshot.data[itemIndex]["SID"].toString()}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                showCloseIcon: true,
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
