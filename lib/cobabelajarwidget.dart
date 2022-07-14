import 'package:flutter/material.dart';

class ListPackage extends StatefulWidget {
  ListPackage({Key? key}) : super(key: key);

  @override
  State<ListPackage> createState() => _ListPackageState();
}

class _ListPackageState extends State<ListPackage> {
  bool isSwitch = false;
  bool? isCheckbox = false;
  String firstString = 'Status : ';
  String statusnya = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package List'),
        //automaticallyImplyLeading: false,
        // //untuk panah disable back di kiri atas
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: Icon(Icons.arrow_back_ios_rounded),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('actionbuttonbar');
            },
            icon: Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('images/images.jpg'),

            const SizedBox(
              height: 10,
            ), //jarak height box sehingga tidak ngepress kebawah

            const Divider(
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.all(
                  10.0), //memotong ujung cotak container agar tidak sampai nabrak

              padding: const EdgeInsets.all(
                  10.0), //agar container dan text tidak terlalu ngepress

              color: Colors.blueGrey,

              width: double.infinity, //full width the container

              child: const Center(
                child: Text(
                  'Text widget',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                debugPrint('Elevated Button');
              },
              child: const Text('Elevated Button'),
            ),

            OutlinedButton(
              onPressed: () {
                debugPrint('Outlined Button');
              },
              child: const Text('Outlined Button'),
            ),

            TextButton(
              onPressed: () {
                debugPrint('Text Button');
              },
              child: const Text('Text Button'),
            ),
            Switch(
                value: isSwitch,
                onChanged: (bool newBool) {
                  setState(() {
                    isSwitch = newBool;
                    if (isSwitch == true) {
                      debugPrint('Nyala bro');
                      statusnya = 'On';
                    } else {
                      debugPrint('Mati bro');
                      statusnya = 'Off';
                    }
                    debugPrint('debug: $isSwitch');
                  });
                }),
            Container(
              margin: const EdgeInsets.all(
                  10.0), //memotong ujung cotak container agar tidak sampai nabrak

              padding: const EdgeInsets.all(
                  10.0), //agar container dan text tidak terlalu ngepress

              color: Colors.blueGrey,

              width: double.infinity, //full width the container

              child: Center(
                child: Text(
                  '$firstString $statusnya ($isSwitch)',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Checkbox(
                value: isCheckbox,
                onChanged: (bool? newBool) {
                  setState(() {
                    isCheckbox = newBool;
                    debugPrint('debug: $isCheckbox');
                  });
                }),
            Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqpNGX-ZX4WgHdLo4lvLVbDQMQEHKm4LbARw&usqp=CAU'),
            Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqpNGX-ZX4WgHdLo4lvLVbDQMQEHKm4LbARw&usqp=CAU'),
          ],
        ),
      ),
    );
  }
}
