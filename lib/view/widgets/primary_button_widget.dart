import 'package:demo/core/theme/typography_styles.dart';
import 'package:demo/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final bool isLoading;
  final String buttonName;
  final VoidCallback onPressed;
  const PrimaryButtonWidget({
    super.key,
    required this.isLoading,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: ScreenSize.width(context),
        height: 56,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Text(
                  buttonName,
                  style: TypographyStyles.normal14(Colors.white),
                ),
        ),
      ),
    );
  }
}
