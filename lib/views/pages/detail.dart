import 'dart:ui';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:netflix/constant.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:netflix/controllers/detail_controller.dart';

import 'package:netflix/views/widget/episode_section.dart';
import 'package:netflix/views/widget/media_section.dart';

import 'package:netflix/views/widget/movie_info.dart';
import 'package:netflix/views/widget/movie_summary.dart';
import 'package:netflix/views/widget/trailer_section.dart';
import 'package:remixicon/remixicon.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final DetailController _c = Get.put(DetailController());
  final String data = Get.arguments;
  String? _url;
  InAppWebViewController? _webViewController;
  String? iframe;
  int season = 1;
  String? selectedPath;
  String selectedTile = 'english';
  bool subpathLoading = false;
  bool movieLoading = false;

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

  void _closePlayer() => setState(() => _url = null);

  void _play(String url, {String? subtitle}) {
    setState(() => _url = url);

    if (subtitle != null) {
      _webViewController!.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
    } else {
      _webViewController!.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
    }
  }

  void _playMovie({int? episode}) async {
    // TODO IMPLEMENT PLAY MOVIE
    // setState(() => movieLoading = true);
    // PlayerArgument argument;
    // List<SourceModel>? response;

    // if (data.numberOfSeasons != null) {
    //   response = await _apiServices.getSources(
    //     imdb: data.externalIds?.imdbId,
    //     season: season,
    //     episode: episode,
    //   );
    // } else {
    //   // IMPLEMENT GET MOVIE SOURCE
    //   response = await _apiServices.getSources(imdb: data.externalIds?.imdbId);
    // }

    // if (response.isNotEmpty) {
    //   argument = PlayerArgument(
    //       url: response.first.file!, subtitle: _c.subtitleRaw, movie: data);
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.landscapeRight,
    //     DeviceOrientation.landscapeLeft,
    //   ]);
    //   if (mounted) Get.toNamed('/player', arguments: argument);
    // }

    // setState(() => movieLoading = false);
  }

  Future<void> _showSubtitle() {
    return showModalBottomSheet<String>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, sS) {
            return IntrinsicHeight(
              child: Container(
                color: bgColor,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Center(
                        child: Container(
                          width: 72,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Text("Custom Subtitle",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 500,
                      child: ListView(
                        key: ValueKey('builder $selectedTile'),
                        children: [
                          ...(_c.subtitlePathModel?.entries ?? [])
                              .map((itemKeys) {
                            return Theme(
                              data: themeData.copyWith(
                                  dividerColor: Colors.white.withOpacity(0.1)),
                              child: ExpansionTile(
                                textColor: primaryColor,
                                collapsedTextColor: Colors.white,
                                title: Text(itemKeys.key.toUpperCase()),
                                initiallyExpanded:
                                    selectedTile == itemKeys.key.toLowerCase(),
                                onExpansionChanged: (value) {
                                  setState(() {
                                    selectedTile = itemKeys.key.toLowerCase();
                                  });

                                  sS(() {});
                                },
                                children: [
                                  ...(_c.subtitlePathModel?[itemKeys.key] ?? [])
                                      .map((e) {
                                    return Column(
                                      children: [
                                        Divider(
                                            height: 1,
                                            color:
                                                Colors.white.withOpacity(0.1)),
                                        ListTile(
                                          trailing: subpathLoading &&
                                                  selectedPath == e.name
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator())
                                              : (selectedPath == e.name)
                                                  ? Icon(Remix.check_fill,
                                                      color: primaryColor)
                                                  : null,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                          onTap: () async {
                                            sS(() {
                                              subpathLoading = true;
                                              selectedPath = e.name;
                                            });
                                            // TODO IMPLEMENT GET SUBTITLE
                                            // await _c.getSubtitleRawData(
                                            //     data.externalIds?.imdbId ??
                                            //         '',
                                            //     e.path ?? '');
                                            // sS(() => subpathLoading = false);
                                          },
                                          title: Text(e.name ?? ''),
                                        ),
                                      ],
                                    );
                                  })
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(padding: MediaQuery.of(context).viewInsets),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<int?> _showSeason() {
    return showModalBottomSheet<int?>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: Container(
            color: bgColor,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Center(
                    child: Container(
                      width: 72,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("Choose Season",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...(_c.item?.seasons ?? []).map(
                          (e) => Column(
                            children: [
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                onTap: () {
                                  Get.back(result: e);
                                },
                                title: Text("Season $e"),
                              ),
                              Divider(
                                  height: 1,
                                  color: Colors.white.withOpacity(0.1)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(padding: MediaQuery.of(context).viewInsets),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_c.episodeDataStatus.isLoading)
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                title: Text(_c.item?.title ?? ""),
                backgroundColor: Colors.black.withOpacity(0.1),
              ),
              body: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            opacity: 0.3,
                            image: CachedNetworkImageProvider(
                              '${_c.item?.cover}',
                            ),
                          ),
                        ),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const SizedBox(height: 80),
                                  Builder(builder: (context) {
                                    if (_url != null) {
                                      return Stack(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 16 / 10,
                                            child: InAppWebView(
                                              initialSettings:
                                                  InAppWebViewSettings(
                                                      javaScriptEnabled: true,
                                                      supportZoom: true),
                                              initialUrlRequest: URLRequest(
                                                  url: WebUri(_url!)),
                                              onWebViewCreated: (controller) {
                                                _webViewController = controller;
                                              },
                                              onEnterFullscreen: (controller) {
                                                AutoOrientation
                                                    .landscapeAutoMode();
                                              },
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: _closePlayer,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 15, right: 15),
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white
                                                      .withOpacity(0.2),
                                                ),
                                                child: const Center(
                                                  child: Icon(Remix.close_line,
                                                      size: 12),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: MovieSummary(
                                            data: _c.item!,
                                            play: _playMovie,
                                            isLoading: movieLoading),
                                      );
                                    }
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: MovieInfo(data: _c.item!),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_c.item?.numberOfSeasons != null &&
                          _c.item?.type == "TV Series")
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            key: Key("Season $season"),
                            readOnly: true,
                            onTap: () async {
                              int? seasonNumber = await _showSeason();
                              if (seasonNumber != null) {
                                setState(() {
                                  season = seasonNumber;
                                });
                              }
                            },
                            initialValue: 'Season $season',
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.only(left: 15),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              suffixIcon: const Icon(Remix.arrow_down_line),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      DefaultTabController(
                        length: _c.item?.numberOfSeasons != null ? 4 : 2,
                        child: Column(
                          children: [
                            TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: UnderlineTabIndicator(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 2),
                                insets: const EdgeInsets.only(bottom: 45),
                              ),
                              tabs: [
                                if (_c.item?.numberOfSeasons != null)
                                  const Tab(text: 'Episodes'),
                                const Tab(text: 'Trailers & More'),
                                const Tab(text: 'Collections'),
                                const Tab(text: 'Recomendations'),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 300,
                              child: TabBarView(
                                children: [
                                  if (_c.item?.numberOfSeasons != null)
                                    EpisodeSection(
                                        data: _c.item!,
                                        episodes: _c.episode
                                            .where((element) =>
                                                element.season == season)
                                            .toList(),
                                        play: _playMovie),
                                  TrailerSection(data: _c.item!, play: _play),
                                  MediaSection(data: _c.item!),
                                  const SizedBox(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // MovieDetailHeader(
                  //   enableSubtitle: selectedPath != null,
                  //   data: _c.item!,
                  //   onTap: () async {
                  //     await _showSubtitle();
                  //   },
                  // ),
                ],
              ),
            ),
    );
  }
}
