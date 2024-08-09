import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constant/constant.dart'; // Adjust the import path as needed

class PlaceSlide extends StatefulWidget {
  const PlaceSlide({super.key});

  @override
  _PlaceSlideState createState() => _PlaceSlideState();
}

class _PlaceSlideState extends State<PlaceSlide> {
  Stream? slides;

  Stream? _queryPlace() {
    slides = FirebaseFirestore.instance
        .collection('places')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return null;
  }

  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    _queryPlace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.rec_place,
            style: TextStyle(
              fontSize: SizeConfig.height(2.5),
              fontWeight: FontWeight.w600,
              fontFamily: "ThaiFont",
              letterSpacing: 0,
            ),
          ),
        ),
        body: StreamBuilder(
            stream: slides,
            builder: (context, AsyncSnapshot snap) {
              if (snap.hasError) {
                return Center(child: Text("Error: ${snap.error}"));
              } else if (snap.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                final slideList = snap.data.toList();
                return CarouselSlider.builder(
                  carouselController: _controller,
                  itemCount: slideList.length,
                  itemBuilder: (context, index, realIndex) {
                    return buildCarouselItem(slideList[index], context);
                  },
                  options: CarouselOptions(
                    initialPage: 0,
                    enlargeCenterPage: false,
                    height: SizeConfig.height(20),
                    autoPlay: false,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 0.8,
                  ),
                );
              }
            }));
  }
}

buildCarouselItem(Map data, BuildContext context) {
  final locale = Localizations.localeOf(context);
  return Container(
    margin: EdgeInsets.all(SizeConfig.height(1)),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Stack(
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          FastCachedImage(
            url: data['url'],
            fit: BoxFit.cover,
            width: double.infinity,
            fadeInDuration: Duration(milliseconds: 300),
            errorBuilder: (context, error, stackTrace) =>
                Center(child: Icon(Icons.error)),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.height(1.5),
                  horizontal: SizeConfig.height(2)),
              child: Text(
                locale.languageCode == 'th' ? data['name_th'] : data['name'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.height(1.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
