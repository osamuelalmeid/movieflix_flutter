class Movie {
  Movie(
      {this.backdropPath,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteCount,
      this.voteAverage});

  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  String? voteAverage;
  int? voteCount;

  String error = "";

  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      return Movie();
    }

    return Movie(
          backdropPath: json['backdrop_path'],
          id: json['id'],
          originalLanguage: json['original_language'],
          originalTitle: json['original_title'],
          overview: json['overview'],
          popularity: json['popularity'],
          posterPath: json['poster_path'],
          releaseDate: json['release_date'],
          title: json['title'],
          video: json['video'],
          voteCount: json['vote_count'],
          voteAverage: json['vote_average'].toString());
  }
}
