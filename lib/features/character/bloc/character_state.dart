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

  const CharacterLoaded({required this.character});

  @override
  List<Object> get props => [character];
}

class CharacterError extends CharacterState {
  final String error;

  const CharacterError({required this.error});
}
