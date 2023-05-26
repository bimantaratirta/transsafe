import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:transsave/pages/auth/sign_up.dart';
import 'package:transsave/services/RequestService.dart';
import 'package:transsave/themes/color.dart';
import 'package:transsave/themes/fonts.dart';

import '../../constants/api.dart';
import '../../widgets/auth/AppButton.dart';
import '../../widgets/auth/AppTextField.dart';
import '../main_screen/main_page.dart';

class SignIn extends StatefulWidget {
  static String routeName = '/sign_in';
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Map<String, dynamic>? errorMessages;

  Future<void> login() async {
    final Map<String, dynamic> payload = {
      "username": _usernameController.text,
      "password": _passwordController.text
    };
    final response = await RequestService.post(APIService.login, payload);
    final Map<String, dynamic> result = json.decode(response.body);
    if (response.statusCode == 200) {
      Get.offAllNamed(MainPage.routeName);
      print(result);
    } else {
      setState(() {
        errorMessages = result["errors"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(21),
            color: AppColor.backgroundColor,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: AppColor.backgroundColor2),
                child: Column(
                  children: [
                    SizedBox(
                      height: 55,
                    ),
                    Text(
                      'Login',
                      style: titleStyle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Masuk ke akun Transafe Anda sekarang dan lakukan transaksi dengan aman',
                        style: subtitleStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(child: Image.asset('assets/sign_in/signIn.png')),
                    SizedBox(
                      height: 40,
                    ),
                    AppTextField(
                      controller: _usernameController,
                      labelText: 'Username',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Lupa Password?',
                        style: subtitleStyle.copyWith(color: Colors.black),
                      ),
                    ),
                    if (errorMessages != null) ...[
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          border: Border.all(
                            color: Colors.red.shade700,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var error in errorMessages!.values)
                              Row(
                                children: [
                                  Icon(Icons.circle,
                                      size: 8, color: Colors.white),
                                  SizedBox(width: 16),
                                  Text("$error",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              )
                          ],
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 30,
                    ),
                    AppButton(
                      text: "Login",
                      onTap: login,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Belum punya akun?',
                            style: mainStyle.copyWith(color: Colors.black),
                            children: [
                          TextSpan(
                              text: ' Daftar',
                              style:
                                  mainStyle.copyWith(color: AppColor.mainRed),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, SignUp.routeName))
                        ])),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
