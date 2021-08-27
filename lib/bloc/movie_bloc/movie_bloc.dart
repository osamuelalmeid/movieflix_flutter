import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_event.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_state.dart';
import 'package:movieflix_flutter/repository/repository.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieEventStarted) {
      yield* _mapMovieEventStateToState(event.movieId, event.query);
    }
  }

  Stream<MovieState> _mapMovieEventStateToState(int movieId, String query) async* {
    final service = Repository(Dio());
    yield MovieLoading();
    try {
      List<Movie> movieList = [];
      if (movieId == 0) {
        movieList = await service.getNowPlayingMovie();
      } else {
        movieList = await service.getMovieByGenre(movieId);
      }
      yield MovieLoaded(movieList);
    } on Exception catch (error) {
      print('Exception accoured: $error');
      yield MovieError();
    }
  }
}
