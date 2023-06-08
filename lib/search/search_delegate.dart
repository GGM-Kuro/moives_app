import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_providers.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

    @override
      // TODO: implement searchFieldLabel
      String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
        return [
            IconButton(
                onPressed: () =>  query = '',
                icon: const Icon(Icons.clear)
            )
        ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
        return IconButton(
            onPressed: () => close(context, null),
            icon: const Icon(Icons.home)
        );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const Text('build buildResults');
  }

    Widget _emptyContainer(){
        return  Container(
                child: const Center(
                    child: Icon(Icons.movie_creation_rounded,color: Colors.black38,size: 130,),
                ),
            );

    }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
        if (query.isEmpty) return _emptyContainer();

        final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
        return FutureBuilder(
            future: moviesProvider.searchMovie(query),
            builder: ( _, AsyncSnapshot<List<Movie>> snapshot ) {
                if (!snapshot.hasData) return _emptyContainer();

                final movies = snapshot.data!;
                return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (_, int index) => _MovieItem(movie: movies[index])
                );
            },
        );
  }

}


class _MovieItem extends StatelessWidget {
  const _MovieItem({super.key, required this.movie});
    final Movie movie;

  @override
  Widget build(BuildContext context) {
        return ListTile(
            leading: FadeInImage(
                placeholder: const AssetImage('assets/images/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 50,
                fit: BoxFit.contain,


            ),
            title: Text(movie.title),
            subtitle: Text(movie.originalTitle),
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie) ,
        );
  }
}
