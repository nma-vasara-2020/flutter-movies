import 'package:flutter/material.dart';
import 'package:movies/api/movies_api_service.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/ui/widgets/error_indicator.dart';
import 'package:movies/ui/widgets/loading_indicator.dart';

import 'popular_movies_tab.dart';

class MoviesInTheaterTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: MoviesApiService().getCurrentPlayingMovies(),
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
