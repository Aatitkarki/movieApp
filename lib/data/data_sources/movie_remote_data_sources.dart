import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movies_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final Client _client;
  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get(
        "${ApiConstants.BASE_URL}trending/movie/day?api_keys=${ApiConstants.API_KEY}",
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final movies = MoviesResultModel.fromJson(responseBody).movies;
      print(movies);
      return movies;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
