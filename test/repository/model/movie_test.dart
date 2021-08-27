import 'package:flutter_test/flutter_test.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';

void main() {
  test('should return value when create a movie', () {
    final movie = Movie(
      backdropPath: "/8s4h9friP6Ci3adRGahHARVd76E.jpg",
      id: 379686,
      originalLanguage: "en",
      originalTitle: "Space Jam: A New Legacy",
      overview:
          "When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
      popularity: 9054.455,
      posterPath: "/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
      releaseDate: "2021-07-08",
      title: "Space Jam: A New Legacy",
      video: false,
      voteAverage: "7.8",
      voteCount: 1215,
    );

    expect(movie.backdropPath, "/8s4h9friP6Ci3adRGahHARVd76E.jpg");
    expect(movie.id, 379686);
    expect(movie.originalLanguage, "en");
    expect(movie.originalTitle, "Space Jam: A New Legacy");
    expect(movie.overview,
        "When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.");
    expect(movie.popularity, 9054.455);
    expect(movie.posterPath, "/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg");
    expect(movie.releaseDate, "2021-07-08");
    expect(movie.title, "Space Jam: A New Legacy");
    expect(movie.video, false);
    expect(movie.voteAverage, "7.8");
    expect(movie.voteCount, 1215);
  });

  test('should return error when create movie with id negative', () {
    expect(() => Movie(id: -1), throwsAssertionError);
  });
}
