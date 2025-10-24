import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BannerLoadingWidget extends StatelessWidget {
  const BannerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final aspectRatio = (9 / 18);
    return Skeletonizer(
      child: Column(
        children: [
          SizedBox(
            height: width * aspectRatio,
            width: width,
            child: PageView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Skeleton.replace(
                        width: width * aspectRatio,
                        height: width,
                        child: SizedBox.expand(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Skeleton.replace(width: 60, height: 10, child: SizedBox.expand()),
        ],
      ),
    );
  }
}
