part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddFavorites extends FavoritesEvent {
  final Character character;

  const AddFavorites({required this.character});

  @override
  List<Object> get props => [character];
}

class RemoveFavorites extends FavoritesEvent {
  final Character character;

  const RemoveFavorites({required this.character});

  @override
  List<Object> get props => [character];
}

class ToggleFavoirite extends FavoritesEvent {
  final Character character;
  const ToggleFavoirite(this.character);
  @override
  List<Object> get props => [character];
}

class SortFavorites extends FavoritesEvent {
  final SortType sortType;

  const SortFavorites(this.sortType);
  @override
  List<Object> get props => [sortType];
}

enum SortType { name, status }
