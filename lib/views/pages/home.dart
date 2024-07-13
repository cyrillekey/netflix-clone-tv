import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:netflix/controllers/home_controller.dart';

import 'package:netflix/views/widget/section_home.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.openGenre});
  final Function() openGenre;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _c = Get.put(HomeController());
  double _scrollOffset = 0;
  int page = 1;
  final _scrollController = ScrollController();
  final _scrollControllerGenre = ScrollController();

  @override
  void initState() {
    super.initState();
    _c.getData();
    _scrollController.addListener(_onScroll);
    _scrollControllerGenre.addListener(_onScrollGenre);
  }

  void _onScroll() {
    setState(() {
      if (_scrollController.offset <= 140) {
        _scrollOffset = _scrollController.offset;
      } else {
        _scrollOffset = 140;
      }
    });
  }

  void _onScrollGenre() {
    setState(() {
      if (_scrollControllerGenre.offset <= 140) {
        _scrollOffset = _scrollControllerGenre.offset;
      } else {
        _scrollOffset = 140;
      }
    });

    if (_scrollControllerGenre.position.atEdge &&
        _scrollControllerGenre.offset != 0) {
      setState(() {
        page++;
      });

      _c.getCategory(page);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerGenre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_c.category == null && _c.status.isLoading && _c.movies.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : Builder(
              builder: (context) {
                if (_c.status.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ListView(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(0),
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SectionHome(data: _c.trending, title: 'Trending'),
                            SectionHome(
                                data: _c.latestMovies, title: 'Latest Movies'),
                            SectionHome(
                                data: _c.latestShows, title: 'Latest Series'),
                            SectionHome(
                                data: _c.popularAnime, title: 'Popular Anime'),
                            SectionHome(
                                data: _c.latestAnime, title: 'Anime Movies'),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
    );
  }
}
