import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/core/models/character.dart';
import 'package:rick_and_morty_app/core/models/character_response.dart';

class CharacterRepository {
  //тут по хорошему надо была передать dio через конструктор))
  final _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ),
  );

  final Box<Character> _box = Hive.box<Character>('characterBox');

  Future<CharacterResponse> getCharacter({int page = 1}) async {
    try {
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character/?page=$page',
      );
      final characterResponse = CharacterResponse.fromJson(response.data);

      for (final chareacter in characterResponse.results) {
        if (_box.containsKey(chareacter.id)) {
          continue;
        }
        final locaImagePath = await _downloadAndSaveImage(
          chareacter.image,
          chareacter.id,
        );
        final localCharacter = Character(
          id: chareacter.id,
          name: chareacter.name,
          status: chareacter.status,
          species: chareacter.species,
          image: locaImagePath,
          location: chareacter.location,
        );
        _box.put(chareacter.id, localCharacter);
      }
      return CharacterResponse(
        info: characterResponse.info,
        results: _box.values.toList(),
      );
    } on DioException catch (e) {
      if (e.error is SocketException ||
          e.type == DioExceptionType.connectionTimeout) {
        if (_box.isEmpty) {
          throw Exception('Нет интернета и локалный кэш пуст.');
        }
        return CharacterResponse(
          info: PageInfo(count: _box.length, pages: 1, next: null, prev: null),
          results: _box.values.toList(),
        );
      }
      rethrow;
    }
  }

  Future<String> _downloadAndSaveImage(String url, int characterId) async {
    final respose = await Dio().get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/character_$characterId.jpg');
    await file.writeAsBytes(respose.data!);
    return file.path;
  }
}
