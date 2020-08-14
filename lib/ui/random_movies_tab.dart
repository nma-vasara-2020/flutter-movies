import 'package:flutter/material.dart';
import 'package:movies/api/movies_api_service.dart';
import 'package:movies/models/genre.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/ui/widgets/error_indicator.dart';
import 'package:movies/ui/widgets/loading_indicator.dart';
import 'package:movies/ui/popular_movies_tab.dart';

class RandomMoviesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomMoviesTabState();
  }
}

// App state https://flutter.dev/docs/development/ui/interactive
class RandomMoviesTabState extends State<RandomMoviesTab> {
  static final _allGenresItem = Genre(null, "All genres");
  Genre _selectedGenre = _allGenresItem;
  final _moviesApiService = MoviesApiService();

  onGenreChanged(Genre genre) {
    setState(() {
      _selectedGenre = genre;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => onGenreChanged(_selectedGenre),
        label: Text("Discover movies"),
        icon: Icon(Icons.explore),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Genre>(
                items: [_allGenresItem, ...Genre.GENRES]
                    .map(
                      (genre) => DropdownMenuItem<Genre>(
                        value: genre,
                        child: Text(genre.name),
                      ),
                    )
                    .toList(),
                value: _selectedGenre,
                isExpanded: true,
                onChanged: (genre) => onGenreChanged(genre),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _moviesApiService.getRandomMovies(_selectedGenre.id),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Movie>> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return MoviesListView(movies: snapshot.data);
                  } else if (snapshot.hasError) {
                    return ErrorIndicator(error: snapshot.error);
                  }
                  return LoadingIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
