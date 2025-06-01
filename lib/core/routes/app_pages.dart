import 'package:emergency_one/features/auth/view/login_view.dart';
import 'package:emergency_one/features/auth/view/profile_setup_view.dart';
import 'package:emergency_one/features/auth/view/register_view.dart';
import 'package:emergency_one/features/call_ambulance/view/ambulance_view.dart';
import 'package:emergency_one/features/home/view/home_view.dart';
import 'package:emergency_one/features/service_request/view/service_request_view.dart';
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
  GetPage(
      name: profileSetupView,
      page: () => ProfileSetupView(),
  ),
  GetPage(
      name: homeView,
      page: () => HomeView(),
  ),
  GetPage(
      name: ambulanceView,
      page: () => AmbulanceView(),
  ),
  GetPage(
      name: serviceRequestView,
      page: () => ServiceRequestView(),
  ),

];