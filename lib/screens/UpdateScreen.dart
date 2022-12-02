import 'package:flutter/material.dart';
import 'package:my_dictionary/models/dictionary_model.dart';
import 'package:my_dictionary/screens/HomeScreen.dart';
import 'package:my_dictionary/services/dictionary_services.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key, required this.word}) : super(key: key);

  final Dictionary word;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final formKey = GlobalKey<FormState>();
  late String english, turkish, sentence;
  late Dictionary word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.word.english,style: const TextStyle(fontFamily: 'Combo',fontWeight: FontWeight.bold)),
          elevation: 15,
          backgroundColor: Colors.orange,
          shadowColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'It cannot be empty';
                      } else {
                        return null;
                      }
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    english = newValue!;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Ex: ${widget.word.english}",
                      labelText: "English*",
                      labelStyle: const TextStyle(color: Colors.orange)),
                  style: const TextStyle(
                    backgroundColor: Colors.white54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'It cannot be empty';
                      } else {
                        return null;
                      }
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    turkish = newValue!;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Ex: ${widget.word.turkish}",
                      labelText: "Turkish*",
                      labelStyle: const TextStyle(color: Colors.orange)),
                  style: const TextStyle(
                    backgroundColor: Colors.white54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'It cannot be empty';
                      } else {
                        return null;
                      }
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    sentence = newValue!;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Ex: ${widget.word.sentence}",
                      labelText: "Sentence*",
                      labelStyle: const TextStyle(color: Colors.orange)),
                  style: const TextStyle(
                    backgroundColor: Colors.white54,
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final bool? icerikUygunMu =
                        formKey.currentState?.validate();
                    if (icerikUygunMu == true) {
                      formKey.currentState?.save();
                      deleteWord(widget.word.id, english, turkish, sentence);

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.only(
                        left: 150, right: 150, top: 10, bottom: 10),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                    shadowColor: Colors.black,
                  ),
                  child: const Text("SAVE"),
                ),
              ),
            ]),
          ),
        ));
  }

  void deleteWord(String id, String english, String turkish, String sentence) {
    DictionaryServices().updateWord(id, english, turkish, sentence);
  }
}
