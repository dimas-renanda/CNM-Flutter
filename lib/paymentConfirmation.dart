import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class paymentConfirmation extends StatefulWidget {
  const paymentConfirmation({Key? key}) : super(key: key);

  @override
  State<paymentConfirmation> createState() => _paymentConfirmationState();
}

class _paymentConfirmationState extends State<paymentConfirmation> {
  Timer? countdownTimer;
  Duration timerDuration = Duration(minutes: 0, seconds: 2);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;

    setState(() {
      final seconds = timerDuration.inSeconds - reduceSecondsBy;

      if (seconds < 0) {
        countdownTimer!.cancel();

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
        ).show();
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
                    "Rp. Harga Disini",
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
          )
        ],
      ),
    );
  }
}
