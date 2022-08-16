// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings
import 'package:firstproject/main.dart';
import 'package:flutter/material.dart';
import 'globalspublic.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

class ticketingForm extends StatefulWidget {
  const ticketingForm({Key? key}) : super(key: key);

  @override
  State<ticketingForm> createState() => _ticketingFormState();
}

class _ticketingFormState extends State<ticketingForm> {
  String? dropdownValue = null;
  String? selectedIndexSID = null;
  TextEditingController topicController = new TextEditingController(),
      descController = new TextEditingController();
  final List<DropdownMenuItem> dropList = [];

  Future<Null> _fetchActivePackages() async {
    String urlString = globals.uriString;

    final response = await http.get(
        Uri.parse(urlString + "/GetUserPackage?uid=${globals.getUserID()}"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data['Data']) {
          dropList.add(DropdownMenuItem(
            value: i["SID"].toString(),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Package Name: ${i["PackageName"]}"),
                  Text("SID: ${i["SID"].toString()}")
                ],
              ),
            ),
          ));
        }
      });
    } else {
      debugPrint("Something went wrong");
    }
    debugPrint(dropList.length.toString());
  }

  void AddTicketToAPI(BuildContext context) async {
    String urlString = globals.uriString;
    var response =
        await http.post(Uri.parse(urlString + "/AddTicketing?"), body: {
      "uid": globals.getUserID().toString(),
      "sid": selectedIndexSID,
      "topic": topicController.text,
      "description": descController.text,
      "status": "Waiting",
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var addNotif =
          await http.post(Uri.parse(urlString + "/AddNotif?"), body: {
        "uid": globals.getUserID().toString(),
        "category": "Ticketing",
        "title": "New Ticket Created",
        "description":
            "Your new ticket is : ${data["Data"]["Last Inserted ID"]}"
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchActivePackages();
    debugPrint("Loading Done");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
                ),
              ),
            ),
          ),
        ),
        //Page Placeholder
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 48, top: 32),
          child: Column(children: [
            Text(
              "Tell us your problem",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
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
                  children: [
                    createDropdownSID(),
                    createTicketingIndividualForm("Topic",
                        Color.fromARGB(255, 223, 219, 219), topicController),
                    createTicketingIndividualForm("Description",
                        Color.fromARGB(255, 223, 219, 219), descController),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          AddTicketToAPI(context);
                          Alert(
                            context: context,
                            title: "Success Creating Ticket",
                            desc:
                                "Please check your notifications to view the process of the ticket",
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
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: Colors.blueGrey,
                        ),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Text("Submit")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    ))));
  }

  Widget createTicketingIndividualForm(
      String formTitle, Color bgColor, TextEditingController controller) {
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
              controller: controller,
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

  Widget createDropdownSID() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: DropdownButton<dynamic>(
        value: dropdownValue,
        hint: Text("Please choose from the dropdown list"),
        icon: Icon(Icons.arrow_drop_down),
        items: dropList,
        onChanged: (newValue) {
          setState(() {
            dropdownValue = newValue;
            selectedIndexSID = newValue;
          });
        },
      ),
    );
  }
}
