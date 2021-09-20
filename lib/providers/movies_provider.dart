import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/models/popular_response.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '19c0cd86b94cabbe32dfa1440e41e8f9';
  String _baseUrl = 'api.themoviedb.org';
  String _languaje = 'es-ES';
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'languaje': _languaje, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
    // print(nowPlayingResponse.results[0].title);
    // final decodedData = json.decode(response.body) as Map<String,dynamic>;
    // print(decodedData['results']);
  }

getPopularMovies() async{
      var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'languaje': _languaje, 'page': '1'});
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popularMovies = [...popularMovies,...popularResponse.results];
    notifyListeners();
}

}
