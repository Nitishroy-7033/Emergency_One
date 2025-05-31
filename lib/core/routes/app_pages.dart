import 'package:emergency_one/features/auth/view/login_view.dart';
import 'package:emergency_one/features/auth/view/register_view.dart';
import 'package:get/get.dart';

import '../../features/splace/view/splace_view.dart';
import 'app_routes.dart';

var pageRoutes = [
  GetPage(
      name: splaceView,
      page: () => SplaceView(),
  ),
  
  GetPage(
      name: loginView,
      page: () => LoginView(),
  ),
  GetPage(
      name: registerView,
      page: () => RegisterView(),
  ),

];