// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'package:firstproject/main.dart';
import 'package:firstproject/ticketingDetails.dart';
import 'package:flutter/material.dart';
import 'globalspublic.dart' as globals;
import 'package:http/http.dart';

class notificationsUpdatePage extends StatefulWidget {
  const notificationsUpdatePage({Key? key}) : super(key: key);

  @override
  State<notificationsUpdatePage> createState() =>
      _notificationsUpdatePageState();
}

class _notificationsUpdatePageState extends State<notificationsUpdatePage> {
  List<Updates> listUpdates = [];

  Future<Null> _fetchUserUpdates() async {
    String urlString = globals.uriString;

    final response = await get(Uri.parse(
        urlString + "/GetUserNotifications?uid=${globals.getUserID()}"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data['Data']) {
          listUpdates.add(Updates.fromJson(i));
        }
      });
    } else {
      debugPrint("Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listUpdates.length,
      itemBuilder: (BuildContext context, int index) {
        debugPrint(listUpdates[index].updateCategory);
        return InkWell(
          onTap: listUpdates[index].updateCategory == "Ticketing"
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ticketingDetails()),
                  );
                }
              : () {},
          child: createUpdateCard(
            cardTitle: listUpdates[index].updateTitle,
            cardContent: listUpdates[index].updateDescription,
            cardTimestamp: listUpdates[index].updateDate,
          ),
        );
      },
    );
  }
}

class createUpdateCard extends StatefulWidget {
  final String cardTitle;
  final String cardContent;
  final String cardTimestamp;
  createUpdateCard({
    Key? key,
    required this.cardTitle,
    required this.cardContent,
    required this.cardTimestamp,
  }) : super(key: key);

  @override
  State<createUpdateCard> createState() => _createUpdateCardState();
}

class _createUpdateCardState extends State<createUpdateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.only(
        bottom: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Container Title
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 4, 32, 107),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                widget.cardTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //Container Content
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
              border: Border.all(width: 1),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    widget.cardContent,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(right: 15, bottom: 15, top: 15),
                  child: Text(
                    widget.cardTimestamp,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.orange[500],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Updates {
  String updateTitle, updateDescription, updateDate, updateCategory;

  Updates({
    required this.updateTitle,
    required this.updateDescription,
    required this.updateDate,
    required this.updateCategory,
  });

  factory Updates.fromJson(Map<dynamic, dynamic> json) => Updates(
        updateTitle: json["Title"],
        updateDescription: json["Description"],
        updateDate: json["Date"],
        updateCategory: json["Category"],
      );

  Map<String, dynamic> toJson() => {
        "title": updateTitle,
        "description": updateDescription,
        "date": updateDate,
      };
}
