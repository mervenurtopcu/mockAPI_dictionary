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
  late Future<List<Dictionary>> listDictionary;

  @override
  void initState() {
    super.initState();
    listDictionary = DictionaryServices().getDictionary();
  }

  @override
  Widget build(BuildContext context) {
    const transitionType = ContainerTransitionType.fade;
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Center(
                child: Text("Dictionary",
                    style: TextStyle(
                        fontFamily: 'Combo',
                        fontSize: 28,
                        fontWeight: FontWeight.bold))),
            elevation: 15,
            backgroundColor: Colors.orange,
            shadowColor: Colors.black,
          ),
          body: FutureBuilder<List<Dictionary>>(
            future: listDictionary,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isEmpty
                    ? const Center(
                        child: Text(
                            "The words are listed here. Please add words.",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                    colors: [
                                      Colors.orangeAccent,
                                      Colors.yellow
                                    ])),
                            margin: const EdgeInsets.all(3.0),
                            child: ListTile(
                              title: Text(
                                snapshot.data![index].english,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                    letterSpacing: 1.0),
                              ),
                              trailing: const Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(word: snapshot.data![index]),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
          floatingActionButton: const CustomFABWidget(
            transitionType: transitionType,
          ),
        ),
      ),
    );
  }
}

const double fabSize = 56;

class CustomFABWidget extends StatelessWidget {
  final ContainerTransitionType transitionType;

  const CustomFABWidget({
    super.key,
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
            color: Colors.orange,
          ),
          height: fabSize,
          width: fabSize,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
}
