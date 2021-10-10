import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/movie.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  static const routeName = '/detailPage';

  final Movie movie;

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    var movie = widget.movie;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(movie.title),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                height: MediaQuery.of(context).size.height * 0.4,
                imageUrl:
                    'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                cacheKey: 'cacheDetailsKey-${movie.id}',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(movie.overview, style: textStyle),
              const SizedBox(height: 15),
              Text(
                  'Released on: ${DateFormat('dd MMM, yyyy').format(movie.releaseDate!)}',
                  style: textStyle),
              const SizedBox(height: 5),
              Text('Popularity: ${movie.popularity.toStringAsFixed(1)}%',
                  style: textStyle),
              const SizedBox(height: 5),
              Text('Language: ${movie.originalLanguage}', style: textStyle),
            ],
          ),
        ],
      ),
    );
  }
}
