

import 'package:flutter/material.dart';
import 'api/models/model.dart';
import 'api/api.dart';
import 'screens/post_add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late List<posts>? allpost;
  @override
  void initState() {
    fatchposts().then((value) => allpost = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("API"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: FutureBuilder(
            future: fatchposts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: allpost?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.cyan,
                       
                            child: ListTile(
                              title: Text(allpost![index].id.toString()),
                            ),
                          ),
                          Card(
                            color: Colors.tealAccent,
                            child: ListTile(
                              title: Text(allpost![index].date.toString()),
                            ),
                          ),
                          Card(
                            color: Colors.blue[200],
                            child: ListTile(
                              title: Text(allpost![index].rendered.toString()),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyWidget(),
              ),
            );
          },
        ),
      ),
    );
  }
}
