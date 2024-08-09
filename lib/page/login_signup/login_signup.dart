import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaijourney/constant/constant.dart';
import 'package:thaijourney/constant/themeprovider.dart';
import 'package:thaijourney/page/login_signup/forgot_password/1_email_verify.dart';
import 'package:thaijourney/util/transition_route.dart';
import 'register_page.dart';
import '../home/home.dart';

class LoginSignUpPage extends StatelessWidget {
  const LoginSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: SizeConfig.height(12),
        elevation: 1,
        title: Text(
          AppLocalizations.of(context)!.signin,
          style: TextStyle(
            fontFamily: "ThaiFont",
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.height(3.5),
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 35, 46),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(28),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/login_page.png'),
                SizedBox(height: SizeConfig.height(2)),
                TextFormField(
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    labelStyle: TextStyle(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.person_outlined),
                    prefixIconColor: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: SizeConfig.height(2)),
                TextFormField(
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    labelStyle: TextStyle(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: isDarkMode ? Colors.white : Colors.black,
                    focusColor: Colors.orange,
                    fillColor: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: SizeConfig.height(1)),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        SlideRoute(page: const CheckEmailPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: TextStyle(
                        fontSize: SizeConfig.height(2),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.forgot,
                      style: const TextStyle(
                        fontFamily: "ThaiFont",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.height(0)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        SlideRoute(page: const MyHome()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: TextStyle(
                        fontFamily: "ThaiFont",
                        fontSize: SizeConfig.height(2.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.login),
                  ),
                ),
                SizedBox(height: SizeConfig.height(3)),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDarkMode
                            ? Colors.grey
                            : Colors.black.withOpacity(0.5),
                        thickness: 0.5,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      "Or login with",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDarkMode
                            ? Colors.grey
                            : Colors.black.withOpacity(0.5),
                        thickness: 0.5,
                        indent: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.height(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle Google sign-in
                      },
                      icon: CachedNetworkImage(
                        imageUrl:
                            'https://cdn4.iconfinder.com/data/icons/logos-brands-7/512/google_logo-google_icongoogle-512.png', // Add your Google icon here
                        height: SizeConfig.height(3),
                      ),
                      label: const Text('Google'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width(9),
                            vertical: SizeConfig.height(1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              BorderSide(color: Colors.black.withOpacity(0.5)),
                        ),
                        textStyle: TextStyle(
                          fontSize: SizeConfig.height(2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle Facebook sign-in
                      },
                      icon: CachedNetworkImage(
                        imageUrl:
                            'https://upload.wikimedia.org/wikipedia/commons/6/6c/Facebook_Logo_2023.png', // Add your Facebook icon here
                        height: SizeConfig.height(3),
                      ),
                      label: const Text('Facebook'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue[800],
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width(9),
                            vertical: SizeConfig.height(1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(
                          fontSize: SizeConfig.height(2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.height(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.donthave,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          SlideRoute(page: const RegistrationPage()),
                        );
                      },
                      style: const ButtonStyle(
                        foregroundColor:
                            WidgetStatePropertyAll<Color>(Colors.orange),
                        // textStyle: WidgetStatePropertyAll(
                        //     FontWeight.bold as TextStyle?),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.register,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.height(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
