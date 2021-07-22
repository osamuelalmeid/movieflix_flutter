import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix_flutter/bloc/genre_bloc/genre_event.dart';
import 'package:movieflix_flutter/bloc/genre_bloc/genre_state.dart';
import 'package:movieflix_flutter/repository/model/genre.dart';
import 'package:movieflix_flutter/repository/service/api_service.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoading());

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if (event is GenreEventStarted) {
      yield* _mapGenreEventStateToState();
    }
  }

  Stream<GenreState> _mapGenreEventStateToState() async* {
    final service = ApiService();
    yield GenreLoading();
    try {
      List<Genre> genreList = await service.getGenreList();
      yield GenreLoaded(genreList);
    } on Exception catch (_) {
      yield GenreError();
    }
  }
  
}
