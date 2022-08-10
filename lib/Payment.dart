import 'package:flutter/material.dart';
import 'globalspublic.dart' as globals;

class Payments extends StatefulWidget {
  Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  Map<String, bool> paymentOptions = {
    "Visa": false,
    "MasterCard": false,
    "Paypal": false,
  };
  bool userChose = false;

  Widget createChoice(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: MediaQuery.of(context).size.height * 0.15,
      child: Card(
        elevation: 3,
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Option Logo
            Container(
              padding: EdgeInsets.all(5),
              child: ImageIcon(
                AssetImage("images/navbaricon/paket.png"),
                size: 50,
              ),
            ),
            //Option Name
            Expanded(
              child: Container(
                child: Text(
                  "Opsi Name",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            //Radio Button
            Container(
              padding: EdgeInsets.all(5),
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget sampleRadio(int index) {
    final entryList = paymentOptions.entries.toList();

    return LabeledCheckbox(
      label: entryList[index].key,
      value: entryList[index].value,
      onChanged: (bool newValue) {
        setState(() {
          for (int i = 0; i < paymentOptions.length; i++) {
            paymentOptions.update(entryList[i].key, (value) => false);
          }
          paymentOptions.update(entryList[index].key, (value) => newValue);
          userChose = true;
        });
      },
    );
  }

  void checkOptions() {
    if (userChose == false) {
      setState(() {
        globals.userChoice = false;
        debugPrint(globals.userChoice.toString());
      });
    } else {
      setState(() {
        globals.userChoice = true;
        debugPrint(globals.userChoice.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Payment Title
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10),
          child: Text(
            "Payment Method",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        //Payment Choice
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: paymentOptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return sampleRadio(index);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: InkWell(
        onTap: () {
          onChanged(!value);
        },
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              child: ImageIcon(
                AssetImage("images/navbaricon/paket.png"),
                size: 50,
              ),
            ),
            Expanded(
                child: Text(
              label,
              style: TextStyle(
                fontSize: 20,
              ),
            )),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
