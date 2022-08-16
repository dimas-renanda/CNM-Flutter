import 'package:flutter/material.dart';

class ticketingDetails extends StatefulWidget {
  const ticketingDetails({Key? key}) : super(key: key);

  @override
  State<ticketingDetails> createState() => _ticketingDetailsState();
}

class _ticketingDetailsState extends State<ticketingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
            Color.fromARGB(255, 19, 2, 115),
            Color.fromARGB(255, 196, 118, 2)
          ])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        //Back Button
        Container(
          margin: EdgeInsets.only(top: 16),
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        //Page Placeholder
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 16, top: 32),
          child: Column(children: [
            Text(
              "Detail Ticketing",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                foreground: Paint()..color = Colors.white,
              ),
            ),
          ]),
        ),
        //Main Form
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
          ),
        ),
      ]),
    )));
  }
}
