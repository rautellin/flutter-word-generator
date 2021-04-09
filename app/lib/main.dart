import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final _suggestions = <WordPair>[];

    Widget _buildRow(WordPair pair) {
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }

    Widget _buildSuggestions() {
      return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (context, item) {
            if (item.isOdd) return Divider();
            final index = item ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestions[index]);
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Word Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}
