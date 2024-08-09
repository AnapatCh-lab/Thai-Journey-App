import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thaijourney/firebase_storage_service.dart';

import '../page/home/home.dart';
import '../page/login_signup/login_signup.dart';
import 'transition_route.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatorHome();
  }

  Future<void> _navigatorHome() async {
    await Future.delayed(
        const Duration(milliseconds: 1500)); // Delay for splash screen
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Navigate to FirstUse screen if not logged in
      Navigator.pushReplacement(
        context,
        SlideRoute(page: const FirstUse()),
      );
    } else {
      // Navigate to MyHome screen if logged in
      Navigator.pushReplacement(
        context,
        SlideRoute(page: const MyHome()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Display a splash screen while waiting
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class FirstUse extends StatefulWidget {
  const FirstUse({super.key});

  @override
  _FirstUseState createState() => _FirstUseState();
}

class _FirstUseState extends State<FirstUse> {
  late Future<List<String>> _imageUrls;

  @override
  void initState() {
    super.initState();
    // Update to handle both single and multiple images
    _imageUrls = FirebaseStorageService().getImageUrls([
      'firstuse/travel.png',
      'firstuse/checkin.png',
      'firstuse/landmark.png',
    ]);
  }

  final PageController _slideControl = PageController();
  final List<String> _descriptions = [
    'Convenience in traveling within Thailand.',
    'Check in to different locations for your friends to know and share online.',
    'Many Landmark Within Thailand that you may not yet know exists.',
  ];

  void _nextImage() {
    if (_slideControl.page?.toInt() == _descriptions.length - 1) {
      Navigator.of(context)
          .pushReplacement(SlideRoute(page: const LoginSignUpPage()));
    } else {
      _slideControl.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
      ),
      body: Container(
        color: Colors.orange[700],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<String>>(
                future: _imageUrls,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: const Text("Error loading Images"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: const Text("No images available"));
                  } else {
                    List<String> imageUrls = snapshot.data!;
                    return PageView.builder(
                      controller: _slideControl,
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: imageUrls[index],
                              height: height * 0.4,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: height * 0.05),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.1),
                              child: Text(
                                _descriptions[index],
                                style: TextStyle(
                                  fontSize: height * 0.03,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _slideControl,
              count: _descriptions.length,
              effect: WormEffect(
                dotHeight: height * 0.015,
                dotWidth: height * 0.015,
                activeDotColor: Colors.white,
              ),
            ),
            SizedBox(height: height * 0.05),
            SizedBox(
              width: width * 0.8,
              height: height * 0.07,
              child: ElevatedButton(
                onPressed: _nextImage,
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: height * 0.025),
                ),
              ),
            ),
            SizedBox(height: height * 0.1),
          ],
        ),
      ),
    );
  }
}
