import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix_flutter/bloc/person_bloc/person_event.dart';
import 'package:movieflix_flutter/bloc/person_bloc/person_state.dart';
import 'package:movieflix_flutter/repository/repository.dart';
import 'package:movieflix_flutter/repository/model/person.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonLoading());

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event is PersonEventStarted) {
      yield* _mapPersonEventStateToState();
    }
  }

  Stream<PersonState> _mapPersonEventStateToState() async* {
    final service = Repository(Dio());
    yield PersonLoading();
    try {
      List<Person> personList = await service.getTrendingPerson();
      yield PersonLoaded(personList);
    } on Exception catch (_) {
      yield PersonError();
    }
  }
  
}
