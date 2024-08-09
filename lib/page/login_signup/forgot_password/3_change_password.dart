import 'package:flutter/material.dart';
import 'package:thaijourney/constant/constant.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.height(3),
        ),
        toolbarHeight: SizeConfig.height(12),
        backgroundColor: const Color.fromARGB(255, 12, 35, 46),
      ),
    );
  }
}
