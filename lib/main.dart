import 'package:flutter/material.dart';
import 'package:github_flutter/githubScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GithubScreen(),
    );
  }
}
