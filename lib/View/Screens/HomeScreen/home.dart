import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:populer_mems/Core/AppRoute/app_route.dart';
import 'package:populer_mems/Helper/GenerelError/general_error.dart';
import 'package:populer_mems/Helper/network_img/network_img.dart';
import 'package:populer_mems/Utils/AppConst/app_const.dart';
import 'package:populer_mems/Utils/StaticString/static_string.dart';
import 'package:populer_mems/View/Screens/HomeScreen/Controller/home_controller.dart';
import 'package:populer_mems/View/Widgegts/CustomCart/custom_cards.dart';
import 'package:populer_mems/View/Widgegts/custom_loader/custom_loader.dart';
import 'package:populer_mems/View/Widgegts/custom_text/custom_text.dart';
import 'package:populer_mems/View/Widgegts/custom_text_field/custom_text_field.dart';

import '../../../utils/AppColors/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white300,

      /// AppBar  Design

      appBar: AppBar(
        backgroundColor: AppColors.white50,
        title: const CustomText(
          text: AppString.home,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),

      /// Main content .I mean body

      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return const CustomLoader();
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.allMemes();
              },
            );
          case Status.completed:
            return SingleChildScrollView(
        child: Column(
        children: [
        SizedBox(
        height: 8.h,
        ),
        CustomCards(
        children: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ///  This is the search field . Here you can search your memes.

        CustomTextField(
        textEditingController: controller.searchController,
        ),

        CustomText(
        text: AppString.allMemes,
        top: 24.h,
        fontSize: 16,
        bottom: 24.h,
        ),

        Column(
        children: List.generate(controller.allMemes.value.data?.memes?.length??0, (index) {
        ///  Memes card .Here is the show individual meme
        return GestureDetector(
          onTap: (){
          Get.toNamed(AppRoute.details,arguments: index);
          },
          child: Container(
          margin:
          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          padding:
          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          height: 150.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),  // Shadow color with opacity
                spreadRadius: 5,  // How wide the shadow is
                blurRadius: 7,    // How soft the shadow looks
                offset: Offset(0, 3),  // Shadow position (horizontal, vertical)
              ),
            ],
          color: AppColors.white50,

          borderRadius: BorderRadius.circular(9.r),
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          ///  This is the image . Here you can see memes image
          children: [
          CustomNetworkImage(
          imageUrl:
          controller.allMemes.value.data?.memes?[index].url??"",
          height: 100.h,
          width: double.maxFinite,
          borderRadius: BorderRadius.circular(8.r),
          ),

          CustomText(text:controller.allMemes.value.data?.memes?[index].name??"",top: 8.h,fontSize: 14,),
          ],
          ),
          ),
        );
        }),
        ),
        ],
        )),
        ],
        ),
        );
        }
      }),




    );
  }
}
