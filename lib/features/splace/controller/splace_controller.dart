import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';

class SplaceController extends GetxController {


  @override
  void onInit() {
    handleSplashLogic();
    super.onInit();
  }


  Future<void> handleSplashLogic() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(authView);
  }
}
