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


}