
import 'package:get/get.dart';
import 'package:populer_mems/View/Screens/DetailsScreen/details.dart';
import 'package:populer_mems/View/Screens/HomeScreen/home.dart';
import 'package:populer_mems/View/Screens/SplashScreen/splash.dart';

class AppRoute {
  ///==================== Initial Routes ====================
  static const String splashScreen = "/splash_screen";
  static const String homeScreen = "/homeScreen";
  static const String details = "/details";


  static List<GetPage> routes = [
    ///==================== Initial Routes ====================

    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: details, page: () =>  DetailsScreen()),
    GetPage(name: homeScreen, page: () =>  HomeScreen()),



  ];
}
