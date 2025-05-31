import 'package:flutter/material.dart';

class SplaceView extends StatelessWidget {
  const SplaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}