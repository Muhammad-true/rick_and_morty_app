import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/models/character.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesLoaded(favorites: [])) {
    on<LoadFavorites>(_onLoad);
    on<AddFavorites>(_onAdd);
    on<RemoveFavorites>(_onRemove);
    on<SortFavorites>(_onSortFavorites);
  }

  Future<void> _onLoad(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('favorites') ?? [];
    final characters =
        list.map((item) => Character.fromJson(json.decode(item))).toList();
    emit(FavoritesLoaded(favorites: characters));
  }

  Future<void> _onAdd(AddFavorites event, Emitter<FavoritesState> emit) async {
    if (state is! FavoritesLoaded) return;
    final curren = (state as FavoritesLoaded).favorites;
    final upDatet = List<Character>.from(curren)..add(event.character);
    await _save(upDatet);
    emit(FavoritesLoaded(favorites: upDatet));
  }

  Future<void> _onRemove(
    RemoveFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is! FavoritesLoaded) return;
    final current = (state as FavoritesLoaded).favorites;
    final updated = List<Character>.from(current)
      ..removeWhere((i) => i.id == event.character.id);
    await _save(updated);
    emit(FavoritesLoaded(favorites: updated));
  }

  Future<void> _save(List<Character> character) async {
    final pref = await SharedPreferences.getInstance();
    final jsonList =
        character
            .map(
              (i) => json.encode({
                'id': i.id,
                'name': i.name,
                'status': i.status,
                'species': i.species,
                'image': i.image,
                'location': {'name': i.location},
              }),
            )
            .toList();
    await pref.setStringList('favorites', jsonList);
  }

  FutureOr<void> _onSortFavorites(
    SortFavorites event,
    Emitter<FavoritesState> emit,
  ) {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      final sorted = [...currentState.favorites];
      switch (event.sortType) {
        case SortType.name:
          sorted.sort((a, b) => a.name.compareTo(b.name));
          break;
        case (SortType.status):
          sorted.sort((a, b) => a.status.compareTo(b.status));
          break;
      }
      emit(FavoritesLoaded(favorites: sorted, sortType: event.sortType));
    }
  }
}
