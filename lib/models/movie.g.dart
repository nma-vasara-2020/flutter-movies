// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const [
    'id',
    'title',
    'overview',
    'original_title',
    'original_language',
    'vote_average',
    'genre_ids',
    'release_date',
    'video'
  ]);
  return Movie(
    json['id'] as int,
    json['title'] as String,
    json['original_title'] as String,
    json['poster_path'] as String,
    json['backdrop_path'] as String,
    (json['vote_average'] as num)?.toDouble(),
    json['overview'] as String,
    json['original_language'] as String,
    (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
    json['release_date'] as String,
    json['video'] as bool,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('overview', instance.overview);
  writeNotNull('original_title', instance.originalTitle);
  writeNotNull('original_language', instance.originalLanguage);
  val['poster_path'] = instance.posterPath;
  val['backdrop_path'] = instance.backdropPath;
  writeNotNull('vote_average', instance.voteAverage);
  writeNotNull('genre_ids', instance.genreIds);
  writeNotNull('release_date', instance.releaseDate);
  writeNotNull('video', instance.hasVideo);
  return val;
}
