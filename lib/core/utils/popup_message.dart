import 'package:demo/core/theme/typography_styles.dart';
import 'package:flutter/material.dart';

void popupMessage({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message, style: TypographyStyles.normal14(Colors.white))),
  );
}
