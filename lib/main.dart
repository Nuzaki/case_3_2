import 'dart:async';
import 'package:case_32/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const JsonScreen());

class JsonScreen extends StatefulWidget {
  const JsonScreen({Key? key}) : super(key: key);

  @override
  _JsonScreenState createState() => _JsonScreenState();
}

class _JsonScreenState extends State<JsonScreen> {
  late Future<Post> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Center(
            child: FutureBuilder<Post>(
              future: futurePost,
              builder: (context, snapshot) {
                var data = snapshot.data;
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'USER ID:${data!.userId.toString()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Roboto', fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'USER ID:${data.id.toString()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Roboto', fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'ОПИСАНИЕ на латыни:\n${data.title.toString()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Roboto', fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<Post> fetchPost() async {
    final map = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/Posts/1'));

    if (map.statusCode == 200) {
      return Post.fromJson(map.body);
    } else {
      throw Exception('Failed to load Post');
    }
  }
}
