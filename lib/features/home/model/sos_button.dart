import 'package:flutter/material.dart';

class SosButton extends StatefulWidget {
  final VoidCallback onPressed;
  const SosButton({super.key, required this.onPressed});

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> rippleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    rippleAnimation = Tween<double>(begin: 80, end: 160).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: rippleAnimation,
            builder: (context, child) {
              return Container(
                width: rippleAnimation.value,
                height: rippleAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(
                      1 - (rippleAnimation.value - 80) / 80), // fades out
                ),
              );
            },
          ),
          // Middle pulse
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.withOpacity(0.2),
            ),
          ),
          // Inner red button
          GestureDetector(
            onTap: widget.onPressed,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.redAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: const Icon(
                Icons.touch_app,
                size: 42,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
