import 'dart:convert';
import 'package:my_dictionary/models/dictionary_model.dart';
import 'package:http/http.dart ' as http;

class DictionaryServices {
  //List all the words

  Future<List<Dictionary>> getDictionary() async {
    final response = await http.get(Uri.parse('https://6380c4968efcfcedac0e72fe.mockapi.io/words'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Dictionary>((json) => Dictionary.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load words');
    }
  }
//Create a new word
  Future<Dictionary> createWord(
      String english, String turkish, String sentence) async {
    final response = await http.post(
      Uri.parse('https://6380c4968efcfcedac0e72fe.mockapi.io/words'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'english': english,
        'turkish': turkish,
        'sentence': sentence,
      }),
    );

    if (response.statusCode == 201) {
      return Dictionary.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create word.');
    }
  }
//Update an existing word
  Future<Dictionary> updateWord(
      String id, String english, String turkish, String sentence) async {
    final response = await http.put(
      Uri.parse('https://6380c4968efcfcedac0e72fe.mockapi.io/words/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'english': english,
        'turkish': turkish,
        'sentence': sentence,
      }),
    );

    if (response.statusCode == 200) {
      return Dictionary.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update word.');
    }
  }
// Delete existing word by id
  Future<Dictionary> deleteWord(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://6380c4968efcfcedac0e72fe.mockapi.io/words/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Dictionary.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete word.');
    }
  }
}
