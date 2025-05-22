import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/models/character.dart';
import 'package:rick_and_morty_app/data/repositories/character_repository.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository;
  CharacterBloc(this.repository) : super(CharacterInitial()) {
    //получение характер лист из репозитория
    on<LoadCharacters>((event, emit) async {
      //показываем загрузку
      emit(CharacterLoading());
      try {
        final characters = await repository.getCharacter();
        emit(CharacterLoaded(character: characters));
      } catch (e) {
        emit(CharacterError(error: 'Данные не загрузились'));
      }
    });
  }
}
