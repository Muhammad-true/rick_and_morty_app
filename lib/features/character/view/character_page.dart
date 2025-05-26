import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/character/character.dart';
import 'package:rick_and_morty_app/features/widgets/CharacterCardWrapper_widget.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(LoadCharacters());
    _scrollController.addListener(_onscroll);
  }

  void _onscroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<CharacterBloc>().add(MoreLoadCharacters());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Рик и Морти')),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CharacterError) {
            return const Center(
              child: Text('Нет интернета и локалный кэш пуст.'),
            );
          } else if (state is CharacterLoaded) {
            final characters = state.character;
            final isLoadingMore = !state.hasReachedEnd;

            return ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemCount: characters.length + (isLoadingMore ? 1 : 0),

              itemBuilder: (context, index) {
                if (index >= characters.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final character = characters[index];
                return CharacterCardWrapperWidget(
                  character: character,
                  icon: Icons.star,
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
