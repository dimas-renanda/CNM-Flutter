import 'package:firstproject/connecteddevice.dart';
import 'package:firstproject/linkeddevice.dart';
import 'package:flutter/material.dart';

class profileFix extends StatefulWidget {
  profileFix({Key? key}) : super(key: key);

  @override
  State<profileFix> createState() => _profileFixState();
}

class _profileFixState extends State<profileFix> {
  final myControllerstatus = TextEditingController();
  final myControlleremail = TextEditingController();
  final myControllerphone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        covercolour(),
        Positioned(
          top: 90,
          child: profilebulat(),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 300),
        //   child: Text("hi"),
        // )
      ],
    ));
  }

  Widget covercolour() => SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          //padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: [
                  Color.fromARGB(255, 19, 2, 115),
                  Color.fromARGB(255, 196, 118, 2)
                ]),
          ),
          child: Container(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      "MY PROFILE",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.750075,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _isibawah(context),
                          Container(
                              height: MediaQuery.of(context).size.height * 1,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget profilebulat() => CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(
            "https://www.jobstreet.co.id/en/cms/employer/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
      );

  _isibawah(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                "Another John Doe",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 24, 38, 126),
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
          Container(
            width: 300,
            padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                _fstatus(context),
                _femail(context),
                _fphone(context),
                _buttonlinkdevice(
                  context,
                ),
                _connectedDevice(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  _fstatus(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(children: [
        TextField(
            enabled: false,
            controller: myControllerstatus..text = "Reseller",
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Status",
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 1, 34, 143),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 52, 48, 48), width: 2)),
            )),
      ]),
    );
  }

  _femail(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(children: [
        TextField(
            enabled: false,
            controller: myControlleremail..text = "dxxxx@crossnet.co.id",
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 1, 34, 143),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 52, 48, 48), width: 2)),
            )),
      ]),
    );
  }

  _fphone(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(children: [
        TextField(
            enabled: false,
            controller: myControllerphone..text = "0812345678123",
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Phone Number",
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 1, 34, 143),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 52, 48, 48), width: 2)),
            )),
      ]),
    );
  }

  _buttonlinkdevice(context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 40, 52, 189),
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => linkedDevice()),
              );
            },
            child: Text(
              "My Package",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _connectedDevice(context) {
    return Container(
      padding: EdgeInsets.only(top: 6),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 40, 52, 189),
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => connectedDevice()),
              );
            },
            child: Text(
              "Connected Device",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
