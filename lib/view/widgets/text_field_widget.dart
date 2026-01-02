import 'package:demo/core/theme/typography_styles.dart';
import 'package:flutter/material.dart';

enum InputType { email, password, name }

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final bool isPassword;
  final bool enabled;
  final int? maxLength;
  final InputType inputType;
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    required this.enabled,
    required this.inputType,
    this.isPassword = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(title, style: TypographyStyles.normal14()),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          enabled: enabled,
          maxLength: maxLength,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          validator: (value) {
            //////////
            if (inputType == InputType.email) {
              if (value == null || value.isEmpty) {
                return "Email is required";
              } else if (!RegExp(
                r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$",
              ).hasMatch(value)) {
                return "Please enter a valid mail id";
              }
            }
            /////////
            if (inputType == InputType.password) {
              if (value == null || value.isEmpty) {
                return "Please enter password";
              } else if (value.length < 8) {
                return "Password must be atleast in 8 characters";
              }
            }
            /////////
            if (inputType == InputType.name) {
              if (value == null || value.isEmpty) {
                return "Please enter your name";
              } else if (value.length < 3) {
                return "Name must be atleast in 3 characters";
              }
            }
            return null;
          },
          buildCounter: maxLength == null
              ? null
              : (
                  BuildContext context, {
                  required int currentLength,
                  required bool isFocused,
                  required int? maxLength,
                }) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "$currentLength / $maxLength",
                      style: TextStyle(
                        color: currentLength > maxLength!
                            ? Colors.red
                            : Colors.grey,
                        fontSize: 8,
                      ),
                    ),
                  );
                },
          style: TypographyStyles.normal14(),
          decoration: InputDecoration(
            hintText: hintText,
            counterText: maxLength == null
                ? null
                : "${controller.text.length}/$maxLength",
            hintStyle: TypographyStyles.normal12(Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}
