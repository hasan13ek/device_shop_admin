import 'package:device_shop_admin/utils/color.dart';
import 'package:device_shop_admin/utils/my_utils.dart';
import 'package:device_shop_admin/utils/style.dart';
import 'package:device_shop_admin/view_models/auth_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onClickSignUp}) : super(key: key);

  final VoidCallback onClickSignUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                style: MyTextStyle.sfProRegular.copyWith(
                  color: MyColors.white,
                  fontSize: 17,
                ),
                decoration: getInputDecoration(label: "Email"),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                style: MyTextStyle.sfProRegular.copyWith(
                  color: MyColors.white,
                  fontSize: 17,
                ),
                decoration: getInputDecoration(label: "Password"),
              ),
            ),
            const SizedBox(height: 100),
            TextButton(onPressed: signIn, child: const Text("Sign In")),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: MyTextStyle.sfProRegular
                    .copyWith(color: const Color(0xFFFBDF00), fontSize: 18),
                text: "Don't have an account?  ",
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickSignUp,
                    text: "Sign Up",
                    style: MyTextStyle.sfProBold.copyWith(
                      color: const Color(0xFFFBDF00),
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //" Hello World  "

  Future<void> signIn() async {
    Provider.of<AuthViewModel>(context,listen: false).signIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}