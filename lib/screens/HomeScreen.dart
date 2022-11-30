import 'package:flutter/material.dart';
import 'package:adv_fab/adv_fab.dart';
import 'package:my_dictionary/services/dictionary_services.dart';

import '../models/dictionary_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DictionaryServices dicServices = DictionaryServices();
  late Future<List<Dictionary>> listDictionary;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDictionary = _getDictionary();

  }

  Future<List<Dictionary>> _getDictionary() async {
    List<Dictionary> dictionary = (await DictionaryServices().getDictionary())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    return Future.value(dictionary);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dictionary"),
        ),
        body: FutureBuilder<List<Dictionary>>(
            future: listDictionary,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Dictionary> dictionary = snapshot.data!;
                return dictionary.isEmpty
                    ? const Center(
                        child: Text(
                            "The words are listed here. Please add words.",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      )
                    : ListView.builder(
                        itemCount: dictionary.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(dictionary[index].english),
                          );
                        },
                      );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
    );

  }
}
