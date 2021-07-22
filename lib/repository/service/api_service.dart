import 'package:dio/dio.dart';
import 'package:movieflix_flutter/repository/model/cast_list.dart';
import 'package:movieflix_flutter/repository/model/genre.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';
import 'package:movieflix_flutter/repository/model/movie_detail.dart';
import 'package:movieflix_flutter/repository/model/movie_image.dart';
import 'package:movieflix_flutter/repository/model/person.dart';
import 'package:movieflix_flutter/utill/constants.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final url = '$baseUrl/movie/now_playing?api_key=$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Genre>> getGenreList() async {
    try {
      final url = '$baseUrl/genre/movie/list?api_key=$apiKey';
      final response = await _dio.get(url);
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g) => Genre.fromJson(g)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getMovieByGenre(int movieId) async {
    try {
      final url = '$baseUrl/discover/movie?with_genres=$movieId&api_key=$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Person>> getTrendingPerson() async {
    try {
      final response = await _dio.get('$baseUrl/trending/person/week?api_key=$apiKey');
      var persons = response.data['results'] as List;
      List<Person> personList = persons.map((p) => Person.fromJson(p)).toList();
      return personList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final url = '$baseUrl/movie/$movieId?api_key=$apiKey';
      final response = await _dio.get(url);
      MovieDetail movieDetail = MovieDetail.fromJson(response.data);

      movieDetail.trailerId = await getYoutubeId(movieId);

      movieDetail.movieImage = await getMovieImage(movieId);

      movieDetail.castList = await getCastList(movieId);

      return movieDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$id/videos?api_key=$apiKey');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<MovieImage> getMovieImage(int movieId) async {
    try {
      final url = "$baseUrl/movie/$movieId/images?api_key=$apiKey";
      final response = await _dio.get(url);
      var movieImage = MovieImage.fromJson(response.data);
      return movieImage;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Cast>> getCastList(int movieId) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId/credits?api_key=$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> castList = list
          .map((c) => Cast(
              name: c['name'],
              profilePath: c['profile_path'],
              character: c['character']))
          .toList();
      return castList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
