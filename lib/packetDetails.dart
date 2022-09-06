import 'package:firstproject/paymentGateway.dart';
import 'package:flutter/material.dart';

class packetDetails extends StatefulWidget {
  int packetID;
  String packetName, packetPrice, packetDuration, packetSpeed, packetDesc;
  packetDetails({
    Key? key,
    required this.packetName,
    required this.packetPrice,
    required this.packetDuration,
    required this.packetSpeed,
    required this.packetDesc,
    required this.packetID,
  }) : super(key: key);

  @override
  State<packetDetails> createState() => _packetDetailsState();
}

class _packetDetailsState extends State<packetDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
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
                padding: EdgeInsets.only(bottom: 15, top: 45),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Package Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  ],
                ),
              ),
              //Page Content
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: //Packet Detail
                        Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          //Packet Name & Price
                          Container(
                            padding: EdgeInsets.only(bottom: 20, top: 20),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.packetName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10,
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Rp. " + widget.packetPrice,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                //Packet Detail goes here
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    margin: EdgeInsets.only(
                                      top: 3,
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 118, 115, 115),
                                            width: 1,
                                          ))),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.hourglass_empty,
                                                size: 25,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Text(
                                                  "Packet Duration",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    widget.packetDuration +
                                                        " Days",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 118, 115, 115),
                                            width: 1,
                                          ))),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.signal_wifi_0_bar,
                                                size: 25,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Text(
                                                  "Internet",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Unlimited",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 118, 115, 115),
                                            width: 1,
                                          ))),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.speed,
                                                size: 25,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Text(
                                                  "Speed",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    widget.packetSpeed +
                                                        " Mbps",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          //Packet Description
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Text(
                                    "Packet Description",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10,
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Text("Detail Paket Phoenix : "),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10,
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Text(widget.packetDesc),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //Buy Button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: Icon(Icons.shopping_cart)),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10, top: 10),
                              child: Text(
                                "Total Price : ",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Rp. " + widget.packetPrice,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 5, 8, 69),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => paymentGateway(
                                        packetID: widget.packetID,
                                        packetName: widget.packetName,
                                        packetPrice: widget.packetPrice,
                                        packetDuration: widget.packetDuration,
                                      )));
                        },
                        child: Text(
                          "Buy",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
