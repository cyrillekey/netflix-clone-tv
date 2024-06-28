import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:netflix/models/item_model.dart';

class MediaSection extends StatelessWidget {
  const MediaSection({super.key, required this.data});
  final ItemModel data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        GridView.count(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
          children: List.generate(
              1, (index) => CachedNetworkImage(imageUrl: "${data.cover}")),
        ),
      ],
    );
  }
}
