import 'package:flutter/material.dart';
import 'package:my_dictionary/models/dictionary_model.dart';
import 'package:my_dictionary/screens/HomeScreen.dart';
import 'package:my_dictionary/screens/UpdateScreen.dart';
import 'package:my_dictionary/services/dictionary_services.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.word}) : super(key: key);

  final Dictionary word;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                spreadRadius: 0.5,
                                offset: Offset(5, 5),
                              )
                            ],
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.orange, Colors.yellow])),
                        child: Center(
                          child: Text(widget.word.english,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                              textAlign: TextAlign.center),
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        // constraints: BoxConstraints(maxHeight: 200),
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                spreadRadius: 0.5,
                                offset: Offset(5, 5),
                              )
                            ],
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.yellow, Colors.orange])),
                        child: Center(
                          child: Text(widget.word.turkish,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                              textAlign: TextAlign.center),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 0.5,
                        offset: Offset(5, 5),
                      )
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.orange, Colors.yellow, Colors.orange])),
                child: Center(
                  child: Text(widget.word.sentence,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                      textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdateScreen(
                            word: widget.word,
                          ))),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    fixedSize: const Size(250, 30),
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    shadowColor: Colors.black,
                  ),
                  child: const Text(
                    "EDIT  ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _showAlertDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    fixedSize: const Size(250, 30),
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    shadowColor: Colors.black,
                  ),
                  child: const Text(
                    "DELETE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: const Text('Delete word'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to delete this word?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                  setState(() {
                    DictionaryServices().deleteWord(widget.word.id);
                    Navigator.pushReplacement(context,MaterialPageRoute(
                             builder: (context) => const HomeScreen()));
                  });
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
