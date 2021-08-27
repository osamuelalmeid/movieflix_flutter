import 'package:dio/dio.dart';
import 'package:movieflix_flutter/repository/model/cast_list.dart';
import 'package:movieflix_flutter/repository/model/genre.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';
import 'package:movieflix_flutter/repository/model/movie_detail.dart';
import 'package:movieflix_flutter/repository/model/movie_image.dart';
import 'package:movieflix_flutter/repository/model/person.dart';

abstract class IRepository {
  final Dio dio;

  IRepository(this.dio);

  Future<List<Movie>> getNowPlayingMovie();
  Future<List<Genre>> getGenreList();
  Future<List<Movie>> getMovieByGenre(int movieId);
  Future<List<Person>> getTrendingPerson();
  Future<MovieDetail> getMovieDetail(int movieId);
  Future<String> getYoutubeId(int id);
  Future<MovieImage> getMovieImage(int movieId);
  Future<List<Cast>> getCastList(int movieId);
}
