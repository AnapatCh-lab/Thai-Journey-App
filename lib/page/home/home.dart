import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thaijourney/constant/constant.dart';
import 'package:thaijourney/constant/themeprovider.dart';
import 'package:thaijourney/page/home/sub_page/hotel.dart';
import 'package:thaijourney/util/bottom_bar.dart';
import 'package:thaijourney/firebase_storage_service.dart';
import 'package:thaijourney/util/transition_route.dart';
import '../account/account.dart';
import '../map/map.dart';
import '../home/sub_page/event.dart';
import '../home/sub_page/place.dart';
import '../home/home_widget/recommend_food.dart';
import '../home/home_widget/recommend_place.dart';
import '../suggest/suggest.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(),
    const SuggestPage(),
    MapPage(),
    const AccountPage(),
    // Add MapPage to the list of widget options
  ];

  void onTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: IndexedStack(
        index: selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late Future<List<String>> _imageUrls;

  @override
  void initState() {
    super.initState();
    // Update to handle both single and multiple images
    _imageUrls = FirebaseStorageService().getImageUrls([
      'banners/slide1.png',
      'banners/slide2.png',
      'banners/slide3.jpg',
      // or handle the case where you might have only one image
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;

    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List<String>>(
            future: _imageUrls,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: SizeConfig.height(23),
                  width: double.infinity,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('Error loading images');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No images available');
              } else {
                List<ImageProvider> imageProviders = snapshot.data!
                    .map((url) => FastCachedImageProvider(url))
                    .toList();
                return SizedBox(
                  height: SizeConfig.height(23),
                  width: double.infinity,
                  child: AnotherCarousel(
                    images: imageProviders,
                    dotSize: 6,
                    dotColor: Colors.orange,
                    dotBgColor: Colors.white.withOpacity(0),
                    indicatorBgPadding: 5.0,
                    noRadiusForIndicator: true,
                    animationDuration: const Duration(milliseconds: 2000),
                    boxFit: BoxFit.fitWidth,
                  ),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.width(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRoute(
                          page: PlacePage(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(SizeConfig.height(1)),
                          decoration: isDarkMode
                              ? DropShadow.boxDecoration_dark
                              : DropShadow.boxDecoration,
                          child: Icon(
                            Icons.where_to_vote_rounded,
                            size: SizeConfig.height(5),
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.height(1),
                        ),
                        Text(
                          AppLocalizations.of(context)!.place,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: SizeConfig.height(2),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRoute(
                          page: PlacePage(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(SizeConfig.height(1)),
                          decoration: isDarkMode
                              ? DropShadow.boxDecoration_dark
                              : DropShadow.boxDecoration,
                          child: Icon(
                            Icons.bed,
                            size: SizeConfig.height(5),
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.height(1),
                        ),
                        Text(
                          AppLocalizations.of(context)!.hotel,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: SizeConfig.height(2),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRoute(
                          page: HotelPage(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(SizeConfig.height(1)),
                          decoration: isDarkMode
                              ? DropShadow.boxDecoration_dark
                              : DropShadow.boxDecoration,
                          child: Icon(
                            Icons.food_bank_rounded,
                            size: SizeConfig.height(5),
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.height(1),
                        ),
                        Text(
                          AppLocalizations.of(context)!.food,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: SizeConfig.height(2),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRoute(
                          page: const EventPage(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(SizeConfig.height(1)),
                          decoration: isDarkMode
                              ? DropShadow.boxDecoration_dark
                              : DropShadow.boxDecoration,
                          child: Icon(
                            Icons.event_available,
                            size: SizeConfig.height(5),
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.height(1),
                        ),
                        Text(
                          AppLocalizations.of(context)!.event,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: SizeConfig.height(2),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.height(30), // Adjust the height as needed
            child: PlaceSlide(),
          ),
          SizedBox(
            height: SizeConfig.height(30), // Adjust the height as needed
            child: FoodSlide(),
          ),
        ],
      ),
    );
  }
}

AppBar appBar() {
  // Logo Header
  return AppBar(
    title: const Text(
      'THAI JOURNEY',
      style: TextStyle(
        color: Colors.orange,
        fontSize: 32,
        fontFamily: 'CaviarDreams',
        fontWeight: FontWeight.normal,
      ),
    ),
    centerTitle: true,
    elevation: 0,
    toolbarHeight: SizeConfig.height(8),
  );
}
