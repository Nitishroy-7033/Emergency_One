import 'package:emergency_one/core/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/splace_controller.dart';

class SplaceView extends StatelessWidget {
  const SplaceView({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController controller = Get.put(SplaceController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD74340),
              Color(0xFFFF8381),
            ],
          ),
        ),
        child: Center(
          child: Lottie.asset(
            AnimationAssets.splaceAnimation,
            width: 350,
            height: 350,
          ),
        ),
      ),
    );
  }
}
