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
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Container Title
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 5, 8, 69),
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

// class _notificationsUpdatePageState extends State<notificationsUpdatePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       body: Center(
//         child: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.centerRight,
//                   colors: [
//                 Color.fromARGB(255, 19, 2, 115),
//                 Color.fromARGB(255, 196, 118, 2)
//               ])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               //Back Button
//               Container(
//                 padding: EdgeInsets.only(top: 32),
//                 alignment: Alignment.centerLeft,
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Icon(
//                     Icons.arrow_back_ios_new_outlined,
//                     size: 25,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               //Page Title
//               Container(
//                 padding: EdgeInsets.only(top: 16, bottom: 32),
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Notifications",
//                   style: TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               //Rounded
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(50),
//                           topRight: Radius.circular(50))),
//                   //Content
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                       width: 1,
//                     )),
//                     margin: EdgeInsets.only(
//                       left: MediaQuery.of(context).size.width * 0.08,
//                       right: MediaQuery.of(context).size.width * 0.08,
//                       top: MediaQuery.of(context).size.width * 0.02,
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(bottom: 16),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(
//                                     left: MediaQuery.of(context).size.width *
//                                         0.15),
//                                 child: TextButton(
//                                   onPressed: () {},
//                                   child: Text("Updates"),
//                                   style: ButtonStyle(
//                                       padding: MaterialStateProperty.all<EdgeInsets>(
//                                           EdgeInsets.symmetric(
//                                               horizontal:
//                                                   MediaQuery.of(context).size.width *
//                                                       0.05)),
//                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                           RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               side: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 4, 50, 87))))),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(
//                                     right: MediaQuery.of(context).size.width *
//                                         0.15),
//                                 child: TextButton(
//                                   onPressed: () {},
//                                   child: Text("History"),
//                                   style: ButtonStyle(
//                                       padding: MaterialStateProperty.all<EdgeInsets>(
//                                           EdgeInsets.symmetric(
//                                               horizontal:
//                                                   MediaQuery.of(context).size.width *
//                                                       0.05)),
//                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                           RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               side: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 4, 50, 87))))),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             Text("Hello"),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
