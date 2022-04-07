import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final authController = Get.find<FireAuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("This is login page")),
    );
  }
}
