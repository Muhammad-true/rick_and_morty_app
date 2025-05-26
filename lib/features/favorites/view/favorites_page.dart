import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/widgets/CharacterCardWrapper_widget.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
        actions: [
          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoaded) {
                return PopupMenuButton<SortType>(
                  icon: Icon(Icons.sort),
                  onSelected: (type) {
                    context.read<FavoritesBloc>().add(SortFavorites(type));
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: SortType.name,
                          child: Text('Сортировка по имени'),
                        ),
                        PopupMenuItem(
                          value: SortType.name,
                          child: Text('Сортировка по статусу'),
                        ),
                      ],
                );
              }
              return Container();
            },
          ),
        ],
      ),

      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return Center(child: Text('Пока ничего нет в избранном'));
            }

            return ListView.separated(
              itemCount: state.favorites.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final character = state.favorites[i];
                return CharacterCardWrapperWidget(
                  character: character,
                  icon: Icons.delete,
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
