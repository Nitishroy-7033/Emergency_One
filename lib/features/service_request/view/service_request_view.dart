import 'package:emergency_one/core/components/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_const.dart';

class ServiceRequestView extends StatelessWidget {
  const ServiceRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          PrimaryButton(text: "CANCEL", onPressed: (){}),
          PrimaryButton(text: "REQUEST", onPressed: (){})
        ],),
      ),
      appBar: AppBar(title: const Text('Service Request')),
      body: Padding(
        padding: const EdgeInsets.all(PAGE_PADDING),
        
        child: Column(
          children: [
            Container(
              height: 700,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                  
                ]
              ),
            ),
            SizedBox(height: 20,),  
            Row(
              children: [
                Text("What you want ?", style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
