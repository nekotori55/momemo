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
  String content = "Write something!";

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
            ? Markdown(data: content, selectable: true)
            : Column(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: .multiline,
                      maxLines: null,
                      expands: true,
                      controller: _textEditingController,
                    ),
                  ),
                ],
              ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_editMode) {
              content = _textEditingController.text;
            } else {
              _textEditingController.text = content;
            }
            _editMode = !_editMode;
          });
        },
        child: Icon(!_editMode ? Icons.edit_outlined : Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
