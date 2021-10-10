import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/util/other_util.dart';

import '../../../core/extensions/extensions.dart';
import '../../../domain/entities/movie.dart';
import '../../blocs/bloc.dart';
import 'movie_detail_page.dart';

class MoviesListPage extends StatefulWidget {
  const MoviesListPage({Key? key}) : super(key: key);

  static const routeName = '/movieListPage';

  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  final List<Movie> _movieList = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(const MoviesRequested('superman'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Movies'),
        foregroundColor: Colors.black,
      ),
      body: BlocConsumer<MoviesBloc, MoviesState>(
        listener: (context, state) {
          if (state is MoviesFetchProgress) {
            showSnackBar(context, 'Loading More Movies...');
          } else if (state is MoviesFetchSuccess && state.movies.isEmpty) {
            showSnackBar(context, 'No more movies!');
          } else if (state is MoviesFetchFailure) {
           showSnackBar(context,state.exception.toString());
            context.read<MoviesBloc>().isFetching = false;
          }
          return;
        },
        builder: (_, state) {
          if (state is MoviesFetchProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MoviesFetchSuccess) {
            _movieList.addAll(state.movies);
            context.read<MoviesBloc>().isFetching = false;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController
                  ..addListener(() {
                    if (_scrollController.offset ==
                            _scrollController.position.maxScrollExtent &&
                        !context.read<MoviesBloc>().isFetching) {
                      context.read<MoviesBloc>()
                        ..isFetching = true
                        ..add(const MoviesRequested('superman'));
                    }
                  }),
                itemBuilder: (context, index) {
                  Movie _movie = _movieList[index];
                  return MovieCard(movie: _movie);
                },
                separatorBuilder: (context, index) => Divider(
                      height: context.height * 0.02,
                      thickness: 1,
                    ),
                itemCount: _movieList.length),
          );
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required Movie movie,
  })  : _movie = movie,
        super(key: key);

  final Movie _movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, MovieDetailPage.routeName,
          arguments: _movie),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w92/${_movie.posterPath}',
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            cacheKey: 'cacheKey-${_movie.id}',
          )),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  _movie.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _movie.overview,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Realeased on: ${_movie.releaseDate == null ? 'No Data Found!' : DateFormat('dd MMM, yyyy').format(_movie.releaseDate!)}',
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
