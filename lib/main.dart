import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/core/models/character.dart';
import 'package:rick_and_morty_app/core/theme/app_theme.dart';
import 'package:rick_and_morty_app/data/repositories/character_repository.dart';
import 'package:rick_and_morty_app/features/character/character.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/view/favorites_page.dart';
import 'package:rick_and_morty_app/features/themeBloc/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  await Hive.openBox<Character>('characterBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => CharacterRepository())],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => ThemeBloc()),
              BlocProvider(
                create: (_) => FavoritesBloc()..add(LoadFavorites()),
              ),
              BlocProvider(
                create:
                    (_) => CharacterBloc(context.read<CharacterRepository>()),
              ),
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themestate) {
                return MaterialApp(
                  title: 'Rick and Morty',
                  themeMode:
                      themestate.isDark ? ThemeMode.dark : ThemeMode.light,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  debugShowCheckedModeBanner: false,
                  home: MainScaffold(),
                );
              },
            ),
          );
        },
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: 'Переключить тему',
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
        ],
      ),
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
