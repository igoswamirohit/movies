import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import '../../presentation/pages/movies/movie_detail_page.dart';
import '../../presentation/pages/pages.dart';


class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case MovieDetailPage.routeName:
                    return MovieDetailPage(movie: settings.arguments as Movie,);
                  default:
                    return const MoviesListPage();
                }
              },
            );
          }
}