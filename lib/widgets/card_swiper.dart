import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class CardSwiper extends StatelessWidget {

    final List<Movie> movies;

  const CardSwiper({
      super.key,
      required this.movies
  });



  @override
  Widget build(BuildContext context) {

      final size = MediaQuery.of( context ).size;

      if( movies.isEmpty ) {
          return SizedBox(
                width: double.infinity,
                height: size.height * 05,
                child: const Center(
                child: CircularProgressIndicator(),
                    ),
                  );
      }


      return SizedBox(
      width: double.infinity,
      height: size.height *0.5,
      child: Swiper(
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: ( BuildContext context, int index ){

              final movie = movies[index];
              movie.heroId = 'swiper-${ movie.id }';

              return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: movie) ,
                child: Hero(
                tag: movie.heroId!,
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                        placeholder: const AssetImage('assets/images/no-image.jpg'),
                        // image: NetworkImage('https://via.placeholder.com/300x400'),
                        image: NetworkImage( movie.fullPosterImg ),
                        fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
          },
      ),
              );
  }
}
