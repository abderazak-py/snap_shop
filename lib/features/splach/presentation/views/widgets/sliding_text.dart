import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/styles.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
    required this.fadeAnimation,
  });

  final Animation<Offset> slidingAnimation;
  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Text(
              'Your Perfect Buy, Just a Snap Away',
              textAlign: TextAlign.center,
              style: Styles.titleText18.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        );
      },
    );
  }
}
