// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'customerCare.dart';
import 'notification.dart';
import 'ticketing.dart';

class customerCareGateway extends StatelessWidget {
  customerCareGateway({Key? key}) : super(key: key);

  List<Widget> sliver = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 15,
                  right: MediaQuery.of(context).size.width / 30),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => notificationsGateway()),
                  );
                },
                child: Icon(
                  Icons.notifications,
                  size: 32,
                  color: Color.fromARGB(255, 19, 2, 115),
                ),
              )),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 90, bottom: 16),
                    child: Text(
                      "How Can We Help You ?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: createFAQContainer(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: createFAQContainer(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: createFAQContainer(),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin: EdgeInsets.only(
                              left: 64, right: 64, top: 32, bottom: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ticketingForm()));
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 5, 8, 69)),
                            ),
                            child: Text(
                              "Create Ticket",
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin:
                              EdgeInsets.only(left: 64, right: 64, bottom: 128),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => customerCareChat(
                                            userRole: 0,
                                            username: "Budi",
                                          )));
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 5, 8, 69)),
                            ),
                            child: Text(
                              "Customer Care ",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class createFAQContainer extends StatelessWidget {
  createFAQContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 5, 8, 69),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
          child: Container(
            margin: EdgeInsets.only(left: 16),
            child: Text(
              "Lorem ipsum dolor sit amet",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet ",
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.only(top: 16),
          child: ElevatedButton(
              onPressed: () {},
              child: Container(
                child: Icon(Icons.support_agent),
              ),
              style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                primary: Color.fromARGB(255, 5, 8, 69),
              )),
        ),
      ],
    );
  }
}
