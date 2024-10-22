import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:populer_mems/Helper/network_img/network_img.dart';
import 'package:populer_mems/View/Screens/HomeScreen/Controller/home_controller.dart';
import 'package:populer_mems/View/Widgegts/custom_text/custom_text.dart';

import '../../../utils/AppColors/app_colors.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
HomeController controller=Get.find<HomeController>();
  var index=Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:CustomText(text:"Details",fontSize: 16,fontWeight: FontWeight.bold,),),

      body: Obx(()=>Column(
          children: [
          Center(
            child: GestureDetector(
              onTap: ()async{
                await controller.cropImage(controller.allMemes.value.data?.memes?[index].url??"");
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
                  borderRadius: BorderRadius.circular(8.r),
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
            ),
          )
    ],
    )),
    );
  }
}
