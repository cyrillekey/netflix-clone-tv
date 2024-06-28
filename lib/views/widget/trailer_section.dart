import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:netflix/models/item_model.dart';
import 'package:remixicon/remixicon.dart';

class TrailerSection extends StatelessWidget {
  const TrailerSection({super.key, required this.data, required this.play});
  final ItemModel data;
  final Function(String) play;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 0,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                imageUrl: 'https://img.youtube.com/vi/112/mqdefault.jpg',
                placeholder: (context, url) => Image.asset(
                  'assets/images/placeholder.png',
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => play('https://www.youtube.com/embed/112'),
                  child: Container(
                      color: Colors.black.withOpacity(0.7),
                      child: const Center(
                          child: Icon(Remix.play_circle_line, size: 50))),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(data.title ?? ""),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
