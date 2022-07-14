import 'package:flutter/material.dart';
import 'dart:convert';

class ProfileUser extends StatefulWidget {
  ProfileUser({Key? key}) : super(key: key);

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

var map = {"name": "bro", "age": 21};
String mapString = jsonEncode(map);
var mapObject = jsonDecode(mapString);

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(mapObject["name"] + ' ' + mapObject["age"].toString())
          ],
        ),
      ),
    );
  }
}
