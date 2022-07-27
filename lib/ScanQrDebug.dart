import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:firstproject/main.dart';
import 'package:firstproject/netinfo.dart';
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
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Container(
                      child: Column(
                        children: [
                          Text(
                              'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'),
                          // AlertDialog(),
                          //Text("hi")
                        ],
                      ),
                    )
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => webviewpage(
                                        urlnya: "google.co.id",
                                        judulnya: "Xnet Hotspot",
                                      )),
                            );
                          },
                          child: const Text('Test webview',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => netInfo()),
                            );
                          },
                          child: const Text('Network Information',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          child: Text('alert'),
                          onPressed: () {
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
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          },
                        ),
                      )
                      // Container(
                      //   child: _alertbuild(context),
                      // )
                    ],
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
                  desc: 'MacAdd\t:\nIP\t:\nGateway\t:\nPublicIP\t:\n',
                  showCloseIcon: true,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              },
              child: Icon(Icons.info_outline))
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
                          urlnya: result!.code.toString(),
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
