// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaijourney/constant/constant.dart';
import 'package:thaijourney/constant/themeprovider.dart';

class PlaceWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String description;
  final double rating;

  const PlaceWidget({super.key, 
    required this.imagePath,
    required this.name,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.height(1)),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850]! : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: isDarkMode ? Colors.white : Colors.grey),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: Offset(0, 3),
        //   ),
        // ],
      ),
      padding: EdgeInsets.all(SizeConfig.height(1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: SizeConfig.height(12),
              height: SizeConfig.height(12),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: SizeConfig.height(2)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: SizeConfig.height(2.5),
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Ensure text doesn't overflow
                        maxLines: 2, // Limit to one line for the name
                      ),
                    ),
                    SizedBox(
                        width: SizeConfig.height(
                            1)), // Adjust spacing between name and rating
                    Icon(
                      Icons.star,
                      color: Colors.yellow[700]!,
                      size: SizeConfig.height(3),
                    ),
                    SizedBox(width: SizeConfig.height(.5)), // Adjust spacing
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        fontSize: SizeConfig.height(2.5),
                        color: isDarkMode ? Colors.white : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: SizeConfig.height(2),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
