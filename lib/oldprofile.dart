import 'package:firstproject/cobaprofile.dart';
import 'package:flutter/material.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          _containergradient(context),
        ],
      )),
    );
  }

  _containergradient(context) {
    return Container(
      width: 1000,
      height: 600,
      //padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: [
              Color.fromARGB(255, 19, 2, 115),
              Color.fromARGB(255, 196, 118, 2)
              // Color(0xff1f005c),
              // Color(0xff5b0060),
              // Color(0xff870160),
              // Color(0xffac255e),
              // Color(0xffca485c),
              // Color(0xffe16b5c),
              // Color(0xfff39060),
              // Color(0xffffb56b),
            ]),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 80),
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
                _containerbawahisi(context),
              ],
            ),
            Container(
              height: 500,
              width: 1000,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _containerbawahisi(context) {
    return Container(
        child: Container(
      child: Column(
        children: [
          Text("HI"),
          UserProfileAvatar(
            avatarUrl: 'images/crosslogo.png',
            onAvatarTap: () {
              print('Avatar Tapped..');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profileFix()),
              );
            },
            notificationCount: 10,
            notificationBubbleTextStyle: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            avatarSplashColor: Colors.purple,
            radius: 100,
            isActivityIndicatorSmall: false,
            avatarBorderData: AvatarBorderData(
              borderColor: Colors.white,
              borderWidth: 5.0,
            ),
          )
        ],
      ),
    ));
  }
}
