import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:my_dictionary/screens/AddWordScreen.dart';
import 'package:my_dictionary/services/dictionary_services.dart';
import '../models/dictionary_model.dart';
import 'DetailScreen.dart';

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
    //
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
    const transitionType = ContainerTransitionType.fade;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dictionary"),
            elevation: 15,
            backgroundColor: Colors.orange,
            shadowColor: Colors.black,
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
                            trailing: const Icon(Icons.keyboard_arrow_right),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(word: dictionary[index]),
                                ),
                              );
                            },
                          );
                        },
                      );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        floatingActionButton: const CustomFABWidget(transitionType: transitionType,),
        ),
    );

  }
}

const double fabSize = 56;

class CustomFABWidget extends StatelessWidget {
  final ContainerTransitionType transitionType;

  const CustomFABWidget({super.key,
    required this.transitionType,
  });

  @override
  Widget build(BuildContext context) => OpenContainer(
    transitionDuration: const Duration(seconds: 2),
    openBuilder: (context, _) => const AddWordScreen(),
    closedShape: const CircleBorder(),
    closedColor: Colors.orangeAccent,
    closedBuilder: (context, openContainer) => Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        //color: Theme.of(context).primaryColor,
        color: Colors.orange,
      ),
      height: fabSize,
      width: fabSize,
      child: const Icon(Icons.add, color: Colors.white),
    ),
  );
}