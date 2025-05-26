//можно было и через блок вообще по хорошему делать или узнать в избранном или нет ,пока так..
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/models/character.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/widgets/charactercard_widgets.dart';

class CharacterCardWrapperWidget extends StatelessWidget {
  final Character character;
  final IconData icon;
  const CharacterCardWrapperWidget({
    super.key,
    required this.character,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select<FavoritesBloc, bool>((bloc) {
      final state = bloc.state;
      if (state is FavoritesLoaded) {
        return state.favorites.any((c) => c.id == character.id);
      }
      return false;
    });

    return CharactercardWidgets(
      character: character,
      isFavorite: isFavorite,
      icon: icon,
      onFavoriteToggle: () {
        final favoritesBloc = context.read<FavoritesBloc>();
        if (isFavorite) {
          favoritesBloc.add(RemoveFavorites(character: character));
        } else {
          favoritesBloc.add(AddFavorites(character: character));
        }
      },
    );
  }
}
