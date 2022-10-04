import 'dart:convert';

import 'package:firstproject/Payment.dart';
import 'package:firstproject/paymentConfirmation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:timelines/timelines.dart';
import 'globalspublic.dart' as globals;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart';

const kTileHeight = 50.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class paymentGateway extends StatefulWidget {
  paymentGateway({
    Key? key,
    required this.packetID,
    required this.packetName,
    required this.packetPrice,
    required this.packetDuration,
    required this.packetMaxDevice,
  }) : super(key: key);
  String packetName, packetPrice, packetDuration;
  int packetID, packetMaxDevice;

  @override
  State<paymentGateway> createState() => _paymentGatewayState();
}

class _paymentGatewayState extends State<paymentGateway> {
  int transactionID = 0;
  int _packetPrice = 0;
  int curPage = 0;
  List<Widget> pages = [
    Payments(),
  ];

  int _processIndex = 0;
  final _processes = [
    'Payment',
    'Confirmation',
  ];

  @override
  void initState() {
    super.initState();
    _packetPrice = int.parse(widget.packetPrice);
    pages.add(paymentConfirmation(
      totalPrice: _packetPrice,
      transactionID: transactionID,
      packetMaxDevice: 0,
      packetDuration: 0,
      packetName: "",
      paymentChoice: "",
    ));
  }

  void postToAPI() async {
    debugPrint("Packet Duration: " + widget.packetDuration.toString());
    var response =
        await post(Uri.parse(globals.uriString + "/Transaction"), body: {
      "uid": globals.getUserID().toString(),
      "pid": widget.packetID.toString(),
      "payment": globals.paymentChoice.toString(),
      "status": "Waiting",
      "duration": widget.packetDuration, //Convert to days
      "price": widget.packetPrice,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint("Last inserted ID: " + data["Data"]["getIDLast"].toString());
      setState(() {
        transactionID = data["Data"]["getIDLast"];
        pages[1] = paymentConfirmation(
          totalPrice: _packetPrice,
          transactionID: transactionID,
          packetMaxDevice: widget.packetMaxDevice,
          packetName: widget.packetName,
          paymentChoice: globals.paymentChoice,
          packetDuration: int.parse(widget.packetDuration),
        );
      });
    }
  }

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  Widget createTimeline(BuildContext) {
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        direction: Axis.horizontal,
        connectorTheme: ConnectorThemeData(
          space: 30.0,
          thickness: 5.0,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemExtentBuilder: (_, __) =>
            MediaQuery.of(context).size.width / _processes.length,
        contentsBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              _processes[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getColor(index),
              ),
            ),
          );
        },
        indicatorBuilder: (_, index) {
          var color;
          var child;

          if (index == _processIndex) {
            color = inProgressColor;
            child = Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          } else if (index < _processIndex) {
            color = completeColor;
            child = Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            );
          } else {
            color = todoColor;
          }

          if (index <= _processIndex) {
            return Stack(
              children: [
                CustomPaint(
                  size: Size(30.0, 30.0),
                  painter: _BezierPainter(
                    color: color,
                    drawStart: index > 0,
                    drawEnd: index < _processIndex,
                  ),
                ),
                DotIndicator(
                  size: 30.0,
                  color: color,
                  child: child,
                ),
              ],
            );
          } else {
            return Stack(
              children: [
                CustomPaint(
                  size: Size(15.0, 15.0),
                  painter: _BezierPainter(
                    color: color,
                    drawEnd: index < _processes.length - 1,
                  ),
                ),
                OutlinedDotIndicator(
                  borderWidth: 4.0,
                  color: color,
                ),
              ],
            );
          }
        },
        connectorBuilder: (_, index, type) {
          if (index > 0) {
            if (index == _processIndex) {
              final prevColor = getColor(index - 1);
              final color = getColor(index);
              List<Color> gradientColors;
              if (type == ConnectorType.start) {
                gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
              } else {
                gradientColors = [
                  prevColor,
                  Color.lerp(prevColor, color, 0.5)!
                ];
              }
              return DecoratedLineConnector(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                  ),
                ),
              );
            } else {
              return SolidLineConnector(
                color: getColor(index),
              );
            }
          } else {
            return null;
          }
        },
        itemCount: _processes.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 19, 2, 115),
                  Color.fromARGB(255, 196, 118, 2)
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Back Button + Page Title
              Container(
                  padding: EdgeInsets.only(bottom: 10),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: IconButton(
                          icon: Icon(
                            Icons.navigate_before,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Payment",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      )
                    ],
                  )),
              //Page Content
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(
                            40,
                          ))),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 5,
                    ),
                    child: Column(
                      children: [
                        //Progress Bar / Timelines
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: createTimeline(context),
                        ),
                        Expanded(
                          child: pages[curPage],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          )),
          height: curPage == 0 ? MediaQuery.of(context).size.height * 0.1 : 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(widget.packetPrice),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextButton(
                  child: Text(
                    "Pay Now",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      debugPrint(globals.userChoice.toString());
                      if (globals.userChoice == true) {
                        postToAPI();
                        curPage = 1;
                        _processIndex = (_processIndex + 1) % _processes.length;
                      } else {
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Empty Choice !",
                          desc:
                              "Please choose one of the payment options in order to proceed",
                          buttons: [],
                        ).show();
                      }
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 26, 32, 100)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                ),
              ),
            ],
          ),
        ));
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
