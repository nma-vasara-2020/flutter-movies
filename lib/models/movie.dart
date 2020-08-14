import 'package:json_annotation/json_annotation.dart';
import 'package:movies/constants.dart';

import 'genre.dart';

part 'movie.g.dart';

// https://flutter.dev/docs/development/data-and-backend/json
@JsonSerializable()
class Movie {
  @JsonKey(disallowNullValue: true)
  final int id;

  @JsonKey(disallowNullValue: true)
  final String title;

  @JsonKey(disallowNullValue: true)
  final String overview;

  @JsonKey(name: 'original_title', disallowNullValue: true)
  final String originalTitle;

  @JsonKey(name: 'original_language', disallowNullValue: true)
  final String originalLanguage;

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: 'backdrop_path')
  final String backdropPath;

  @JsonKey(name: 'vote_average', disallowNullValue: true)
  final double voteAverage;

  @JsonKey(name: 'genre_ids', disallowNullValue: true)
  final List<int> genreIds;

  @JsonKey(name: 'release_date', disallowNullValue: true)
  final String releaseDate;

  @JsonKey(name: 'video', disallowNullValue: true)
  final bool hasVideo;

  String get posterUrl =>
      posterPath != null ? "https://image.tmdb.org/t/p/w500$posterPath" : null;

  String get backdropUrl => backdropPath != null
      ? "https://image.tmdb.org/t/p/w780$backdropPath"
      : null;

  String get webUrl => "https://www.themoviedb.org/movie/$id";

  List<Genre> get genres =>
      Constants.GENRES.where((g) => genreIds.contains(g.id)).toList();

  const Movie(
    this.id,
    this.title,
    this.originalTitle,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.originalLanguage,
    this.genreIds,
    this.releaseDate,
    this.hasVideo,
  );

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
