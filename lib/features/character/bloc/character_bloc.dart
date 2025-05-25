import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/models/character.dart';
import 'package:rick_and_morty_app/data/repositories/character_repository.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository;
  CharacterBloc(this.repository) : super(CharacterInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    //получение характер лист из репозитория
    on<MoreLoadCharacters>(_onMoreLoadCharacters);
  }

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    emit(CharacterLoading());
    try {
      final response = await repository.getCharacter(page: 1);
      emit(
        CharacterLoaded(
          character: response.results,
          currentPage: 1,
          hasReachedEnd: response.info.next == null,
        ),
      );
    } catch (e) {
      emit(CharacterError(error: 'ошибка блока'));
    }
  }

  Future<void> _onMoreLoadCharacters(
    MoreLoadCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    if (state is! CharacterLoaded) return;
    final currentState = state as CharacterLoaded;
    if (currentState.hasReachedEnd) return;
    try {
      final nextPage = currentState.currentPage + 1;
      final response = await repository.getCharacter(page: nextPage);
      emit(
        currentState.copyWith(
          character: [...currentState.character, ...response.results],
          currentPage: nextPage,
          hasReachedEnd: response.info.next == null,
        ),
      );
    } catch (e) {
      emit(CharacterError(error: 'ошибка у блока'));
    }
  }
}
