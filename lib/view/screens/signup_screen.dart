import 'package:demo/controller/provider/signup_provider.dart';
import 'package:demo/core/router_controller.dart';
import 'package:demo/core/theme/typography_styles.dart';
import 'package:demo/view/screens/login_screen.dart';
import 'package:demo/view/widgets/primary_button_widget.dart';
import 'package:demo/view/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signupProvider);
    final signUpNotifier = ref.read(signupProvider.notifier);

    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final signUpFormKey = useMemoized(() => GlobalKey<FormState>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: signUpFormKey,
            child: Column(
              spacing: 16,
              children: [
                SizedBox(height: 110),
                TextFieldWidget(
                  controller: nameController,
                  hintText: "Enter your name",
                  title: "Name",
                  isPassword: false,
                  enabled: !signUpState.isLoading,
                  inputType: InputType.name,
                  maxLength: 20,
                ),
                TextFieldWidget(
                  controller: emailController,
                  hintText: "Enter your email id",
                  title: "Email Id",
                  isPassword: false,
                  enabled: !signUpState.isLoading,
                  inputType: InputType.email,
                ),
                TextFieldWidget(
                  controller: passwordController,
                  hintText: "Enter your password",
                  title: "Password",
                  isPassword: true,
                  enabled: !signUpState.isLoading,
                  inputType: InputType.password,
                ),
                TextFieldWidget(
                  controller: confirmPasswordController,
                  hintText: "Confirm your password",
                  title: "Confirm Password",
                  isPassword: true,
                  enabled: !signUpState.isLoading,
                  inputType: InputType.password,
                ),
                SizedBox(height: 56),
                PrimaryButtonWidget(
                  isLoading: signUpState.isLoading,
                  buttonName: "Register",
                  onPressed: () {
                    if (signUpFormKey.currentState!.validate()) {
                      signUpNotifier.signup(
                        context: context,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        confirmPassword: confirmPasswordController.text.trim(),
                      );
                    }
                  },
                ),
                InkWell(
                  onTap: () => RouterController.pushAndReplace(
                    context: context,
                    screen: LoginScreen(),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TypographyStyles.normal14(),
                      children: [
                        TextSpan(
                          text: "Login now",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
