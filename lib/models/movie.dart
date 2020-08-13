import 'package:json_annotation/json_annotation.dart';
import 'package:movies/constants.dart';

import 'genre.dart';

part 'movie.g.dart';

// https://flutter.dev/docs/development/data-and-backend/json
@JsonSerializable()
class Movie {
  final int id;

  final String title;

  final String overview;

  @JsonKey(name: 'original_title')
  final String originalTitle;

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: 'backdrop_path')
  final String backdropPath;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'original_language')
  final String originalLanguage;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  @JsonKey(name: 'video')
  final bool hasVideo;

  String get posterUrl =>
      posterPath != null ? "https://image.tmdb.org/t/p/w500$posterPath" : null;

  String get backdropUrl => backdropPath != null
      ? "https://image.tmdb.org/t/p/w780$backdropPath"
      : null;

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
