import 'package:demo/controller/provider/login_provider.dart';
import 'package:demo/core/router_controller.dart';
import 'package:demo/core/theme/typography_styles.dart';
import 'package:demo/view/screens/signup_screen.dart';
import 'package:demo/view/widgets/primary_button_widget.dart';
import 'package:demo/view/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final loginFormKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: loginFormKey,
            child: Column(
              spacing: 16,
              children: [
                SizedBox(height: 110),
                TextFieldWidget(
                  controller: emailController,
                  hintText: "Enter your email id",
                  title: "Email Id",
                  isPassword: false,
                  enabled: !loginState.isLoading,
                  inputType: InputType.email,
                ),
                TextFieldWidget(
                  controller: passwordController,
                  hintText: "Enter your password",
                  title: "Password",
                  isPassword: true,
                  enabled: !loginState.isLoading,
                  inputType: InputType.password,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot password?",style: TypographyStyles.normal12(Colors.blue),)),
                SizedBox(height: 56),
                PrimaryButtonWidget(
                  isLoading: loginState.isLoading,
                  buttonName: "Login",
                  onPressed: () {
                    if (loginFormKey.currentState!.validate()) {
                      loginNotifier.login(
                        context: context,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    }
                  },
                ),
                InkWell(
                  onTap: () => RouterController.push(
                    context: context,
                    screen: SignupScreen(),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TypographyStyles.normal14(),
                      children: [
                        TextSpan(
                          text: "Register now",
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
