// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  String? id;
  String? title;
  String? url;
  String? cover;
  String? image;
  String? description;
  String? type;
  String? releaseDate;
  List<String>? genres;
  List<String>? casts;
  List<String>? tags;
  String? production;
  String? country;
  String? duration;
  dynamic rating;
  List<Recommendation>? recommendations;
  List<Episode>? episodes;
  int? numberOfSeasons;
  List<String>? seasons;

  ItemModel(
      {this.id,
      this.title,
      this.url,
      this.cover,
      this.image,
      this.description,
      this.type,
      this.releaseDate,
      this.genres,
      this.casts,
      this.tags,
      this.production,
      this.country,
      this.duration,
      this.rating,
      this.recommendations,
      this.episodes,
      this.numberOfSeasons,
      this.seasons});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      title: json["title"],
      url: json["url"],
      cover: json["cover"],
      image: json["image"],
      description: json["description"],
      type: json["type"],
      releaseDate: json["releaseDate"],
      genres: json["genres"] == null
          ? []
          : List<String>.from(json["genres"]!.map((x) => x)),
      casts: json["casts"] == null
          ? []
          : List<String>.from(json["casts"]!.map((x) => x)),
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
      production: json["production"],
      country: json["country"],
      duration: json["duration"],
      rating: json["rating"],
      recommendations: json["recommendations"] == null
          ? []
          : List<Recommendation>.from(
              json["recommendations"]!.map((x) => Recommendation.fromJson(x))),
      episodes: json["episodes"] == null
          ? []
          : List<Episode>.from(
              json["episodes"]!.map((x) => Episode.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "cover": cover,
        "image": image,
        "description": description,
        "type": type,
        "releaseDate": releaseDate,
        "genres":
            genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "casts": casts == null ? [] : List<dynamic>.from(casts!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "production": production,
        "country": country,
        "duration": duration,
        "rating": rating,
        "recommendations": recommendations == null
            ? []
            : List<dynamic>.from(recommendations!.map((x) => x.toJson())),
        "episodes": episodes == null
            ? []
            : List<dynamic>.from(episodes!.map((x) => x.toJson())),
      };
}

class Episode {
  String? id;
  String? title;
  String? url;

  Episode({
    this.id,
    this.title,
    this.url,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
      };
}

class Recommendation {
  String? id;
  String? title;
  String? image;
  String? duration;
  String? type;

  Recommendation({
    this.id,
    this.title,
    this.image,
    this.duration,
    this.type,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        duration: json["duration"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "duration": duration,
        "type": type,
      };
}
