import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:populer_mems/Service/api_check.dart';
import 'package:populer_mems/Service/api_client.dart';
import 'package:populer_mems/Service/api_url.dart';
import 'package:populer_mems/Utils/AppConst/app_const.dart';
import 'package:populer_mems/View/Screens/HomeScreen/Model/memes_model.dart';

class HomeController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  TextEditingController searchController = TextEditingController();
  bool memesLoading = false;
  Rx<AllMemsModel> allMemes = AllMemsModel().obs;

  Future<void> getAllMemes() async {
    setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(ApiConstant.allMemes);

    if (response.statusCode == 200) {
      allMemes.value = AllMemsModel.fromJson(response.body);
      setRxRequestStatus(Status.completed);
    } else {
      handleError(response);
      setRxRequestStatus(Status.completed);
    }
  }

  void handleError(var response) {
    if (response.statusText == ApiClient.noInternetMessage) {
      setRxRequestStatus(Status.internetError);
    } else {
      setRxRequestStatus(Status.error);
    }
    ApiChecker.checkApi(response);
  }

  /// Downloads an image from a URL and returns the local file path
  Future<String?> downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/temp_image.jpg'; // Change as needed
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      } else {
        print("Failed to download image");
        return null;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return null;
    }
  }

  /// Crops an image and saves it to the gallery
  Future<void> cropImage(String imageUrl) async {
    // Download the image first
    String? imagePath = await downloadImage(imageUrl);
    if (imagePath == null) {
      Get.snackbar("Error", "Failed to download image.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Proceed to crop the image
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio3x2,
      ],
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      maxWidth: 512,
      maxHeight: 512,
      cropStyle: CropStyle.rectangle,
    );

    if (croppedFile != null) {
      // Request storage permission before saving
      if (await requestStoragePermission()) {
        final result = await ImageGallerySaver.saveFile(croppedFile.path);
        if (result['isSuccess']) {
          Get.snackbar("Success", "Image saved to gallery!",
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar("Error", "Failed to save image.",
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar("Permission Denied", "Storage permission is required to save images.",
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("Warning", "Image cropping canceled or failed.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }

  @override
  void onInit() {
    getAllMemes();
    super.onInit();
  }
}
