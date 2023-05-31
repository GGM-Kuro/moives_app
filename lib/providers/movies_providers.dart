import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier{
    MoviesProvider(){
        print('MoviesProvider inisializado');
        this.getOnDisplayMovies();
    }


    getOnDisplayMovies() async{
        print('getOnDisplayMovies');
    }

}
