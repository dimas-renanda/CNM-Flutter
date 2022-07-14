import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 450,
        decoration: new BoxDecoration(color: Colors.green),
        padding: EdgeInsets.only(top: 35),
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "MY PROFILE",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [Text("My Profile")],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
