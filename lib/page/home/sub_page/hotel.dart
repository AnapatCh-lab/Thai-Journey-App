// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaijourney/constant/constant.dart';
import 'package:thaijourney/constant/themeprovider.dart';
import 'package:thaijourney/page/home/sub_page/value/list_image.dart';
import 'package:thaijourney/page/home/sub_page/value/place_widget.dart';

class HotelPage extends StatelessWidget {
  List<listImage> pictureList = [
    listImage(imagePath: 'imagePath', tag: 'tag'),
  ];

  HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.place,
          style: TextStyle(
            fontSize: SizeConfig.height(3),
            fontWeight: FontWeight.w600,
            fontFamily: "ThaiFont",
          ),
        ),
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: SizeConfig.height(10),
      ),
      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: SizeConfig.height(15),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/รถม้า.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Text(
                  AppLocalizations.of(context)!.pop_place,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.height(3),
                    fontWeight: FontWeight.bold,
                    fontFamily: "ThaiFont",
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0, 5),
                        blurRadius: 10,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.height(1.5)),
              child: ListView(
                children: [
                  PlaceWidget(
                    imagePath: 'assets/photo.png',
                    name: 'Wat Phra That Lampang Luang',
                    description:
                        'Description about the user or profile details.',
                    rating: 4.6,
                  ),
                  PlaceWidget(
                    imagePath: 'assets/photo.png',
                    name: 'Chae Son National Park',
                    description:
                        'Description about the second user or profile details.',
                    rating: 4.8,
                  ),
                  PlaceWidget(
                    imagePath: 'assets/photo.png',
                    name: 'Name',
                    description:
                        'Description about the second user or profile details.',
                    rating: 5,
                  ),
                  PlaceWidget(
                    imagePath: 'assets/photo.png',
                    name: 'Name',
                    description:
                        'Description about the second user or profile details.',
                    rating: 5,
                  ),
                  PlaceWidget(
                    imagePath: 'assets/photo.png',
                    name: 'Name',
                    description:
                        'Description about the second user or profile details.',
                    rating: 5,
                  ),
                  PlaceWidget(
                    imagePath: 'assets/photo.png',
                    name: 'Name',
                    description:
                        'Description about the second user or profile details.',
                    rating: 5,
                  ),
                  PlaceWidget(
                    imagePath: 'assets/photo.png',
                    name: 'Name',
                    description:
                        'Description about the second user or profile details.',
                    rating: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
