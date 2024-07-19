import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:netflix/constant.dart';
import 'package:netflix/controllers/detail_controller.dart';
import 'package:netflix/models/item_model.dart';
import 'package:netflix/views/widget/cicular_button.dart';
import 'package:netflix/views/widget/episode_tile.dart';

import 'package:netflix/views/widget/text_container.dart';
import 'package:remixicon/remixicon.dart';

class ShowScreen extends StatefulWidget {
  const ShowScreen({super.key});

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  final DetailController _c = Get.put(DetailController());
  int selectedSeason = 1;
  @override
  void initState() {
    super.initState();
    setState(() {
      Future.microtask(
        () {
          _c.getMovieDetails(data);
        },
      );
    });
  }

  final String data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    if (_c.episodeDataStatus.isLoading) {
      Center(child: CircularProgressIndicator(color: primaryColor));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(_c.item?.cover ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: Get.width,
                height: Get.height * 0.40 > 300 ? Get.height * 0.40 : 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        const Color(0xFF111015).withOpacity(0.50),
                        const Color(0xFF111015).withOpacity(0.75),
                        const Color(0xFF111015).withOpacity(0.85),
                        const Color(0xFF111015).withOpacity(0.90),
                        const Color(0xFF111015).withOpacity(0.95),
                        const Color(0xFF111015).withOpacity(1.00)
                      ]),
                ),
              ),
              Container(
                width: Get.width,
                height: Get.height * 0.50,
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _c.item?.title ?? "N/A",
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rate_rounded,
                          color: Colors.amber,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${_c.item?.rating}/10",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 10,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(_c.item?.production ?? "",
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 10,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(_c.item?.releaseDate ?? "",
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 10,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          (_c.item?.genres ?? []).join(","),
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(Colors.white)),
                          label: const Text(
                            "Watch Now",
                            style: TextStyle(color: Colors.black),
                          ),
                          icon: const Icon(
                            Remix.play_fill,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Remix.add_fill),
                          label: const Text("My wishlist"),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Remix.share_2_fill))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 36,
            width: Get.width,
            margin: const EdgeInsets.only(left: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _c.item?.genres?.length,
              itemBuilder: (context, index) {
                return TextContainer((_c.item?.genres?[index] ?? "").toString(),
                    const EdgeInsets.only(right: 8), const Color(0xFF14303B));
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText("Status"),
              Row(
                children: [
                  TextContainer(
                      "Ongoing",
                      const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      const Color(0xFF382E39)),
                  TextContainer(
                      "Release: ${_c.item?.releaseDate}",
                      const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      const Color(0xFF545551)),
                ],
              ),
              TitleText("Overview"),
              TextContainer(
                  _c.item?.description == null
                      ? "No overview available"
                      : _c.item!.description.toString(),
                  const EdgeInsets.all(8),
                  const Color(0xFF0F1D39)),
              TitleText("Seasons"),
              Container(
                height: 36,
                width: Get.width,
                margin: const EdgeInsets.only(left: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _c.item?.seasons?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          selectedSeason = index + 1;
                        });
                      },
                      child: TextContainer(
                          "Season ${_c.item!.seasons![index]}",
                          const EdgeInsets.only(right: 8),
                          index + 1 == selectedSeason
                              ? const Color(0xFF545551)
                              : const Color(0xFF14303B)),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Episode episode = (_c.item?.episodes
                            ?.where(
                                (element) => element.season == selectedSeason)
                            .toList() ??
                        [])[index];
                    return EpisodeTile(
                        index: episode.episode ?? index,
                        mediaId: _c.item!.id!,
                        episodeId: episode.id!,
                        title: episode.title ?? "N/A");
                  },
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _c.item?.episodes
                      ?.where((element) => element.season == selectedSeason)
                      .length,
                ),
              ),
              TitleText("Recommendations"),
              // CustomListTV(recommendedTvShows),
            ],
          )
        ],
      ),
    );
  }
}
