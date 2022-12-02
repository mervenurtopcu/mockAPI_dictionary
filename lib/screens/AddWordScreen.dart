import 'package:flutter/material.dart';
import 'package:my_dictionary/screens/HomeScreen.dart';
import 'package:my_dictionary/services/dictionary_services.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({Key? key}) : super(key: key);

  @override
  State<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  late String english, turkish, sentence;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD WORD',
          style: TextStyle(fontFamily: 'Combo', fontWeight: FontWeight.bold),
        ),
        elevation: 15,
        backgroundColor: Colors.orange,
        shadowColor: Colors.black,
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ex: success",
                    labelText: "English*",
                    labelStyle: TextStyle(color: Colors.orangeAccent)),
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ex: başarı",
                    labelText: "Turkish*",
                    labelStyle: TextStyle(color: Colors.orangeAccent)),
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ex: Success is a key for everything.",
                    labelText: "Sentence*",
                    labelStyle: TextStyle(color: Colors.orangeAccent)),
                style: const TextStyle(
                  backgroundColor: Colors.white54,
                ),
              ),
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                final bool? contentIsSuitable =
                    formKey.currentState?.validate();
                if (contentIsSuitable == true) {
                  formKey.currentState?.save();
                  DictionaryServices().createWord(english, turkish, sentence);
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
                ),
                shadowColor: Colors.black,
              ),
              child: const Text("Add"),
            )),
          ],
        ),
      ),
    );
  }
}
