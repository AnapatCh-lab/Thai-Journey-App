import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:thaijourney/constant/themeprovider.dart';
import 'package:thaijourney/firebase_storage_service.dart';
import 'constant/constant.dart';
import 'firebase_options.dart';
import 'page/account/account.dart';
import 'page/home/home.dart';
import 'page/map/map.dart';
import 'util/splash_screen.dart';
import 'page/suggest/suggest.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 90));

  final FirebaseStorageService storageService = FirebaseStorageService();
  final String splashImageUrl =
      await storageService.getImageUrl('others/trip.gif');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(splashImageUrl: splashImageUrl),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String splashImageUrl;

  const MyApp({super.key, required this.splashImageUrl});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme,
      locale: themeProvider.locale,
      supportedLocales: [
        Locale('en'),
        Locale('th'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: AnimatedSplashScreen(
        splash: Image.network(splashImageUrl),
        animationDuration: Duration(milliseconds: 3000),
        nextScreen: const Splash(),
        splashIconSize: SizeConfig.height(30),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),
      routes: {
        '/home': (context) => const MyHome(),
        '/suggest': (context) => const SuggestPage(),
        '/map': (context) => MapPage(),
        '/account': (context) => const AccountPage(),
      },
    );
  }
}
