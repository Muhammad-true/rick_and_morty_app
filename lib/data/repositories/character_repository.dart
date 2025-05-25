import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/core/models/character_response.dart';

class CharacterRepository {
  final _dio = Dio();

  Future<CharacterResponse> getCharacter({int page = 1}) async {
    final response = await _dio.get(
      'https://rickandmortyapi.com/api/character/?page=$page',
    );

    return CharacterResponse.fromJson(response.data);
  }
}
