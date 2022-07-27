import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class connectedDevice extends StatefulWidget {
  connectedDevice({Key? key}) : super(key: key);

  @override
  State<connectedDevice> createState() => _connectedDeviceState();
}

class _connectedDeviceState extends State<connectedDevice> {
  final myControllerstatus = TextEditingController();
  final myControlleremail = TextEditingController();
  final myControllerphone = TextEditingController();
  final double gradheight = 600;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: covercolour(),
    ));
  }

  Widget covercolour() => SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 25,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: [
                  Color.fromARGB(255, 19, 2, 115),
                  Color.fromARGB(255, 196, 118, 2)
                ]),
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  Column(
                    children: [
                      Align(
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
                      SizedBox(height: 10),
                      Text(
                        "DEVICE LIST",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 1,
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
                          // _isibawah(context),
                          Column(children: [
                            SingleChildScrollView(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height: MediaQuery.of(context).size.height,
                                  child: _cardDevice(context)),
                              padding: EdgeInsets.only(bottom: 20),
                            ),
                            SizedBox(height: 50)
                          ]),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  _isibawah(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Active Connection",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 24, 38, 126),
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
          //     Container(
          //       width: 300,
          //       padding: EdgeInsets.only(top: 5),
          //       child: Column(
          //         children: [
          //           _fstatus(context),
          //           _femail(context),
          //           _fphone(context),
          //           _buttonlinkdevice(
          //             context,
          //           ),
          //           _connectedDevice(context),
          //         ],
          //       ),
          //     )
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MainPage()),
              // );
            },
            child: Text(
              "Linked Devices",
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MainPage()),
              // );
            },
            child: Text(
              "Connected Devices",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _cardDevice(context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Container(
                child: Card(
                    child: ListTile(
                  leading: Icon(Icons.phone_android),
                  title: Text('MAC\t: A$index:B5:C8:D9:F5'),
                  subtitle: Text('IP \t\t\t\t\t\t: 10.10.10.$index'),
                  trailing: IconButton(
                    icon: new Icon(Icons.delete),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.WARNING,
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                        buttonsBorderRadius: const BorderRadius.all(
                          Radius.circular(2),
                        ),
                        dismissOnTouchOutside: true,
                        dismissOnBackKeyPress: false,
                        // onDissmissCallback: (type) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text('Dismissed by $type'),
                        //     ),
                        //   );
                        // },
                        headerAnimationLoop: false,
                        animType: AnimType.TOPSLIDE,
                        title: 'Disable Device ',
                        desc:
                            'Credential : ncrst$index \n Active duration : ${index + 5}h \n \n Disable this device ? ',
                        showCloseIcon: true,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    },
                  ),
                )),
              ),
            );
          }),
    );
  }
}
