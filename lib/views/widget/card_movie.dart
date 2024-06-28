import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:netflix/constant.dart';
import 'package:netflix/models/item_model.dart';

class CardMovie extends StatelessWidget {
  const CardMovie({super.key, required this.movie, this.noMargin});
  final bool? noMargin;
  final ItemModel movie;

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(builder: (context) {
        bool hasFocus = Focus.of(context).hasFocus;
        return GestureDetector(
          onTap: () => Get.toNamed('/detail', arguments: movie),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: hasFocus
                    ? Border.all(
                        color: Colors.white,
                        width: 2,
                      )
                    : Border.all()),
            margin: EdgeInsets.only(right: noMargin != null ? 0 : 10),
            padding: const EdgeInsets.all(5),
            child: CachedNetworkImage(
              imageUrl: "${movie.image}",
              width: hasFocus ? 140 : 120,
              placeholder: (_, url) => AspectRatio(
                aspectRatio: 0.71,
                child: Container(
                  width: hasFocus ? 140 : 120,
                  color: bgColor,
                ),
              ),
              errorWidget: (context, url, error) => Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/placeholder.png',
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
