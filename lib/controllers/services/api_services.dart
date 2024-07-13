import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix/models/episode_model.dart';
import 'package:netflix/models/item_model.dart';
import 'package:netflix/models/source_model.dart';
import 'package:netflix/models/subtitle_path_model.dart';

class ApiServices {
  static String baseURL = 'https://consumet-api-six-lemon.vercel.app';

  Future<List<ItemModel>> getTrending() async {
    try {
      final response =
          await http.get(Uri.parse("$baseURL/movies/flixhq/trending"));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<ItemModel> items = List.from(data['results'])
            .map((e) => ItemModel.fromJson(e))
            .toList();
        return items;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<ItemModel?> getMovieDetails(String movieId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseURL/movies/flixhq/info?id=$movieId"));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        ItemModel movie = ItemModel.fromJson(data);
        return movie;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<ItemModel>> getLatestSeries() async {
    try {
      final response =
          await http.get(Uri.parse("$baseURL/movies/flixhq/recent-shows"));

      if (response.statusCode == 200) {
        List<ItemModel> items = List.from(jsonDecode(response.body))
            .map((e) => ItemModel.fromJson(e))
            .toList();
        return items;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<ItemModel>> getLatestMovies() async {
    try {
      final response =
          await http.get(Uri.parse("$baseURL/movies/flixhq/recent-movies"));
      if (response.statusCode == 200) {
        List<ItemModel> items = List.from(jsonDecode(response.body))
            .map((e) => ItemModel.fromJson(e))
            .toList();
        return items;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<ItemModel>> getPopularAnime() async {
    try {
      final response =
          await http.get(Uri.parse("$baseURL/anime/gogoanime/popular"));
      if (response.statusCode == 200) {
        List<ItemModel> items = List.from(jsonDecode(response.body)['results'])
            .map((e) => ItemModel.fromJson(e))
            .toList();
        return items;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<ItemModel>> getLatestAnime() async {
    try {
      final response =
          await http.get(Uri.parse("$baseURL/anime/gogoanime/top-airing"));
      if (response.statusCode == 200) {
        List<ItemModel> items = List.from(jsonDecode(response.body)['results'])
            .map((e) => ItemModel.fromJson(e))
            .toList();
        return items;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Episodes>> getEpisode(int id, int season) async {
    try {
      final response = await http
          .get(Uri.parse("$baseURL/episode?tmdbId=$id&season=$season"));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        EpisodeModel model = EpisodeModel.fromJson(data);
        return model.episodes!
            .where((element) => element.seasonNumber! > 0)
            .toList();
      } else {
        throw Exception('Maaf server sedang sibuk');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ItemModel>> getSearch(String title, int page) async {
    try {
      final response =
          await http.get(Uri.parse("$baseURL/movies/flixhq/$title&page=$page"));
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['results'];
        List<ItemModel> result = <ItemModel>[];
        for (Map<String, dynamic> v in data) {
          result.add(ItemModel.fromJson(v));
        }

        return result;
      } else {
        throw Exception('Maaf server sedang sibuk');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ItemModel>> getCategory(String category, int page) async {
    try {
      final response = await http
          .get(Uri.parse("$baseURL/genre?genre=$category&page=$page"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<ItemModel> result = <ItemModel>[];
        for (Map<String, dynamic> v in data) {
          result.add(ItemModel.fromJson(v));
        }

        return result;
      } else {
        throw Exception('Maaf server sedang sibuk');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, List<SubtitlePathModel>>> getSubtitlePath(
      String imdbId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseURL/subtitle?imdb=$imdbId"));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Map<String, List> newData =
            data.map((key, value) => MapEntry(key, value));
        final result = newData.map((key, value) => MapEntry(
            key, value.map((e) => SubtitlePathModel.fromJson(e)).toList()));
        return result;
      } else {
        throw Exception('Maaf server sedang sibuk');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getSubtitleRawData(String imdbId, String path) async {
    try {
      final response = await http
          .get(Uri.parse("$baseURL/subtitle?imdb=$imdbId&path=$path"));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Maaf server sedang sibuk');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SourceModel> getSources(String episodeId, String mediaId) async {
    try {
      final response = await http.get(Uri.parse(
          "$baseURL/movies/flixhq/watch?episodeId=$episodeId&mediaId=$mediaId"));

      if (response.statusCode == 200) {
        return SourceModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Maaf server sedang sibuk');
      }
    } catch (e) {
      rethrow;
    }
  }
}
