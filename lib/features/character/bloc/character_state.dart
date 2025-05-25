part of 'character_bloc.dart';

sealed class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> character;
  final int currentPage;
  final bool hasReachedEnd;

  const CharacterLoaded({
    required this.character,
    required this.currentPage,
    required this.hasReachedEnd,
  });

  CharacterLoaded copyWith({
    List<Character>? character,
    int? currentPage,
    bool? hasReachedEnd,
  }) {
    return CharacterLoaded(
      character: character ?? this.character,
      currentPage: currentPage ?? this.currentPage,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object> get props => [character, currentPage, hasReachedEnd];
}

class CharacterError extends CharacterState {
  final String error;

  const CharacterError({required this.error});
}
