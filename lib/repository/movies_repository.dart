// ignore_for_file: prefer_final_fields, use_rethrow_when_possible

import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/res/app_url.dart';

class MoviesRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<MoviesListModel> fetchMoviesList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesEndPointUrl);
      return response = MoviesListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
