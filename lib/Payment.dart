import 'package:flutter/material.dart';

class Payments extends StatefulWidget {
  Payments({Key? key, required this.paketnya, required this.harganya})
      : super(key: key);

  String paketnya;
  String harganya;

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.paketnya + widget.harganya),
    );
  }
}
