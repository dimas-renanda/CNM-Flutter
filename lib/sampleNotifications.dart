import 'package:firstproject/notificationsHistory.dart';
import 'package:firstproject/notificationsUpdate.dart';
import 'package:flutter/material.dart';

class sampleNotifications extends StatefulWidget {
  const sampleNotifications({Key? key}) : super(key: key);

  @override
  State<sampleNotifications> createState() => _sampleNotificationsState();
}

class _sampleNotificationsState extends State<sampleNotifications> {
  int curPage = 0;
  @override
  void initState() {
    super.initState();
    curPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
              Color.fromARGB(255, 19, 2, 115),
              Color.fromARGB(255, 196, 118, 2)
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Back Button
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            //Page Title
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              alignment: Alignment.center,
              child: Text(
                "Notifications",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white),
              ),
            ),
            //Page Content
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 2),
                  child: Column(
                    children: [
                      //Tabs Title
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextButton(
                                onPressed: () {
                                  controller.jumpToPage(0);
                                },
                                child: Text(
                                  "Updates",
                                  style: TextStyle(
                                      color: curPage == 0
                                          ? Colors.white
                                          : Color.fromARGB(255, 4, 32, 107)),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: curPage == 0
                                        ? MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 4, 32, 107))
                                        : MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: curPage == 0
                                              ? Colors.white
                                              : Color.fromARGB(
                                                  255, 4, 32, 107)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ))),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextButton(
                                onPressed: () {
                                  controller.jumpToPage(1);
                                },
                                child: Text(
                                  "History",
                                  style: TextStyle(
                                      color: curPage == 1
                                          ? Colors.white
                                          : Color.fromARGB(255, 4, 32, 107)),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: curPage == 1
                                        ? MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 4, 32, 107))
                                        : MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: curPage == 1
                                              ? Colors.white
                                              : Color.fromARGB(
                                                  255, 4, 32, 107)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Tabs Content
                      Expanded(
                        child: Container(
                          child: PageView(
                            scrollDirection: Axis.horizontal,
                            controller: controller,
                            children: [
                              notificationsUpdatePage(),
                              notificationsHistoryPage(),
                            ],
                            onPageChanged: (int page) {
                              setState(() {
                                debugPrint(page.toString());
                                curPage = page;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
