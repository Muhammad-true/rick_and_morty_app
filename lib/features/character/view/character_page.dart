import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/character/character.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/bloc/favorites_bloc.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              CharacterBloc(RepositoryProvider.of(context))
                ..add(LoadCharacters()),

      child: Scaffold(
        appBar: AppBar(title: const Text('рик и морти')),
        body: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CharacterLoaded) {
              return ListView.builder(
                itemCount: state.character.length,
                itemBuilder: (context, index) {
                  final character = state.character[index];
                  return BlocBuilder<FavoritesBloc, FavoritesState>(
                    builder: (context, favstate) {
                      final isFavorite =
                          favstate is FavoritesLoaded &&
                          favstate.favorites.any((c) => c.id == character.id);
                      return ListTile(
                        leading: Image.network(
                          character.image,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(character.name),
                        subtitle: Text(
                          '${character.status}-${character.species}',
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            final bloc = context.read<FavoritesBloc>();
                            if (isFavorite) {
                              bloc.add(RemoveFavorites(character: character));
                            } else {
                              bloc.add(AddFavorites(character: character));
                            }
                          },
                          icon: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: isFavorite ? Colors.amber : null,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is CharacterError) {
              return const Center(child: Text('Ошибка загрузки'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
