import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};

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

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: TextStyle(fontSize: 16.0),
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Generator'),
        actions: [
          IconButton(icon: Icon(Icons.line_weight), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<RandomWords> createState() => _RandomWordsState();
}
