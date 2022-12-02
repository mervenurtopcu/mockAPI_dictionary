import 'dart:convert';

List<Dictionary> dictionaryFromJson(String str) =>
    List<Dictionary>.from(json.decode(str).map((x) => Dictionary.fromJson(x)));

String dictionaryToJson(Dictionary data) => json.encode(data.toJson());

class Dictionary {
  Dictionary({
    required this.english,
    required this.turkish,
    required this.sentence,
    required this.id,
  });

  String english;
  String turkish;
  String sentence;
  String id;

  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
        english: json["english"],
        turkish: json["turkish"],
        sentence: json["sentence"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "english": english,
        "turkish": turkish,
        "sentence": sentence,
        "id": id,
      };
}
