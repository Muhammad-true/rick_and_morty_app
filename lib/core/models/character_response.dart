import 'package:rick_and_morty_app/core/models/character.dart';

class CharacterResponse {
  final PageInfo info;
  final List<Character> results;

  CharacterResponse({required this.info, required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    return CharacterResponse(
      info: PageInfo.fromJson(json['info']),
      results: List<Character>.from(
        json['results'].map((x) => Character.fromJson(x)),
      ),
    );
  }
}

class PageInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  PageInfo({required this.count, required this.pages, this.next, this.prev});

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}
