import 'package:flutter/material.dart';
import 'package:movies/api/movies_api_service.dart';
import 'package:movies/models/movie.dart';
import 'package:share/share.dart';

import 'tabs/popular_movies_tab.dart';
import 'widgets/error_indicator.dart';
import 'widgets/loading_indicator.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: MovieCoverImage(movie: movie),
              title: MovieDetailsHeaderTitle(
                movie: movie,
              ),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: MovieDetailsBody(
              movie: movie,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _shareMovie,
        label: Text("Share"),
        icon: Icon(
          Icons.share,
        ),
      ),
    );
  }

  _shareMovie() {
    Share.share('${movie.title} ${movie.webUrl}');
  }
}

class MovieDetailsHeaderTitle extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeaderTitle({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      movie.title,
      style: Theme.of(context).textTheme.headline5.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: getTextShadow(
              Colors.black,
              0.2,
            ),
          ),
    );
  }

  // Used to make contrast between image and text
  List<Shadow> getTextShadow(Color color, double d) {
    return [
      Shadow(
          // bottomLeft
          offset: Offset(-d, -d),
          color: color),
      Shadow(
          // bottomRight
          offset: Offset(d, -d),
          color: color),
      Shadow(
          // topRight
          offset: Offset(d, d),
          color: color),
      Shadow(
        // topLeft
        offset: Offset(-d, d),
        color: color,
      )
    ];
  }
}

class MovieDetailsBody extends StatelessWidget {
  final Movie movie;

  const MovieDetailsBody({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.genres.map((g) => g.name).join(' / '),
            style: TextStyle(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              "Overview",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              movie.overview,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              "Similar movies",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          FutureBuilder(
            future: MoviesApiService().getSimilarMovies(movie.id),
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.hasError) {
                return ErrorIndicator(error: snapshot.error);
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Column(
                  children: snapshot.data
                      .map((e) => MoviesListViewCell(movie: e))
                      .toList(),
                );
              }

              return LoadingIndicator();
            },
          )
        ],
      ),
    );
  }
}
