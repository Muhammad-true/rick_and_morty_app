import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/theme/app_theme.dart';
import 'package:rick_and_morty_app/data/repositories/character_repository.dart';
import 'package:rick_and_morty_app/features/character/character.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/view/favorites_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => CharacterRepository()),
        BlocProvider(create: (_) => FavoritesBloc()..add(LoadFavorites())),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: MainScaffold(),
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int index = 0;
  final pages = const [CharacterPage(), FavoritesPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Персонажи'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Избранное'),
        ],
      ),
    );
  }
}
