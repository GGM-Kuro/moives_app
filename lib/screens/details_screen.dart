import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      // TODO: cambiar por instancia de movie
      final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-wovie';



   return Scaffold(
           body: CustomScrollView(
               slivers: [
               _CustomAppBar(),
               SliverList(
                   delegate: SliverChildListDelegate([
                   _PosterAndTitle(),
                   _Overview(),
                   _Overview(),
                   _Overview(),
                   _Overview(),
                   _Overview(),
                   CastingCards(),
                   ])
               )
               ],
               )
    );  }
}


class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
      return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
    titlePadding: EdgeInsets.all(0),
      title: Container(
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only( bottom: 20 ),
      color: Colors.black12,
      child: Text(
          'movi.title',
          style: TextStyle( fontSize: 16 ),
      ),
          ),
      background: FadeInImage(
          placeholder: AssetImage('assets/images/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/200x300'),
          // image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
      ),
          ),
              );
  }
}
class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

      final TextTheme textTheme = Theme.of(context).textTheme;

      return Container(
      margin: EdgeInsets.only( top: 20  ),
      padding: EdgeInsets.symmetric( horizontal: 20  ),
      child: Row(
          children: [
          ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
          ),
              ),
          SizedBox( width: 20, ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('movie.title', style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text('movie.originlTitle', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,),

              Row(
                  children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                  Text('movie.voteAverage', style: textTheme.caption,)
                  ],
                 )
              ],
          )

          ],
          ),
              );
  }
}

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Container(
      padding: EdgeInsets.symmetric( horizontal: 30, vertical: 10  ),
      child: Text(
          'Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,
      ),
              );
  }
}
