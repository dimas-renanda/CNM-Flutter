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
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
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
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.48,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return createFAQContainer(
                                "Title ${index + 1}", "AHAHAAHAHA");
                          },
                        ),
                      ),
                    ),
                    //Create Ticket & Customer Chat Buttons
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
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
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 5, 8, 69)),
                              ),
                              child: Text(
                                "Create Ticket",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => customerCareChat(
                                              userRole: 1,
                                              username: "Budi",
                                            )));
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 5, 8, 69)),
                              ),
                              child: Text(
                                "Customer Care",
                                textAlign: TextAlign.center,
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
          ),
        ]),
      ),
    );
  }

  Widget createFAQContainer(String faqTitle, String faqContent) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 5, 8, 69),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(19))),
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                faqTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              faqContent,
              textAlign: TextAlign.left,
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
                      bottomRight: Radius.circular(19),
                    ),
                  ),
                  primary: Color.fromARGB(255, 5, 8, 69),
                )),
          ),
        ],
      ),
    );
    ;
  }
}
