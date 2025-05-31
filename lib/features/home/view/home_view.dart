import 'package:emergency_one/core/components/circle_button.dart';
import 'package:emergency_one/core/constants/app_const.dart';
import 'package:emergency_one/core/constants/assets_path.dart';
import 'package:emergency_one/features/home/model/category_card.dart';
import 'package:emergency_one/features/home/model/sos_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool emergencyEnabled = false.obs;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Nitish Kumar",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        leading: Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.person),
        ),
        actions: [CircleButton(icon: Icons.notifications), SizedBox(width: 10)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(PAGE_PADDING),
        child: Column(
          children: [
            Container(
              // height: 300,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Emergency",
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        SosButton(
                          onPressed: () {
                            emergencyEnabled.value = true;
                          },
                        ),
                        Obx(
                          () =>
                              emergencyEnabled.value
                                  ? LinearProgressIndicator()
                                  : SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () =>
                  emergencyEnabled.value
                      ? ElevatedButton(
                        onPressed: () {
                          emergencyEnabled.value = false;
                        },
                        child: Text("Cancel SOS"),
                      )
                      : SizedBox.shrink(),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("OTHERS", style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryCard(
                  iconPath: IconAssets.ambulance,
                  title: "Ambulance",
                ),
                CategoryCard(
                  iconPath: IconAssets.hospital,
                  title: "Hospital",
                ),
                CategoryCard(
                  iconPath: IconAssets.blood,
                  title: "Blood",
                ),
                CategoryCard(
                  iconPath: IconAssets.fire,
                  title: "Desater",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
