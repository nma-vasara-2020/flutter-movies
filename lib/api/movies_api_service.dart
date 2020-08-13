import 'dart:math';

import 'package:dio/dio.dart';
import 'package:movies/models/movie.dart';

class MoviesApiService {
  static final MoviesApiService _singleton = new MoviesApiService._internal();

  factory MoviesApiService() {
    return _singleton;
  }

  MoviesApiService._internal();

  static const _baseApiUrl = "https://api.themoviedb.org/3/";
  static const _apiKey = "e9b7754fbc9d5203fdaa684d12a447e8";

  final _dio = Dio(
    BaseOptions(
      baseUrl: _baseApiUrl,
    ),
  );

  // https://developers.themoviedb.org/3/movies/get-popular-movies
  Future<List<Movie>> getPopularMovies() async {
    final response = await _dio.get(
      "/movie/popular/",
      queryParameters: {
        'api_key': _apiKey,
      },
    );

    return _parseMoviesFromResponse(response.data);
  }

  // https://developers.themoviedb.org/3/discover/movie-discover
  Future<Response> _getRandomMoviesResponse(int genreId, int page) async {
    // ?? operator: a ?? b is the same as if (a != null) a else b
    final genreText = genreId ?? "";

    final response = await _dio.get(
      "/discover/movie/",
      queryParameters: {
        'api_key': _apiKey,
        'with_genres': genreText,
        'vote_average.gte': 7,
        'primary_release_date.gte': 2010,
        'vote_count.gte': 500,
        'include_adult': false,
        'page': page,
      },
    );
    print(response.realUri);

    return response;
  }

  Future<List<Movie>> getRandomMovies(int genreId) async {
    final response = await _getRandomMoviesResponse(genreId, 1);

    final totalPages = response.data["total_pages"];
    final random = Random();

    final randomPageResponse =
        await _getRandomMoviesResponse(genreId, random.nextInt(totalPages));

    final movies = _parseMoviesFromResponse(randomPageResponse.data);

    // Some movies don't have backdrops, put them at the end
    movies.sort((a, b) => a.backdropUrl == null ? 1 : 0);

    return movies;
  }

  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final response = await _dio.get(
      "/movie/$movieId/similar",
      queryParameters: {
        'api_key': _apiKey,
      },
    );

    return _parseMoviesFromResponse(response.data).take(3).toList();
  }

  List<Movie> _parseMoviesFromResponse(dynamic responseData) {
    return responseData['results']
        .map<Movie>((model) => Movie.fromJson(model))
        .toList(growable: false);
  }
}
