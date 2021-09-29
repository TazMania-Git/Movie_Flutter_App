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
  int _popularPage = 0;
  Map<int,List<Cast>> movieCasting = {};

  MoviesProvider() {
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endPoint,
        {'api_key': _apiKey, 'languaje': _languaje, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final getJsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(getJsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
    // var url = Uri.https(_baseUrl, '3/movie/now_playing',
    //     {'api_key': _apiKey, 'languaje': _languaje, 'page': '1'});

    // // Await the http get response, then decode the json-formatted response.
    // final response = await http.get(url);
    // print(nowPlayingResponse.results[0].title);
    // final decodedData = json.decode(response.body) as Map<String,dynamic>;
    // print(decodedData['results']);
  }

  getPopularMovies() async {
    _popularPage++;
    final getJsonData = await _getJsonData('3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(getJsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

 Future<List<Cast>> getMovieCast(int movieId) async{

    final getJsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(getJsonData);

    movieCasting[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

}


}
