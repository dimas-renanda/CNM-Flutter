// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';

class notificationsUpdatePage extends StatefulWidget {
  const notificationsUpdatePage({Key? key}) : super(key: key);

  @override
  State<notificationsUpdatePage> createState() =>
      _notificationsUpdatePageState();
}

class _notificationsUpdatePageState extends State<notificationsUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return createUpdateCard(
          cardTitle: "Lorem Ipsum",
          cardContent: "Dolor sit amet",
          cardTimestamp: "24 June 2022",
        );
      },
    );
  }
}

class createUpdateCard extends StatefulWidget {
  final String cardTitle;
  final String cardContent;
  final String cardTimestamp;
  createUpdateCard(
      {Key? key,
      required this.cardTitle,
      required this.cardContent,
      required this.cardTimestamp})
      : super(key: key);

  @override
  State<createUpdateCard> createState() => _createUpdateCardState();
}

class _createUpdateCardState extends State<createUpdateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
