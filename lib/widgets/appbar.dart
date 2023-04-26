import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

AppBar header(context) {
  return AppBar(
    title: const Text('GS Connect'),
    centerTitle: true,
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(Ionicons.notifications_outline),
      )
    ],
  );
}
