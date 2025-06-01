import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';

class SplaceController extends GetxController {
  var auth = FirebaseAuth.instance;

  @override
  void onInit() {
    handleSplashLogic();
    super.onInit();
  }

  Future<void> handleSplashLogic() async {
    await Future.delayed(Duration(seconds: 3));
    if (auth.currentUser != null) {
      Get.offNamed(homeView);
    } else {
      Get.offNamed(loginView);
    }
  }
}
