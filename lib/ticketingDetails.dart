import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'globalspublic.dart' as globals;

class ticketingDetails extends StatefulWidget {
  final int userID, ticketID;
  ticketingDetails({
    Key? key,
    required this.userID,
    required this.ticketID,
  }) : super(key: key);

  @override
  State<ticketingDetails> createState() => _ticketingDetailsState();
}

class _ticketingDetailsState extends State<ticketingDetails> {
  List<Ticket> currentTicket = [];

  @override
  void initState() {
    super.initState();
    _fetchSpecificTicket();
  }

  Future<Null> _fetchSpecificTicket() async {
    String urlString = globals.uriString;
    final response = await get(
      Uri.parse(urlString +
          "/GetUserTicket?uid=${widget.userID.toString()}&ref_id=${widget.ticketID}"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        debugPrint("Here");
        debugPrint(data["Data"].toString());
        for (Map i in data["Data"]) {
          currentTicket.add(Ticket.fromJson(i));
        }
      });
    } else {
      debugPrint("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder(
      future: _fetchSpecificTicket(),
      builder: (BuildContext context, AsyncSnapshot<Null> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(child: Text("Loading"));
          default:
            if (snapshot.hasError) {
              return new Text("Error");
            } else {
              debugPrint(currentTicket.length.toString());
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                      Color.fromARGB(255, 19, 2, 115),
                      Color.fromARGB(255, 196, 118, 2)
                    ])),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.all(32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // createTicketingIndividualForm(
                                  //   "Ticket ID",
                                  //   Colors.grey,
                                  //   currentTicket[0].ticketID,
                                  //   true,
                                  // ),
                                  // createTicketingIndividualForm(
                                  //   "Package SID",
                                  //   Colors.grey,
                                  //   currentTicket[0].ticketSID,
                                  //   true,
                                  // ),
                                  // createTicketingIndividualForm(
                                  //   "Topic",
                                  //   Colors.grey,
                                  //   currentTicket[0].ticketTopic,
                                  //   false,
                                  // ),
                                  // createTicketingIndividualForm(
                                  //   "Description",
                                  //   Colors.grey,
                                  //   currentTicket[0].ticketDescription,
                                  //   false,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              );
            }
        }
      },
    )));
  }
}

Widget createTicketingIndividualForm(
    String formTitle, Color bgColor, String formContent, bool editable) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            formTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 16),
          height: 40,
          child: TextFormField(
            initialValue: formContent,
            readOnly: editable,
            decoration: InputDecoration(
                filled: true,
                fillColor: bgColor,
                contentPadding: EdgeInsets.only(left: 8, bottom: 1, right: 8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ))),
          ),
        )
      ],
    ),
  );
}

class Ticket {
  String ticketID, ticketSID, ticketTopic, ticketDescription;

  Ticket({
    required this.ticketID,
    required this.ticketSID,
    required this.ticketTopic,
    required this.ticketDescription,
  });

  factory Ticket.fromJson(Map<dynamic, dynamic> json) => Ticket(
        ticketID: json["ID"],
        ticketSID: json["SID"],
        ticketTopic: json["Topic"],
        ticketDescription: json["Description"],
      );
}
