import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/models/item_model.dart';

class EpisodeSection extends StatelessWidget {
  const EpisodeSection(
      {super.key,
      required this.data,
      required this.episodes,
      required this.play});
  final List<Episode> episodes;
  final Function({int? episode}) play;
  final ItemModel data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        Episode episode = episodes[index];
        return GestureDetector(
          onTap: () => play(episode: index + 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://img.flixhq.to/xxrz/250x400/379/e9/e2/e9e299a70d3771d9716c68bb3bcaf746/e9e299a70d3771d9716c68bb3bcaf746.jpg',
                    width: 120,
                    errorWidget: (context, url, error) => Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        'assets/images/placeholder.png',
                        width: 120,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(episode.title!),
                        Text('N/A mins',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.4))),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Text('N/A', maxLines: 2, style: TextStyle(fontSize: 12))
            ],
          ),
        );
      },
    );
  }
}
