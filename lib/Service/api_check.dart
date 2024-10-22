import 'package:get/get.dart';
import 'package:populer_mems/Core/AppRoute/app_route.dart';

import 'package:populer_mems/Helper/shared_prefe/shared_prefe.dart';
import 'package:populer_mems/Utils/AppConst/app_const.dart';
import 'package:populer_mems/Utils/ToastMsg/toast_message.dart';


class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if (response.statusCode == 401) {
      await SharePrefsHelper.remove(AppConstants.bearerToken);
      //Get.offAllNamed(AppRoute.signInScreen);
    } else {
      showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
    }
  }
}
