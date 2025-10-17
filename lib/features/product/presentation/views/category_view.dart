import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/500/200',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/500/200',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/500/200',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/500/200',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
