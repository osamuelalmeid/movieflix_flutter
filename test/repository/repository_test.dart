import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflix_flutter/repository/model/cast_list.dart';
import 'package:movieflix_flutter/repository/model/genre.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';
import 'package:movieflix_flutter/repository/model/movie_detail.dart';
import 'package:movieflix_flutter/repository/model/movie_image.dart';
import 'package:movieflix_flutter/repository/model/person.dart';
import 'package:movieflix_flutter/repository/repository_interface.dart';

class MockRepository extends Mock implements IRepository {}

@GenerateMocks([IRepository])
void main() {
  MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
  });

  test('Should return list movie when call getNowPlayingMovie sucess',
      () async {
    when(mockRepository.getNowPlayingMovie())
        .thenAnswer((_) => Future.value(listMovies));

    var movies = await mockRepository.getNowPlayingMovie();

    expect(movies.length, 3);
  });

  test('Should return list movie when call getGenreList sucess', () async {
    when(mockRepository.getGenreList())
        .thenAnswer((_) => Future.value(listGenres));

    var genres = await mockRepository.getGenreList();

    expect(genres.length, 2);
  });

  test('Should return list movie when call getMovieByGenre sucess', () async {
    when(mockRepository.getMovieByGenre(123))
        .thenAnswer((_) => Future.value(listMovies));

    var movies = await mockRepository.getMovieByGenre(123);

    expect(movies.length, 3);
  });

  test('Should return list movie when call getTrendingPerson sucess', () async {
    when(mockRepository.getTrendingPerson())
        .thenAnswer((_) => Future.value(listPerson));

    var persons = await mockRepository.getTrendingPerson();

    expect(persons.length, 4);
  });

  test('Should return list movie when call getMovieDetail sucess', () async {
    when(mockRepository.getMovieDetail(123))
        .thenAnswer((_) => Future.value(buildMovieDetail()));

    var movieDetail = await mockRepository.getMovieDetail(123);

    expect(movieDetail, buildMovieDetail());
  });

  test('Should return list movie when call getYoutubeId sucess', () async {
    when(mockRepository.getYoutubeId(123))
        .thenAnswer((_) => Future.value("urlYoutube"));

    var urlYoutube = await mockRepository.getYoutubeId(123);

    expect(urlYoutube, "urlYoutube");
  });

  test('Should return list movie when call getMovieImage sucess', () async {
    when(mockRepository.getMovieImage(123))
        .thenAnswer((_) => Future.value(MovieImage()));

    var movieImage = await mockRepository.getMovieImage(123);

    expect(movieImage, MovieImage());
  });

  test('Should return list movie when call getCastList sucess', () async {
    when(mockRepository.getCastList(123))
        .thenAnswer((_) => Future.value(listCast));

    var casts = await mockRepository.getCastList(123);

    expect(casts.length, 5);
  });
}

List<Movie> listMovies = [buildMovie(), buildMovie(), buildMovie()];

List<Genre> listGenres = [
  Genre(id: 1, name: "Genre 1"),
  Genre(id: 2, name: "Genre 2")
];

List<Person> listPerson = [
  Person(),
  Person(),
  Person(),
  Person(),
];

List<Cast> listCast = [
  Cast(),
  Cast(),
  Cast(),
  Cast(),
  Cast(),
];

buildMovie() {
  Movie(
      backdropPath: "/8s4h9friP6Ci3adRGahHARVd76E.jpg",
      id: 379686,
      originalLanguage: "en",
      originalTitle: "Space Jam: A New Legacy",
      overview:
          "When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
      popularity: 7153.206,
      posterPath: "/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
      releaseDate: "2021-07-08",
      title: "Space Jam: A New Legacy",
      video: false,
      voteCount: 1230,
      voteAverage: "7.8");
}

buildMovieDetail() {
  MovieDetail(
    backdropPath: "/8s4h9friP6Ci3adRGahHARVd76E.jpg",
      id: "379686",
      originalTitle: "Space Jam: A New Legacy",
      overview:
          "When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
      releaseDate: "2021-07-08",
      title: "Space Jam: A New Legacy",
      voteCount: "1230",
      voteAverage: "7.8"
  );
}
