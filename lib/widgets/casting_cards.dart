import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_providers.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({required this.movieID});

  final int movieID;

  @override
  Widget build(BuildContext context) {

    final moviesProvider =Provider.of<MoviesProvider>(context, listen: false);


    return FutureBuilder(
            future: moviesProvider.getMovieCast(movieID),
            builder: ( _, AsyncSnapshot<List<Cast>> snapshot ){
                if ( !snapshot.hasData ) {

                    return Container(
                        constraints: const BoxConstraints(minWidth: 150 ),
                        height: 180,
                        child: const CupertinoActivityIndicator(),
                    );
                    }

                    final cast = snapshot.data!;

                      return Container(
                      margin: const EdgeInsets.only( bottom: 0  ),
                      width: double.infinity,
                      height: 180,
                      child: ListView.builder(
                          itemCount: cast.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, int index) => _CastCard(actor: cast[index]),
      ),
    );

            },
    );

      }
}


class _CastCard extends StatelessWidget {

    final Cast actor;

  const _CastCard({ required this.actor});

  @override
  Widget build(BuildContext context) {
      return Container(
      margin: const EdgeInsets.symmetric( horizontal: 10 ),
      width: 110,
      height: 100,
      child: Column(
          children: [

          ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:  FadeInImage(
              placeholder: const AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
          ),
              ),
              const SizedBox( height: 5, ),
               Text(
                    actor.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center ,
              )

          ],
          ),
              );
  }
}
