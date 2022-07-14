import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key}) : super(key: key);
  static const int itemCount = 20;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Item ${(index + 1)}'),
          leading: Icon(Icons.person),
          trailing: Icon(Icons.select_all),
          onTap: () {
            debugPrint('edit item ${(index + 1)}');
          },
          onLongPress: () {
            debugPrint('hapus item ${(index + 1)}');
          },
        );
      },
    );
  }
}
