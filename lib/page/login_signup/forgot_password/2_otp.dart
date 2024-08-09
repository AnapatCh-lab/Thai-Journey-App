// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:thaijourney/constant/constant.dart';
import 'package:thaijourney/constant/themeprovider.dart';
import 'package:thaijourney/page/login_signup/forgot_password/3_change_password.dart';
import 'package:thaijourney/util/transition_route.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int _counter = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void resendOtp() {
    setState(() {
      _counter = 60;
      startTimer();
    });
    // Add your OTP resend logic here
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
        backgroundColor: Color.fromARGB(255, 12, 35, 46),
        centerTitle: true,
        toolbarHeight: SizeConfig.height(12),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.height(3),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Added to stretch elements
          children: [
            SizedBox(height: SizeConfig.height(2)), // Adjust height as needed
            Text(
              'Please enter the OTP sent to your email',
              style: TextStyle(
                fontSize: SizeConfig.height(2.3),
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.height(3)),
            TextFormField(
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: SizeConfig.height(2)),
            Text(
              'Time remaining: $_counter seconds',
              style: TextStyle(
                fontSize: SizeConfig.height(2),
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.height(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, SlideRoute(page: ChangePassword()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.height(2),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Adjust width as needed
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        WidgetStatePropertyAll<Color>(Colors.orange),
                  ),
                  onPressed: _counter == 0 ? resendOtp : null,
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                      fontSize: SizeConfig.height(2),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
