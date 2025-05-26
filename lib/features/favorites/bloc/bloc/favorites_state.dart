part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Character> favorites;
  final SortType sortType;

  const FavoritesLoaded({
    required this.favorites,
    this.sortType = SortType.name,
  });
  @override
  List<Object> get props => [favorites, sortType];
}

class FavoritesError extends FavoritesState {
  final String error;

  const FavoritesError({required this.error});

  @override
  List<Object> get props => [error];
}
