import 'package:get/get.dart';
import 'package:netflix/controllers/services/api_services.dart';
import 'package:netflix/models/item_model.dart';
import 'package:netflix/models/status_enum.dart';
import 'package:netflix/models/subtitle_path_model.dart';

class DetailController extends GetxController {
  static DetailController instance = Get.find();
  final ApiServices _apiServices = ApiServices();

  /* state */
  final Rx<List<Episode>> _episode = Rx<List<Episode>>([]);
  final Rx<Status> _episodeDataStatus = Rx<Status>(Status.LOADING);
  final Rx<Map<String, List<SubtitlePathModel>>?> _subtitlePathModel = Rx(null);
  final Rx<Status> _subtitleDataStatus = Rx<Status>(Status.LOADING);
  final Rx<String?> _subtitleRaw = Rx(null);
  final Rx<Status> _subtitleRawDataStatus = Rx<Status>(Status.LOADING);
  final Rx<ItemModel?> _item = Rx(null);

  /* getter */
  List<Episode> get episode => _episode.value;
  Status get episodeDataStatus => _episodeDataStatus.value;
  Map<String, List<SubtitlePathModel>>? get subtitlePathModel =>
      _subtitlePathModel.value;

  String? get subtitleRaw => _subtitleRaw.value;
  Status get subtitleRawDataStatus => _subtitleRawDataStatus.value;
  ItemModel? get item => _item.value;

  Future<void> getSubtitlePath(String imdbId) async {
    try {
      final response = await _apiServices.getSubtitlePath(imdbId);
      Map<String, List<SubtitlePathModel>> result = {};
      for (var item in response.keys) {
        List<SubtitlePathModel> resultList = [];
        for (var list in response[item]!) {
          if (resultList
              .where((element) => element.name == list.name)
              .isEmpty) {
            resultList.add(list);
          }
        }
        result[item] = resultList;
      }

      _subtitlePathModel.value = result;
      _subtitleDataStatus.value = Status.SUCCESS;
    } catch (e) {
      _subtitleDataStatus.value = Status.ERROR;
      rethrow;
    }
  }

  Future<void> getSubtitleRawData(String imdbId, String path) async {
    try {
      final response = await _apiServices.getSubtitleRawData(imdbId, path);
      _subtitleRaw.value = response;
      _subtitleRawDataStatus.value = Status.SUCCESS;
    } catch (e) {
      _subtitleRawDataStatus.value = Status.ERROR;
      rethrow;
    }
  }

  void resetSubtitle() {
    _subtitleDataStatus.value = Status.LOADING;
  }

  Future<void> getMovieDetails(String movieId) async {
    try {
      final response = await _apiServices.getMovieDetails(movieId);
      _item.value = response;
      _episode.value = response?.episodes ?? [];

      _episodeDataStatus.value = Status.SUCCESS;
    } catch (e) {
      _episodeDataStatus.value = Status.SUCCESS;
      print(e);
    }
  }
}
