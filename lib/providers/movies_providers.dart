import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{

    final String _baseurl  = 'api.themoviedb.org';
    final String _apiKey   = 'da7a0e2ac1557b74bd370fe9afa2a88f';
    final String _language = 'es-ES';

    List<Movie> onDisplayMovies = [];
    List<Movie> popularMovies = [];

    Map<int, List<Cast>> movieCast = {};

    int _popularPages = 495;

    MoviesProvider(){
        getOnDisplayMovies();
        getPopularMovies();
    }

    Future<String> _getJsonData(String endpoint, [ int page = 1 ]) async{
        var url = Uri.https(_baseurl, endpoint, {
              'api_key': _apiKey,
              'language': _language,
              'page': '$page',
      });
          final response = await http.get(url);
          return response.body;

    }


    getOnDisplayMovies() async{
      final jsonData = await _getJsonData('3/movie/now_playing');
      final nowPlayingResponse =  NowPlayingResponse.fromJson(jsonData);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();

    }



    getPopularMovies() async{


      if (_popularPages >= 500) _popularPages = 0;

      _popularPages++;
      final jsonData = await _getJsonData('3/movie/popular', _popularPages);
      final popularResponse =  PopularResponse.fromJson(jsonData);
      popularMovies = [...popularMovies,...popularResponse.results];
      notifyListeners();

    }

    Future<List<Cast>>  getMovieCast(int movieId) async{

        if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

        final jsonData = await _getJsonData('3/movie/$movieId/credits');
        final creditsResponse = CredistResponse.fromJson(jsonData);
        movieCast[movieId] = creditsResponse.cast;
        return creditsResponse.cast;
        // notifyListeners();
        //
    }

}
