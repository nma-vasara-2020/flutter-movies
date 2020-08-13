import 'package:flutter/material.dart';
import 'package:movies/api/movies_api_service.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/routes.dart';

import 'widgets/error_indicator.dart';
import 'widgets/loading_indicator.dart';

class PopularMoviesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: MoviesApiService().getPopularMovies(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasError) {
            return ErrorIndicator(error: snapshot.error);
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return MoviesListView(movies: snapshot.data);
          }

          return LoadingIndicator();
        },
      ),
    );
  }
}

class MoviesListView extends StatelessWidget {
  final List<Movie> movies;

  const MoviesListView({Key key, @required this.movies})
      : assert(movies != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // https://flutter.dev/docs/cookbook/lists/mixed-list
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: movies.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        return MoviesListViewCell(
          movie: movies[index],
        );
      },
    );
  }
}

class MoviesListViewCell extends StatelessWidget {
  final Movie movie;

  const MoviesListViewCell({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.ROUTE_MOVIE_DETAILS,
          arguments: movie,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: MovieCoverImage(movie: movie),
                ),
                Positioned.fill(
                  child: MovieTitle(movie: movie),
                ),
                MovieRating(movie: movie),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieCoverImage extends StatelessWidget {
  final Movie movie;

  const MovieCoverImage({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movie.backdropUrl != null) {
      return Hero(
        tag: "movie-backdrop-${movie.id}",
        child: Image.network(
          movie.backdropUrl,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(color: Colors.blue);
  }
}

class MovieTitle extends StatelessWidget {
  final Movie movie;

  const MovieTitle({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class MovieRating extends StatelessWidget {
  final Movie movie;

  const MovieRating({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    Icons.stars,
                    color: Colors.white,
                  ),
                ),
                Text(
                  movie.voteAverage.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
