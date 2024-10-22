
import 'package:get/get.dart';
import 'package:populer_mems/View/Screens/HomeScreen/Controller/home_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {

    ///================ Auth Controller =================

    Get.lazyPut(() => HomeController(), fenix: true);

  }
}
