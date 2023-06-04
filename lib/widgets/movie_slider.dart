import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider({super.key, required this.movies, this.title, required this.onNextPage});

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
    void initState() {
      // TODO: implement initState
        scrollController.addListener(() {

            if (scrollController.position.pixels >= scrollController.position.maxScrollExtent -500) {
                widget.onNextPage();
                        }
                });


      super.initState();
    }
  @override
    void dispose() {
      // TODO: implement dispose



      super.dispose();
    }


  @override
  Widget build(BuildContext context) {
      return  SizedBox(
      width: double.infinity,
      height: 290,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          if (widget.title != null)
              Padding(
              padding: EdgeInsets.symmetric( horizontal: 20 ),
              child:

              Text(
                  widget.title!,
                  style:  TextStyle( fontSize: 20, fontWeight: FontWeight.bold )
              ),

            ),

          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: ( _ , int index) =>  _MoviePoster(widget.movies[index])
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
