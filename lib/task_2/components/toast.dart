import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast fToast = FToast();

showToast(
    {required context,
    required String text,
    required Color color,
    int duration = 3}) {
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color,
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: duration),
  );
}
