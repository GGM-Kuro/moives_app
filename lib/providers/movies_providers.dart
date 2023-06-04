import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{

    final String _baseurl  = 'api.themoviedb.org';
    final String _apiKey   = 'da7a0e2ac1557b74bd370fe9afa2a88f';
    final String _language = 'es-ES';

    List<Movie> onDisplayMovies = [];
    List<Movie> popularMovies = [];


    MoviesProvider(){
        print('MoviesProvider init');
        this.getOnDisplayMovies();
        this.getPopularMovies();
    }


    getOnDisplayMovies() async{
    var url = Uri.https(_baseurl, '3/movie/now_playing', {
          'api_key': _apiKey,
          'language': _language,
          'page': '1',
      });
  // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      final nowPlayingResponse =  NowPlayingResponse.fromJson(response.body);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();

    }



    getPopularMovies() async{
    var url = Uri.https(_baseurl, '3/movie/popular', {
          'api_key': _apiKey,
          'language': _language,
          'page': '1',
      });
  // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      final popularResponse =  PopularResponse.fromJson(response.body);
      popularMovies = [...popularMovies,...popularResponse.results];
      print(popularMovies.length);
      notifyListeners();

    }

}
