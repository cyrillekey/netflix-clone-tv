import 'dart:io';

import 'package:flutter/material.dart';
import 'package:netflix/controllers/services/api_services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile({
    super.key,
    required this.index,
    required this.title,
    required this.episodeId,
    required this.mediaId,
  });
  final int index;
  final String title;
  final String episodeId;
  final String mediaId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiServices().getSources(episodeId, mediaId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF14303B).withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFA3A3B0).withOpacity(0.5),
                  width: 0.75,
                ),
              ),
              child: Column(children: [
                Container(
                  height: 100,
                  width: 220,
                  alignment: Alignment.bottomRight,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/placeholder.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 10,
                              color: Colors.black,
                            ),
                          ]),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8, top: 4),
                  width: 200,
                  child: Text(title,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                ),
              ]),
            );
          }
          return Container(
              margin: const EdgeInsets.all(10),
              height: 100,
              width: 220,
              decoration: BoxDecoration(
                color: const Color(0xFF14303B).withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFA3A3B0).withOpacity(0.5),
                  width: 0.75,
                ),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: Column(children: [
                  FutureBuilder(
                      future: getVideoThumnail(
                          snapshot.data?.sources?.lastOrNull?.url),
                      builder: (context, imageSnapshot) {
                        print("Data here${imageSnapshot.data}");
                        return Container(
                          height: 100,
                          width: 220,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            image: imageSnapshot.hasData == false
                                ? const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/placeholder.png"),
                                    fit: BoxFit.cover)
                                : imageSnapshot.data != null
                                    ? DecorationImage(
                                        image: FileImage(
                                            File(imageSnapshot.data!)),
                                        fit: BoxFit.cover)
                                    : const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/placeholder.png"),
                                        fit: BoxFit.cover),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 10,
                                      color: Colors.black,
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      }),
                  Container(
                    margin: const EdgeInsets.only(left: 8, top: 4),
                    width: 200,
                    child: Text(title,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ]),
              ));
        });
  }

  Future<String?> getVideoThumnail(videoUrl) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );
    return fileName;
  }
}
