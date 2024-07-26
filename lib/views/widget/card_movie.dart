import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:netflix/models/item_model.dart';

class CardMovie extends StatelessWidget {
  const CardMovie({super.key, required this.movie, this.noMargin});
  final bool? noMargin;
  final ItemModel movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => movie.type == "TV Series"
          ? Get.toNamed("/tshow", arguments: movie.id)
          : Get.toNamed('/detail', arguments: movie.id),
      child: Focus(
        child: Builder(builder: (context) {
          bool hasFocus = Focus.of(context).hasFocus;
          return Container(
            width: hasFocus ? Get.width * 0.35 : Get.width * 0.18,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      "${movie.image}",
                    ),
                    fit: hasFocus ? BoxFit.fitWidth : BoxFit.contain),
                border: hasFocus
                    ? Border.all(
                        color: Colors.white,
                        width: 2,
                      )
                    : Border.all()),
            margin: EdgeInsets.only(right: noMargin != null ? 0 : 10),
            padding: const EdgeInsets.all(5),
            child: hasFocus
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            movie.title ?? "N/A",
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  )
                : const SizedBox.shrink(),
          );
        }),
      ),
    );
  }
}
