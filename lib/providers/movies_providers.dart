import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';

import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{

    final String _baseurl  = 'api.themoviedb.org';
    final String _apiKey   = 'da7a0e2ac1557b74bd370fe9afa2a88f';
    final String _language = 'es-ES';

    List<Movie> onDisplayMovies = [];
    List<Movie> popularMovies = [];

    Map<int, List<Cast>> movieCast = {};

    int _popularPages = 0;


    final debouncer = Debouncer(
        duration: const Duration(milliseconds: 500),
    );

    final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
    Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

    MoviesProvider(){
        getOnDisplayMovies();
        getPopularMovies();
    }

    Future<String> _getJsonData(String endpoint, [ int page = 1 ]) async{
        final url = Uri.https(_baseurl, endpoint, {
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

    Future<List<Movie>> searchMovie( String query ) async{


        final url = Uri.https(_baseurl, '3/search/movie', {
              'api_key': _apiKey,
              'language': _language,
              'query': query,
      });
      final response = await http.get(url);
        final searchResponse = SearchResponse.fromJson(response.body);
        return searchResponse.results;
    }

    void getSuggestionsByQuery (String searchTerm){

        debouncer.value = '';
        debouncer.onValue = ( value ) async {

            final results = await searchMovie(value);
            _suggestionStreamController.add(results);

        };

        final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
            debouncer.value =searchTerm;
        });

        Future.delayed(const Duration( milliseconds: 301 )).then(( _ ) => timer.cancel());

    }


}
