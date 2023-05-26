import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:transsave/pages/auth/sign_in.dart';
import 'package:http/http.dart' as http;

import '../../constants/api.dart';
import '../../services/RequestService.dart';
import '../../themes/color.dart';
import '../../themes/fonts.dart';

import '../../widgets/auth/AppButton.dart';
import '../../widgets/auth/AppTextField.dart';

class SignUp extends StatefulWidget {
  static String routeName = '/sign_up';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _noHandphoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;

  Map<String, dynamic>? errorMessages;

  Future<void> register() async {
    final Map<String, dynamic> payload = {
      "name": _nameController.text,
      "username": _usernameController.text,
      "phone_number": _noHandphoneController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "passwordConfirmation": _confirmPasswordController.text
    };
    final response = await RequestService.post(APIService.register, payload);
    final Map<String, dynamic> result = json.decode(response.body);
    if (response.statusCode == 200) {
      Get.offAllNamed(SignIn.routeName);
    } else {
      setState(() {
        errorMessages = result['errors'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(21),
        color: AppColor.backgroundColor,
        height: double.infinity,
        width: double.infinity,
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
                  'Registrasi',
                  style: titleStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Mulailah pengalaman transaksi aman dengan mendaftar di Transafe',
                    style: subtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (errorMessages != null) ...[
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
                              Icon(Icons.circle, size: 8, color: Colors.white),
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
                AppTextField(controller: _nameController, labelText: 'Nama'),
                SizedBox(
                  height: 30,
                ),
                AppTextField(
                    controller: _usernameController, labelText: 'Username'),
                SizedBox(
                  height: 30,
                ),
                AppTextField(
                    controller: _noHandphoneController,
                    labelText: 'No Handphone'),
                SizedBox(
                  height: 30,
                ),
                AppTextField(controller: _emailController, labelText: 'Email'),
                SizedBox(
                  height: 30,
                ),
                AppTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: !showPassword,
                  suffixIcon: GestureDetector(
                      onTap: () => setState(() {
                            showPassword = !showPassword;
                          }),
                      child: Icon(Icons.remove_red_eye_outlined)),
                ),
                SizedBox(
                  height: 30,
                ),
                AppTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Konfirmasi Password',
                  obscureText: !showConfirmPassword,
                  suffixIcon: GestureDetector(
                      onTap: () => setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          }),
                      child: Icon(Icons.remove_red_eye_outlined)),
                ),
                SizedBox(
                  height: 24,
                ),
                AppButton(
                  text: "Daftar",
                  onTap: () {
                    register();
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Sudah punya akun?',
                        style: mainStyle.copyWith(color: Colors.black),
                        children: [
                      TextSpan(
                          text: ' Login',
                          style: mainStyle.copyWith(color: AppColor.mainRed),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.pushNamed(context, SignIn.routeName))
                    ])),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
