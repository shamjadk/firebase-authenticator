import 'package:flutter/material.dart';

class TypographyStyles {
  /////
  static TextStyle normal12([Color? color]) {
    return TextStyle(
      fontSize: 12,
      color: color ?? Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  /////
  static TextStyle normal14([Color? color]) {
    return TextStyle(
      fontSize: 14,
      color: color ?? Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  /////
  static TextStyle normal16([Color? color]) {
    return TextStyle(
      fontSize: 16,
      color: color ?? Colors.black,
      fontWeight: FontWeight.normal,
    );
  }
}
