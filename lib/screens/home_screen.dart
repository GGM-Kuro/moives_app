import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_providers.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies );

    return Scaffold(
            appBar: AppBar(
            title: const Text('Peliculas en cines'),
            elevation: 0,
            actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
            ],
                ),
            body: SingleChildScrollView(
              child: Column(
                  children: [
                  //NOTE: Tarjetas principales
                  CardSwiper( movies: moviesProvider.onDisplayMovies ),

                  //NOTE: Slider de peliculas
                  const MovieSlider(),
                  const MovieSlider(),
                  const MovieSlider(),
                  const MovieSlider(),

                  ],
                  ),
            )
    );
  }
}
