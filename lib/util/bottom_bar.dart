import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:thaijourney/constant/themeprovider.dart';

import '../constant/constant.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomBar({super.key, required this.selectedIndex, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;

    return Container(
      decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GNav(
          haptic: true,
          backgroundColor: isDarkMode ? Colors.grey[850]! : Colors.white,
          tabBackgroundColor: Colors.orange,
          color: isDarkMode ? Colors.white : Colors.black,
          activeColor: Colors.white,
          gap: SizeConfig.height(1),
          iconSize: SizeConfig.height(3.5),
          padding: EdgeInsets.all(SizeConfig.height(1.8)),
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          tabs: [
            GButton(
              icon: Icons.home_filled,
              text: AppLocalizations.of(context)!.home,
            ),
            GButton(
              icon: Icons.card_giftcard,
              text: AppLocalizations.of(context)!.suggest,
            ),
            GButton(
              icon: Icons.map,
              text: AppLocalizations.of(context)!.map,
            ),
            GButton(
              icon: Icons.account_circle,
              text: AppLocalizations.of(context)!.account,
            ),
          ],
        ),
      ),
    );
  }
}
