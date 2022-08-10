import 'dart:async';
import 'dart:convert';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'globalspublic.dart' as globals;
import 'package:http/http.dart';

class paymentConfirmation extends StatefulWidget {
  paymentConfirmation({
    Key? key,
    required this.totalPrice,
    required this.transactionID,
  }) : super(key: key);
  int totalPrice, transactionID;

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

    debugPrint("User ID: " +
        globals.getUserID().toString() +
        "\nTransaction ID: " +
        widget.transactionID.toString() +
        "\nNew Status : " +
        status);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint(data["Data"]["Rows"].toString());
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
          title: "Sample Alert",
          desc:
              "Your device has been connected to Crossnet. Please show your QR code if you want to use it on your other device/s. ",
          buttons: [],
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
                  builder: (context) => MainPage(
                        reqPage: "0",
                      )),
            ));
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

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Section Title
          Container(
            child: Text(
              "Payment Confirmation",
              style: TextStyle(
                fontSize: 30,
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
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Rp. ${widget.totalPrice}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "xyz - 12313131323213231231",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$minutes:$seconds",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                  ).show().then((value) => Navigator.pop(context));
                }
              },
              child: Text(
                "Cancel Payment",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
