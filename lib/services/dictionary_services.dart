import 'dart:convert';
import 'dart:developer';
import 'package:my_dictionary/models/dictionary_model.dart';
import 'package:http/http.dart 'as http;

class DictionaryServices{

  // Future<List<Dictionary>?> getDictionary() async {
  //  final response = await http.get(Uri.parse('https://6380c4968efcfcedac0e72fe.mockapi.io/words'));
  //  if(response.statusCode == 200){
  //    List jsonResponse = json.decode(response.body);
  //    return jsonResponse.map((dictionary) => dictionaryFromJson(dictionary)).toList();
  //  }else{
  //    throw Exception('Failed to load Data');
  //  }
  // }
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

  Future<Dictionary> createWord(String english,String turkish, String sentence) async {
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
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Dictionary.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create word.');
    }
  }
  Future<Dictionary> updateWord(String id,String english,String turkish, String sentence) async {
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
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Dictionary.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update word.');
    }
  }

}