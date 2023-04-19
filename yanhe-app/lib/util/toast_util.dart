import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {

  ToastUtils._();

  static void showTip(String tipMessage) {
    Fluttertoast.showToast(
      msg: tipMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM
    );
  }

  static void showSuccess(String title) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER
    );
  }

  static void showCenter(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 13,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER
    );
  }

  static void showError(String errorMessage) {
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white
    );
  }
}
