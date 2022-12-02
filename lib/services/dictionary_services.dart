import 'dart:convert';
import 'dart:developer';
import 'package:my_dictionary/models/dictionary_model.dart';
import 'package:http/http.dart ' as http;

class DictionaryServices {
  Future<List<Dictionary>?> getDictionary() async {
    try {
      var url = Uri.parse('https://6380c4968efcfcedac0e72fe.mockapi.io/words');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Dictionary> model = dictionaryFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

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
