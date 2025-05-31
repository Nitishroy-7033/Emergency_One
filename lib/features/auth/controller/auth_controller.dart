import 'package:emergency_one/features/auth/model/user_mode.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  Rx<UserModel> userDetails = UserModel().obs;

  void setUserDetails(UserModel user) {
    userDetails.value = user;
  }

  

}