import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:firstproject/main.dart';
import 'package:firstproject/netinfo.dart';
import 'package:firstproject/sampleNetInfo.dart';
import 'package:firstproject/webview_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("hi"),
            ));
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
      //controller?.resumeCamera();
      //controller!.resumeCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: _buildQrView(context)),
          Container(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    "Hotspot Access",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ],
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await controller?.resumeCamera();
                                          },
                                          child: Icon(Icons.qr_code_2_rounded,
                                              color: Colors.white),
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            padding: EdgeInsets.all(10),
                                            primary:
                                                Colors.blue, // <-- Button color
                                            onPrimary:
                                                Colors.red, // <-- Splash color
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Scan\nQR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) {
                                                var hcodeController =
                                                    TextEditingController();
                                                return Dialog(
                                                  backgroundColor:
                                                      Color(0xFFfafafa),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  elevation: 20,
                                                  child: Container(
                                                    height: 120, //use height
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      bottom:
                                                                          15),
                                                              child: Column(
                                                                children: [
                                                                  TextFormField(
                                                                    controller:
                                                                        hcodeController,
                                                                    decoration: InputDecoration(
                                                                        label: Text(
                                                                            "Hotspot Login"),
                                                                        hintText:
                                                                            'Hotspot Access'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      // Send them to your email maybe?
                                                                      var hlogin =
                                                                          hcodeController
                                                                              .text;

                                                                      debugPrint(
                                                                          hlogin);
                                                                      //https://www.google.com/search?q=
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: ((context) => webviewpage(
                                                                                    judulnya: "Redirect",
                                                                                    urlnya: "http://crossradius.net/login?username=$hlogin&password=$hlogin",
                                                                                  ))));
                                                                    },
                                                                    child: Text(
                                                                        'Login'),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(Icons.edit_note_rounded,
                                              color: Colors.white),
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            padding: EdgeInsets.all(10),
                                            primary:
                                                Colors.blue, // <-- Button color
                                            onPrimary:
                                                Colors.red, // <-- Splash color
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Using \nCode",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              VerticalDivider(
                                color: Colors.black54,
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            webviewpage(
                                                              judulnya:
                                                                  "Redirect",
                                                              urlnya:
                                                                  "http://crossradius.net/",
                                                            ))));
                                              },
                                              child: Icon(Icons.group,
                                                  color: Colors.white),
                                              style: ElevatedButton.styleFrom(
                                                shape: CircleBorder(),
                                                padding: EdgeInsets.all(10),
                                                primary: Colors
                                                    .blue, // <-- Button color
                                                onPrimary: Colors
                                                    .red, // <-- Splash color
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Hotspot\nStatus",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w300),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            webviewpage(
                                                              judulnya:
                                                                  "Redirect",
                                                              urlnya:
                                                                  " http://crossradius.net/logout",
                                                            ))));
                                              },
                                              child: Icon(Icons.login,
                                                  color: Colors.white),
                                              style: ElevatedButton.styleFrom(
                                                shape: CircleBorder(),
                                                padding: EdgeInsets.all(10),
                                                primary: Colors
                                                    .blue, // <-- Button color
                                                onPrimary: Colors
                                                    .red, // <-- Splash color
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Logout\nHotspot",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w300),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final temp = new sampleNetInfo();
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR"),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO,
                borderSide: const BorderSide(
                  color: Colors.green,
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
                title: 'Network Info',
                desc:
                    'MacAdd\t:${temp.macaddnya}\nIP\t:${temp.wifiIPv4}\nGateway\t:${temp.wifiGatewayIP}\nAP Name\t:${temp.wifiName}\n',
                showCloseIcon: true,
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    int c = 0;
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null && c == 0) {
        c = 1;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          borderSide: const BorderSide(
            color: Colors.green,
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
          title: 'SUCCESS',
          desc: 'Connect this device ?',
          showCloseIcon: true,
          btnCancelOnPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => MainPage(
                          reqPage: "2",
                        ))));
          },
          btnOkOnPress: () {
            c = 1;
            print("Hasil Result: $result");
            print("Hasil Result: ${result!.code.toString()}");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => webviewpage(
                          judulnya: "Redirect",
                          urlnya:
                              "http://crossradius.net/login?username=${result!.code.toString()}&password=${result!.code.toString()} ",
                        ))));
          },
        ).show();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return RawDialogRoute<void>(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return const AlertDialog(title: Text('Alert!'));
      },
    );
  }
}
