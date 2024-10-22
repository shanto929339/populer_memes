import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:populer_mems/Core/AppRoute/app_route.dart';
import 'package:populer_mems/View/Widgegts/custom_loader/custom_loader.dart';

import '../../../Utils/AppColors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){

      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(AppRoute.homeScreen);
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black500,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: AppColors.black600,
        ),
        child: Center(
         child: CustomLoader(),
      ),
      )
    );
  }
}
