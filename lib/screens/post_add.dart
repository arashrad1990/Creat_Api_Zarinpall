import 'package:flutter/material.dart';
import 'package:shop_rad/api/api.dart';
import 'package:shop_rad/api/models/model.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Send Post"),
        ),
        body: page_text(),
      ),
    );
  }
}

class page_text extends StatefulWidget {
  const page_text({super.key});

  @override
  State<page_text> createState() => _page_textState();
}

class _page_textState extends State<page_text> {
  Future<posts>? posttext;
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
// ignore: unused_element
  void _clear() {
    _content.clear();
    _title.clear();
  }

  // ignore: unused_element
  FutureBuilder<posts> _builder() {
    return FutureBuilder(
      future: posttext,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Text("Data Send");
        } else if (snapshot.hasError) {
          return Text("${snapshot.error.toString()}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            controller: _title,
          ),
          TextField(
            controller: _content,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                posttext = sendpost(_title.text,_content.text);
              });
              _clear();
            },
            child: Text("Send Post"),
          ),
          Center(
            child: posttext == null ? const Text("") : _builder(),
          ),
        ],
      ),
    );
  }
}
