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
            child: const Text(
              'Snap Shop',
              textAlign: TextAlign.center,
              style: Styles.titleText30,
            ),
          ),
        );
      },
    );
  }
}
