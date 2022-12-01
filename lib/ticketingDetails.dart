import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  Ticket currentTicket = new Ticket(
    ticketID: "",
    ticketSID: "",
    ticketTopic: "",
    ticketDescription: "",
    ticketDetail: "",
    ticketStatus: "",
    ticketProgressDate: "",
  );
  List<TicketProgress> tckProgress = [];
  int currentArrayIndex = 0;

  var loading = false;

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
      final ticketingProgressQuery = await get(
        Uri.parse(urlString + "/GetTicketProgress?ref_id=${widget.ticketID}"),
      );

      if (ticketingProgressQuery.statusCode == 200) {
        final progressData = jsonDecode(ticketingProgressQuery.body);
        setState(() {
          currentTicket = Ticket.fromJson(data["Data"]);
          debugPrint(data["Data"].toString());

          if (progressData["Data"] != null) {
            for (Map i in progressData["Data"]) {
              tckProgress.add(TicketProgress.fromJson(i));
              debugPrint(i.values.toString());
            }
          }
          loading = true;
        });
      } else {
        debugPrint(
            "Something went wrong while trying to fetch ticketing progress");
      }
    } else {
      debugPrint("Something went wrong while trying to get specific ticket");
    }
  }

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
                child: loading == false
                    ? Container(
                        margin: EdgeInsets.all(32),
                        child: Container(
                          child: Text("Loading...."),
                        ))
                    : Container(
                        margin: EdgeInsets.all(32),
                        child: Column(
                          children: [
                            //Ticket Credentials
                            createTicketingIndividualForm(
                              "Ticket ID",
                              Colors.grey,
                              currentTicket.ticketID,
                              true,
                            ),
                            createTicketingIndividualForm(
                              "Package SID",
                              Colors.grey,
                              currentTicket.ticketSID,
                              true,
                            ),
                            createTicketingIndividualForm(
                              "Topic",
                              Colors.grey,
                              currentTicket.ticketTopic,
                              false,
                            ),
                            createTicketingIndividualForm(
                              "Description",
                              Colors.grey,
                              currentTicket.ticketDescription,
                              false,
                            ),

                            createTicketingIndividualForm(
                              "Ticket Status",
                              Colors.grey,
                              currentTicket.ticketStatus,
                              false,
                            ),

                            //HOTFIX
                            createTicketingProgressFix(
                                context,
                                currentTicket.ticketDetail,
                                currentTicket.ticketProgressDate),
                            //createTicketingProgress(context, tckProgress),
                          ],
                        ),
                      )),
          ),
        ),
      ]),
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

//HOTFIX
Widget createTicketingProgressFix(
    BuildContext context, String ticketDetail, String ticketDate) {
  return Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
    decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(22),
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Process Header / Title
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
              ),
              color: Color.fromARGB(255, 4, 32, 107)),
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 10),
            child: Text(
              "Progress",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        //Process Details / Content
        Container(
            child: Column(
          children: [
            ticketDetail.length > 0
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Progress Ticketing",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, bottom: 2),
                          alignment: Alignment.centerLeft,
                          child: Text(ticketDate),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            ticketDetail,
                          ),
                        ),
                      ],
                    ))
                : Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                      child: Text(
                        "No Progress Yet :)",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        ))
      ],
    ),
  );
}

Widget createTicketingProgress(
    BuildContext context, List<TicketProgress> progress) {
  var uniques = new LinkedHashMap<String, bool>();
  for (var s in progress) {
    uniques[s.progressDate] = true;
  }

  return Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
    decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(22),
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Process Header / Title
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
              ),
              color: Color.fromARGB(255, 4, 32, 107)),
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 10),
            child: Text(
              "Process",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        //Process Details / Content
        Container(
            child: Column(
          children: [
            progress.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: uniques.length,
                    itemBuilder: (BuildContext context, int index) {
                      return createTicketingProgressContainer(context, progress,
                          uniques.keys.elementAt(index), index);
                    },
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                      child: Text(
                        "No Progress Yet :)",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        ))
      ],
    ),
  );
}

Widget createTicketingProgressContainer(BuildContext context,
    List<TicketProgress> progress, String currentIndexName, int currentIndex) {
  int contentLength = progress
      .where((x) => x.progressDate.toString() == currentIndexName)
      .length;
  return Container(
    padding: EdgeInsets.only(bottom: 15),
    margin: EdgeInsets.only(left: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            currentIndexName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < contentLength; i++)
                createTicketingProgressAction(
                    context, progress[i + currentIndex]),
            ],
          ),
        )
      ],
    ),
  );
}

Widget createTicketingProgressAction(BuildContext context, TicketProgress obj) {
  return Container(
    padding: EdgeInsets.only(bottom: 5),
    margin: EdgeInsets.only(left: 20),
    child: Text(
      obj.progressAction,
    ),
  );
}

class Ticket {
  String ticketID,
      ticketSID,
      ticketTopic,
      ticketDescription,
      ticketDetail,
      ticketStatus,
      ticketProgressDate;

  Ticket({
    required this.ticketID,
    required this.ticketSID,
    required this.ticketTopic,
    required this.ticketDescription,
    required this.ticketDetail,
    required this.ticketStatus,
    required this.ticketProgressDate,
  });

  factory Ticket.fromJson(Map<dynamic, dynamic> json) => Ticket(
        ticketID: json["TicketID"],
        ticketSID: json["SID"],
        ticketTopic: json["Topic"],
        ticketDescription: json["Description"],
        ticketDetail: json["TicketDetail"],
        ticketStatus: json["TicketStatus"],
        ticketProgressDate: json["TicketProgressDate"],
      );
}

class TicketProgress {
  String progressDate, progressAction;

  TicketProgress({
    required this.progressDate,
    required this.progressAction,
  });

  factory TicketProgress.fromJson(Map<dynamic, dynamic> json) => TicketProgress(
        progressDate: json["ProgressDate"],
        progressAction: json["ProgressAction"],
      );
}
