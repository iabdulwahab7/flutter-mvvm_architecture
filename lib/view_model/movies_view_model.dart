import 'package:flutter/material.dart';
import 'package:mvvm/data/resources/api_response.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/repository/movies_repository.dart';

class MoviesViewModel with ChangeNotifier {
  final _myRepo = MoviesRepository();

  ApiResponse<MoviesListModel> moviesList = ApiResponse.loading();

  //setter method
  setMoviesList(ApiResponse<MoviesListModel> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());

    try {
      MoviesListModel moviesListModel = await _myRepo.fetchMoviesList();
      setMoviesList(ApiResponse.completed(moviesListModel));
    } catch (e) {
      setMoviesList(ApiResponse.error(e.toString()));
    }
  }
}
