import 'package:emergency_one/features/auth/view/auth_view.dart.dart';
import 'package:get/get.dart';

import '../../features/splace/view/splace_view.dart';
import 'app_routes.dart';

var pageRoutes = [
  GetPage(
      name: splaceView,
      page: () => SplaceView(),
  ),
  
  GetPage(
      name: authView,
      page: () => AuthView(),
  ),

];