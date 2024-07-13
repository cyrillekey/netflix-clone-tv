// To parse this JSON data, do
//
//     final sourceModel = sourceModelFromJson(jsonString);

import 'dart:convert';

SourceModel sourceModelFromJson(String str) =>
    SourceModel.fromJson(json.decode(str));

String sourceModelToJson(SourceModel data) => json.encode(data.toJson());

class SourceModel {
  Headers? headers;
  List<Source>? sources;
  List<Subtitle>? subtitles;

  SourceModel({
    this.headers,
    this.sources,
    this.subtitles,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        headers:
            json["headers"] == null ? null : Headers.fromJson(json["headers"]),
        sources: json["sources"] == null
            ? []
            : List<Source>.from(
                json["sources"]!.map((x) => Source.fromJson(x))),
        subtitles: json["subtitles"] == null
            ? []
            : List<Subtitle>.from(
                json["subtitles"]!.map((x) => Subtitle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "headers": headers?.toJson(),
        "sources": sources == null
            ? []
            : List<dynamic>.from(sources!.map((x) => x.toJson())),
        "subtitles": subtitles == null
            ? []
            : List<dynamic>.from(subtitles!.map((x) => x.toJson())),
      };
}

class Headers {
  String? referer;

  Headers({
    this.referer,
  });

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
        referer: json["Referer"],
      );

  Map<String, dynamic> toJson() => {
        "Referer": referer,
      };
}

class Source {
  String? url;
  String? quality;
  bool? isM3U8;

  Source({
    this.url,
    this.quality,
    this.isM3U8,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        url: json["url"],
        quality: json["quality"],
        isM3U8: json["isM3U8"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "quality": quality,
        "isM3U8": isM3U8,
      };
}

class Subtitle {
  String? url;
  String? lang;

  Subtitle({
    this.url,
    this.lang,
  });

  factory Subtitle.fromJson(Map<String, dynamic> json) => Subtitle(
        url: json["url"],
        lang: json["lang"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "lang": lang,
      };
}
