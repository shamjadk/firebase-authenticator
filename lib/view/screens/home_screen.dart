import 'package:demo/controller/provider/login_provider.dart';
import 'package:demo/core/theme/typography_styles.dart';
import 'package:demo/view/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final loginNotifier = ref.read(loginProvider.notifier);
    final loginState = ref.read(loginProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 32,
          children: [
            Text("Welcome",style: TypographyStyles.normal16(Colors.blue),),
            PrimaryButtonWidget(isLoading: loginState.isLoading, buttonName: "Logout", onPressed: () {
              loginNotifier.logout(context: context);
            },)
            
          ],
        ),
      ),
    );
  }
}