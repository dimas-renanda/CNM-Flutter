import 'package:firstproject/Login.dart';
import 'package:firstproject/connecteddevice.dart';
import 'package:firstproject/linkeddevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'globalspublic.dart' as globals;
import 'package:mac_address/mac_address.dart';
import 'Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profileFix extends StatefulWidget {
  profileFix({Key? key}) : super(key: key);

  @override
  State<profileFix> createState() => _profileFixState();
}

class _profileFixState extends State<profileFix> {
  final myControllerstatus = TextEditingController();
  final myControlleremail = TextEditingController();
  final myControllerphone = TextEditingController();
  TextEditingController phoenixController =
      new TextEditingController(text: globals.uriString);
  TextEditingController radiusController =
      new TextEditingController(text: globals.radiusString);
  String? macAdd;

  Future<void> getMac() async {
    String gotMacAdd = "";
    try {
      gotMacAdd = await GetMac.macAddress;
    } on PlatformException {
      macAdd = "Error fetching Mac Address";
    }

    setState(() {
      macAdd = gotMacAdd;
    });
  }

  //File Handling
  //File Handler
  Future<void> _loadUserID() async {
    final prefs = await SharedPreferences.getInstance();

    globals.setUserID((prefs.getInt("UID") ?? 0));
  }

  Future<void> _saveUserID() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("UID", globals.getUserID());
  }

  Future<void> _loadTokenString() async {
    final prefs = await SharedPreferences.getInstance();
    globals.tokenString = (prefs.getString("tokenString") ?? "0");
  }

  Future<void> _saveTokenString() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("tokenString", globals.tokenString);
  }

  Future<void> _modifyTokenString(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("tokenString", newValue);
  }

  Future<void> _savePhoenixServerString(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("phoenixString", newValue);
  }

  Future<void> _loadPhoenixServerString() async {
    final prefs = await SharedPreferences.getInstance();
    globals.uriString =
        (prefs.getString("phoenixString") ?? "http://phoenix.crossnet.co.id");
  }

  Future<void> _saveRadiusServerString(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("radiusString", newValue);
  }

  Future<void> _loadRadiusServerString() async {
    final prefs = await SharedPreferences.getInstance();
    globals.radiusString =
        (prefs.getString("radiusString") ?? "http://10.5.50.32:38700");
  }

  @override
  void initState() {
    super.initState();
    getMac();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(macAdd);
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
                          fontSize: 20),
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
                              height: MediaQuery.of(context).size.height * 0.2,
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
                globals.getUsername(),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 24, 38, 126),
                  //decoration: TextDecoration.underline
                ),
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
                _Logout(context),
                _adminEdit(context),
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
            controller: myControllerstatus..text = "User",
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
            controller: myControlleremail..text = globals.email,
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
            controller: myControllerphone..text = globals.phoneNum,
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
                primary: Color.fromARGB(255, 4, 32, 107),
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
                primary: Color.fromARGB(255, 4, 32, 107),
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

  _Logout(context) {
    return Container(
      padding: EdgeInsets.only(top: 6),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 4, 32, 107),
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              setState(() {
                globals.tokenString = "";
              });
              _modifyTokenString("");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyLogin(
                          title: 'login',
                          loginMessage: "Logged Out, Please Sign In Again",
                        )),
              );
            },
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _adminEdit(context) {
    return Container(
      padding: EdgeInsets.only(top: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 4, 32, 107),
            minimumSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () {
          Alert(
              context: context,
              content: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text("Phoenix String: "),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 30),
                      child: TextFormField(
                        controller: phoenixController,
                        maxLines: 2,
                        readOnly: false,
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding:
                                EdgeInsets.only(left: 8, bottom: 1, right: 8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ))),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5),
                      child: Text("Radius String: "),
                    ),
                    Container(
                      child: TextFormField(
                        controller: radiusController,
                        readOnly: false,
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding:
                                EdgeInsets.only(left: 8, bottom: 1, right: 8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
              buttons: [
                DialogButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    color: Colors.red),
                DialogButton(
                  child: Text(
                    "Save Changes",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: (() {
                    var dif = 0;
                    if (phoenixController.text.compareTo(globals.uriString) !=
                        0) {
                      debugPrint(phoenixController.text
                          .compareTo(globals.uriString)
                          .toString());
                      dif++;
                    }

                    if (radiusController.text
                            .toString()
                            .compareTo(globals.radiusString) !=
                        0) {
                      dif++;
                    }

                    if (dif > 0) {
                      setState(() {
                        globals.uriString = phoenixController.text;
                        globals.radiusString = radiusController.text;

                        _savePhoenixServerString(globals.uriString);
                        _saveRadiusServerString(globals.radiusString);
                      });
                      debugPrint("Success Applying Changes");
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  }),
                  color: Colors.green,
                ),
              ]).show();
        },
        child: Text(
          "Edit Server Profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
