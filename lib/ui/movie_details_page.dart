import 'package:flutter/material.dart';
import 'package:movies/api/movies_api_service.dart';
import 'package:movies/models/actor.dart';
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
          SliverToBoxAdapter(
            child: MovieDetailsInformation(
              movie: movie,
            ),
          ),
          SliverToBoxAdapter(
            child: MovieDetailsOverview(
              movie: movie,
            ),
          ),
          SliverToBoxAdapter(child: MovieDetailsHeadline(text: "Actors")),
          MovieActorsWidget(movieId: movie.id),
          SliverToBoxAdapter(
            child: MovieDetailsHeadline(text: "Similar movies"),
          ),
          SimilarMoviesWidget(movieId: movie.id),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _shareMovie,
        label: Text("SHARE"),
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

class MovieDetailsInformation extends StatelessWidget {
  final Movie movie;

  const MovieDetailsInformation({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Genres: " + movie.genres.map((g) => g.name).join(' / '),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    "Release date: ${movie.releaseDate}",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(
                Icons.stars,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                movie.voteAverage.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class MovieDetailsOverview extends StatelessWidget {
  final Movie movie;

  const MovieDetailsOverview({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieDetailsHeadline(
          text: "Overview",
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            movie.overview,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class MovieActorsWidget extends StatelessWidget {
  final int movieId;

  const MovieActorsWidget({Key key, @required this.movieId})
      : assert(movieId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MoviesApiService().getMovieActors(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: ErrorIndicator(error: snapshot.error),
          );
        } else if (snapshot.hasData) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final actor = snapshot.data[index];
                return ListTile(
                  title: Text(actor.name),
                  subtitle: Text(actor.character),
                  leading: actor.profileUrl != null
                      ? AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            actor.profileUrl,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset("assets/person.jpg"),
                );
              },
              childCount: snapshot.data.length,
            ),
          );
        }
        return SliverToBoxAdapter(
          child: LoadingIndicator(),
        );
      },
    );
  }
}

class MovieDetailsHeadline extends StatelessWidget {
  final String text;

  const MovieDetailsHeadline({Key key, @required this.text})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

class SimilarMoviesWidget extends StatelessWidget {
  final int movieId;

  const SimilarMoviesWidget({Key key, @required this.movieId})
      : assert(movieId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MoviesApiService().getSimilarMovies(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: ErrorIndicator(error: snapshot.error),
          );
        } else if (snapshot.hasData) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => MoviesListViewCell(
                movie: snapshot.data[index],
              ),
              childCount: snapshot.data.length,
            ),
          );
        }
        return SliverToBoxAdapter(
          child: LoadingIndicator(),
        );
      },
    );
  }
}
