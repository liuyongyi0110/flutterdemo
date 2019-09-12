import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();

    // TODO: implement build
    return MaterialApp(
      title: 'Welcome Flutter',
      theme: ThemeData(primaryColor: Colors.white),
      debugShowCheckedModeBanner: false, //不显示debug tag
      home: MyAppStateful(),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RandomWordsState();
  }
}

class RandomWordsState extends State<MyAppStateful> {
  final suggestion = <WordPair>[];
  final save = Set<WordPair>();
  final biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair = new WordPair.random();
//    return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator',style: TextStyle(fontFamily: 'Chilanka')),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: pushSaved,
          ),
        ],
      ),
      body: buildSuggestion(),
    );
  }

  void pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final titles = save.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: biggerFont,
                  strutStyle: StrutStyle(fontFamily: 'Chilanka'),
                ),
              );
            },
          );
          final divided =
              ListTile.divideTiles(tiles: titles, context: context).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions',style: TextStyle(fontFamily: 'Chilanka'),),
            ),
            body: ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }

  Widget buildSuggestion() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider();
          }

          final index = i ~/ 2;
          if (index >= suggestion.length) {
            suggestion.addAll(generateWordPairs().take(10));
          }
          return buildRow(suggestion[index]);
        });
  }

  Widget buildRow(WordPair wordPair) {
    final alreadySaved = save.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: biggerFont,
        strutStyle: StrutStyle(fontFamily: 'Chilanka'),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            save.remove(wordPair);
          } else {
            save.add(wordPair);
          }
        });
      },
    );
  }
}
