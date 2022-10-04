// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings
import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firstproject/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'globalspublic.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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

  final Map<String, String> sampleItem = {};
  String? selectedSample;

  Future<Null> _fetchActivePackages() async {
    String urlString = globals.uriString;

    final response = await http.get(
        Uri.parse(urlString + "/GetUserPackage?uid=${globals.getUserID()}"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data['Data']["Packet"]) {
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
        for (Map i in data['Data']["Voucher"]) {
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

  Future<Null> _sampleFetch() async {
    String urlString = globals.uriString;

    final response = await http.get(
        Uri.parse(urlString + "/GetUserPackageOld?uid=${globals.getUserID()}"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data['Data']) {
          debugPrint("a");
          sampleItem
              .addAll(<String, String>{i["PackageItem"]: i["SID"].toString()});
        }
      });
    } else {
      debugPrint("Something went wrong");
    }
    debugPrint("Sample Length: " + sampleItem.length.toString());
  }

  void AddTicketToAPI(BuildContext context) async {
    String urlString = globals.uriString;
    var response =
        await http.post(Uri.parse(urlString + "/AddTicketing?"), body: {
      "uid": globals.getUserID().toString(),
      "sid": selectedIndexSID,
      "topic": topicController.text.toString(),
      "description": descController.text.toString(),
      "status": "Waiting",
      "created_by": "USER",
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint(data["Message"]);
    } else {
      debugPrint("Error when trying to create ticket");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchActivePackages();
    //_sampleFetch();
    debugPrint("Loading Done");
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
                    //createSampleDropdown(),
                    createTicketingIndividualForm("Topic",
                        Color.fromARGB(255, 223, 219, 219), topicController),
                    createTicketingIndividualForm("Description",
                        Color.fromARGB(255, 223, 219, 219), descController),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedIndexSID == null) {
                            Alert(
                                context: context,
                                type: AlertType.warning,
                                content: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: AutoSizeText(
                                      "Please make sure that all of the fields are filled",
                                      textAlign: TextAlign.center,
                                      maxFontSize: 30,
                                      minFontSize: 15,
                                      maxLines: 3),
                                ),
                                buttons: [],
                                style: AlertStyle(
                                  animationType: AnimationType.fromBottom,
                                  alertBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                )).show();
                          } else {
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
                          }
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
    )));
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
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 10),
      child: DropdownButton<dynamic>(
        isExpanded: true,
        value: dropdownValue,
        hint: Text("Pick a packet"),
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

  List<DropdownMenuItem<Widget>> _addDividerAfterItems(
      Map<String, String> items) {
    List<DropdownMenuItem<Widget>> _menuItems = [];

    for (var item in items.entries) {
      _menuItems.addAll([
        DropdownMenuItem<Widget>(
          value: Container(child: Text(item.key)),
          child: Container(
            child: Column(
              children: [
                AutoSizeText("Package Name: ${item.key}"),
                Text("SID: " + item.value),
              ],
            ),
          ),
        ),
        // if (item != items)
        //   const DropdownMenuItem<dynamic>(
        //     enabled: false,
        //     child: Divider(
        //       height: 1,
        //     ),
        //   )
      ]);
    }

    return _menuItems;
  }

  List<double> _getCustomItemsHeights() {
    List<double> _itemsHeights = [];
    for (var i = 0; i < (sampleItem.length * 2) - 1; i++) {
      if (i.isEven) {
        _itemsHeights.add(50);
      } else if (i.isOdd) {
        _itemsHeights.add(50);
      }
    }

    return _itemsHeights;
  }

  Widget createSampleDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text("Pick a Packet"),
          items: _addDividerAfterItems(sampleItem),
          //customItemsHeights: _getCustomItemsHeights(),
          value: selectedSample,
          onChanged: (value) {
            setState(() {
              selectedSample = value.toString();
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          //itemPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );
  }
}
