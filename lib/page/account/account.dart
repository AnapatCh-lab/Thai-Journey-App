import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:thaijourney/constant/constant.dart';
import 'package:thaijourney/constant/themeprovider.dart';
import 'package:thaijourney/page/account/sub_page/account_appearance.dart';
import 'package:thaijourney/page/account/sub_page/account_privacy.dart';
import 'package:thaijourney/page/login_signup/login_signup.dart';
import 'package:thaijourney/util/transition_route.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.settings,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.height(3.2),
                  fontFamily: "ThaiFont",
                ),
              ),
              // Language switch
              Row(
                children: [
                  Text('EN',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  Switch(
                    value: themeProvider.locale.languageCode == 'th',
                    onChanged: (bool value) {
                      themeProvider.setLocale(
                        value ? const Locale('th') : const Locale('en'),
                      );
                    },
                    activeColor: Colors.orange,
                  ),
                  Text('TH',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ],
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(SizeConfig.height(1)),
          child: ListView(
            children: [
              // user card
              BigUserCard(
                backgroundColor: Colors.orange,
                userName: "Sun Mei",
                userMoreInfo: const Text(
                  "sunmei_987@gmail.com",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "ThaiFont",
                  ),
                ),
                userProfilePic: const AssetImage("assets/profilpic.jpg"),
                cardActionWidget: SettingsItem(
                  icons: Icons.nordic_walking_rounded,
                  title: 'The Adventure',
                ),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AppearancePage()));
                    },
                    icons: CupertinoIcons.pencil_outline,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.blue,
                    ),
                    title: AppLocalizations.of(context)!.appearance,
                    titleMaxLine: 1,
                    subtitleMaxLine: 1,
                    titleStyle: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.height(2.2),
                    ),
                  ),
                  SettingsItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyPage()));
                    },
                    icons: Icons.fingerprint,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: AppLocalizations.of(context)!.privacy,
                    subtitleMaxLine: 1,
                    titleStyle: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.height(2.2),
                    ),
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.blue[900]!,
                    ),
                    title: AppLocalizations.of(context)!.darkMode,
                    titleStyle: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.height(2.2),
                    ),
                    trailing: Switch.adaptive(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: AppLocalizations.of(context)!.about,
                    subtitle: AppLocalizations.of(context)!.des_about,
                    titleStyle: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.height(2.2),
                    ),
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                settingsGroupTitleStyle: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: SizeConfig.height(2.2),
                  fontWeight: FontWeight.bold,
                ),
                settingsGroupTitle: AppLocalizations.of(context)!.account,
                items: [
                  SettingsItem(
                    onTap: () => _showSignOutConfirmationDialog(context),
                    icons: Icons.exit_to_app_rounded,
                    title: AppLocalizations.of(context)!.signOut,
                    titleStyle: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.height(2.2),
                    ),
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: CupertinoIcons.delete_solid,
                    title: AppLocalizations.of(context)!.deleteAccount,
                    titleStyle: TextStyle(
                      color: Colors.red,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.height(2.2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sign Out'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  SlideRoute(page: const LoginSignUpPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
