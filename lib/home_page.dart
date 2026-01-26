import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  static const String markdownExampleString = """
  # Sample Markdown Text

  boom
    
  """;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String markdownSource = "Write something!";

  bool _editMode = false;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("momemo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: !_editMode
            ? Markdown(
                data: markdownSource,
                selectable: true,

                padding: .symmetric(vertical: 12.0, horizontal: 16),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: .multiline,
                        maxLines: null,
                        expands: true,
                        controller: _textEditingController,
                        style: TextStyle(fontSize: 13.5),
                      ),
                    ),
                  ],
                ),
              ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_editMode) {
              markdownSource = _textEditingController.text;
            } else {
              _textEditingController.text = markdownSource;
            }
            _editMode = !_editMode;
          });
        },
        child: Icon(!_editMode ? Icons.edit_outlined : Icons.preview),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
