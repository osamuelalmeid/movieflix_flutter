import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_bloc.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_event.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_state.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';
import 'package:movieflix_flutter/repository/repository_interface.dart';

class MockRepository extends Mock implements IRepository {}

void main() {
  MovieBloc movieBloc;
  MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    movieBloc = MovieBloc();
  });

  tearDown(() {
    movieBloc?.close();
  });

  test('initial state is correct', () {
    expect(movieBloc.state, MovieLoading());
  });

  blocTest("emits events when call movies service error",
      build: () {
        when(mockRepository.getNowPlayingMovie()).thenThrow("ops");
        return movieBloc;
      },
      act: (bloc) => bloc.add(MovieEventStarted(0, '')),
      expect: () => <MovieState>[
            MovieLoading(),
            MovieError(),
          ]);

  blocTest("emits events when call movies service sucess",
      build: () {
        when(mockRepository.getNowPlayingMovie()).thenAnswer(
          (_) => Future.value(listMovies),
        );
        return movieBloc;
      },
      act: (bloc) => bloc.add(MovieEventStarted(0, '')),
      expect: () => <MovieState>[
            MovieLoading(),
            MovieLoaded(listMovies),
          ]);
}

List<Movie> listMovies = [buildMovie(), buildMovie()];

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