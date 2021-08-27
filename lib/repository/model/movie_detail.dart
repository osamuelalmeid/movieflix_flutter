import 'package:movieflix_flutter/repository/model/cast_list.dart';
import 'package:movieflix_flutter/repository/model/movie_image.dart';

class MovieDetail {
  MovieDetail(
      {this.id,
      this.title,
      this.backdropPath,
      this.budget,
      this.homePage,
      this.originalTitle,
      this.overview,
      this.releaseDate,
      this.runtime,
      this.voteAverage,
      this.voteCount});

  final String id;
  final String title;
  final String backdropPath;
  final String budget;
  final String homePage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String runtime;
  final String voteAverage;
  final String voteCount;

  String trailerId;

  MovieImage movieImage;

  List<Cast> castList;

  factory MovieDetail.fromJson(dynamic json) {
    if (json == null) {
      return MovieDetail();
    }

    return MovieDetail(
          id: json['id'].toString(),
          title: json['title'],
          backdropPath: json['backdrop_path'],
          budget: json['budget'].toString(),
          homePage: json['home_page'],
          originalTitle: json['original_title'],
          overview: json['overview'],
          releaseDate: json['release_date'],
          runtime: json['runtime'].toString(),
          voteAverage: json['vote_average'].toString(),
          voteCount: json['vote_count'].toString());
  }
}
