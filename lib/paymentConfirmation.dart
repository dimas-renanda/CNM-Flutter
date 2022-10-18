import 'dart:async';
import 'dart:convert';

import 'package:firstproject/main.dart';
import 'package:firstproject/webview_page.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'globalspublic.dart' as globals;
import 'package:http/http.dart';

class paymentConfirmation extends StatefulWidget {
  paymentConfirmation({
    Key? key,
    required this.totalPrice,
    required this.transactionID,
    required this.packetMaxDevice,
    required this.packetName,
    required this.paymentChoice,
    required this.packetDuration,
    required this.packetID,
  }) : super(key: key);
  int totalPrice, transactionID, packetMaxDevice, packetDuration, packetID;
  String packetName, paymentChoice;

  @override
  State<paymentConfirmation> createState() => _paymentConfirmationState();
}

class _paymentConfirmationState extends State<paymentConfirmation> {
  Timer? countdownTimer;
  Duration timerDuration = Duration(minutes: 0, seconds: 5);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void putToAPI(String status) async {
    var response = await put(
        Uri.parse(globals.uriString + "/UpdateTransactionStatus"),
        body: {
          "uid": globals.getUserID().toString(),
          "id": widget.transactionID.toString(),
          "status": status,
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      var radiusResponse = await post(
          Uri.parse(globals.radiusString + "/CreateNewUser?"),
          body: {
            "username": globals.getUsername().toString(),
            "sid": data["Data"]["SID"]["New ID"].toString(),
            "packet_max": widget.packetMaxDevice.toString(),
            "email": globals.email.toString(),
            "phone": globals.phoneNum.toString(),
            "address": globals.address.toString(),
            "packetname": widget.packetName.toString(),
            "paymentMethod": widget.paymentChoice.toString(),
            "expiredDate": widget.packetDuration.toString(),
            "ordertaker": "System",
            "profileName": "samplehotspot-2M",
          });
      debugPrint("After Radius User Creation");

      if (radiusResponse.statusCode == 200) {
        final radiusData = jsonDecode(radiusResponse.body);
        debugPrint("Success Creating New User");
        debugPrint(
            "New User: " + radiusData["Data"]["User Created"].toString());

        var paymentResponse = await post(
            Uri.parse(globals.radiusString + "/CreateNewPayment?"),
            body: {
              "invoiceID": widget.transactionID.toString(),
              "amountPaid": widget.totalPrice.toString(),
              "paymentType": "3",
              "paymentNotes": "Payment For " + widget.packetName.toString()
            });

        if (paymentResponse.statusCode == 200) {
          debugPrint("Success Adding Payment to Radius");
        } else {
          debugPrint("Failed Adding Payment to Radius");
        }
      } else {
        final radiusData = jsonDecode(radiusResponse.body);
        debugPrint("Failed to create new user in Radius Server");
        Alert(
          context: context,
          buttons: [],
          closeIcon: Container(),
          desc: radiusData["Message"].toString(),
        ).show();
      }
    }
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void cancelTimer() {
    setState(() {
      countdownTimer!.cancel();

      putToAPI("Cancelled");
    });
  }

  void setCountDown() {
    final reduceSecondsBy = 1;

    setState(() {
      final seconds = timerDuration.inSeconds - reduceSecondsBy;

      if (seconds < 0) {
        countdownTimer!.cancel();

        putToAPI("Approved");
        Alert(
          context: context,
          title: "Success",
          desc:
              "Your device has been connected to Crossnet. Please show your QR code if you want to use it on your other device/s. ",
          buttons: [
            DialogButton(
                child: Text("Home"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => MainPage(
                                reqPage: "0",
                              ))));
                }),
            DialogButton(
                child: Text("CrossRadius"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => webviewpage(
                                judulnya: "Redirect",
                                urlnya:
                                    "http://crossradius.net/login?username=${globals.currentUser}&password=${globals.currentUser} ",
                              ))));
                })
          ],
          style: AlertStyle(
            animationType: AnimationType.fromBottom,
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            titleStyle: TextStyle(
              color: Color.fromARGB(255, 4, 32, 107),
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ).show().then((value) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => MainPage(
                      reqPage: "0",
                    )))));
      } else {
        timerDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(timerDuration.inMinutes.remainder(60));
    final seconds = strDigits(timerDuration.inSeconds.remainder(60));

    debugPrint(globals.paymentChoice);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 20,
        ),
        child: Column(
          children: [
            //Section Title
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment Confirmation",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
              ))),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Total Pembayaran",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Rp. ${widget.totalPrice}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 4, 32, 107),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 30,
                      top: 22,
                    ),
                    child: Text(
                      "xyz - 1231231231",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Berakhir Dalam :",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    "$minutes:$seconds",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            //Cancel Button
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                onPressed: () {
                  if (countdownTimer == null || countdownTimer!.isActive) {
                    cancelTimer();

                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Payment Cancelled",
                      desc: "Redirrecting you to packet list",
                      buttons: [],
                    ).show().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MainPage(
                                  reqPage: "0",
                                )))));
                  }
                },
                child: Text(
                  "Cancel Payment",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              child: SizedBox(
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
