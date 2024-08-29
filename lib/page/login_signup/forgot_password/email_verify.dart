import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaijourney/constant/constant.dart';
import 'package:thaijourney/constant/themeprovider.dart';
import 'package:thaijourney/util/transition_route.dart';
import 'otp.dart';

class CheckEmailPage extends StatelessWidget {
  const CheckEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.height(3),
        ),
        toolbarHeight: SizeConfig.height(12),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 12, 35, 46),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.height(2)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.height(2)), // Adjust height as needed
              Text(
                'Enter your email',
                style: TextStyle(
                  fontSize: SizeConfig.height(2.3),
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: SizeConfig.height(2)), // Adjust the spacing as needed
              Form(
                child: TextFormField(
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.height(2)), // Add some space
              ElevatedButton(
                onPressed: () {
                  // Navigate to the OTP page
                  Navigator.push(
                    context,
                    SlideRoute(page: const OtpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.height(2.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
