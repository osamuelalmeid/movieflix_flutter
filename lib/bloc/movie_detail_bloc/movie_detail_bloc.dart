import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix_flutter/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:movieflix_flutter/bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:movieflix_flutter/repository/repository.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailLoading());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is MovieDetailEventStarted) {
      yield* _mapMovieDetailEventStateToState(event.id);
    }
  }

  Stream<MovieDetailState> _mapMovieDetailEventStateToState(int id) async* {
    final service = Repository(Dio());
    yield MovieDetailLoading();
    try {
      final movieDetail = await service.getMovieDetail(id);
      yield MovieDetailLoaded(movieDetail);
    } on Exception catch (_) {
      yield MovieDetailError();
    }
  }
  
}
