import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/bloc/favorites_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Избранное')),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return Center(child: Text('Пока ничего нет в избранном'));
            }

            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, i) {
                final character = state.favorites[i];
                return ListTile(
                  leading: Image.network(
                    character.image,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(character.name),
                  subtitle: Text('${character.status}-${character.species}'),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<FavoritesBloc>().add(
                        RemoveFavorites(character: character),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
