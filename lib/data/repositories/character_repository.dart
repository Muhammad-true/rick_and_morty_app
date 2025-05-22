import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/core/models/character.dart';

class CharacterRepository {
  final _dio = Dio();

  Future<List<Character>> getCharacter({int page = 1}) async {
    final response = await _dio.get(
      'https://rickandmortyapi.com/api/character/?page=$page',
    );
    final results = response.data['results'] as List;
    return results.map((json) => Character.fromJson(json)).toList();
  }
}
