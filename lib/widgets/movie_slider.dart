import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key, required this.movies, this.title});

  final List<Movie> movies;
  final String? title;

  @override
  Widget build(BuildContext context) {
      return  SizedBox(
      width: double.infinity,
      height: 290,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          if (title != null)
              Padding(
              padding: EdgeInsets.symmetric( horizontal: 20 ),
              child:

              Text(
                  title!,
                  style:  TextStyle( fontSize: 20, fontWeight: FontWeight.bold )
              ),

            ),

          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
            scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: ( _ , int index) =>  _MoviePoster(movies[index])
            ),
          )
          ],
          ),
              );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster(this.movie);

    final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 130,
    height: 290,
    margin: const EdgeInsets.symmetric( horizontal: 10, ),
    child: Column(
        children: [

        GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
          child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child:  FadeInImage(
                placeholder: const AssetImage('assets/images/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox( height: 5, ),
         Text(
                movie.title,
                style: const TextStyle(fontWeight: FontWeight.bold
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
            ),
         Text(
            movie.overview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
        )

        ],
        ),
            );
  }
}
