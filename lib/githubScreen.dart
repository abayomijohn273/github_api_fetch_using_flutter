import 'package:flutter/material.dart';
import 'package:github_flutter/githubModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GithubScreen extends StatefulWidget {
  @override
  _GithubScreenState createState() => _GithubScreenState();
}

class _GithubScreenState extends State<GithubScreen> {
  var _items = <GithubModel>[];

  _fetchData() async {
    String url = 'https://api.github.com/orgs/raywenderlich/members';

    http.Response response = await http.get(url);

    final data = json.decode(response.body);

    setState(() {
      for (var datum in data) {
        final member =
            GithubModel(login: datum['login'], avatarUrl: datum['avatar_url']);
        _items.add(member);
      }
    });
  }

//  when componentDidMount
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Widget _buildRow(int i) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        backgroundImage: NetworkImage('${_items[i].avatarUrl}'),
      ),
      title: Text(
        '${_items[i].login}',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github User Data'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider(
              color: Colors.teal[800],
            );
          }

          final newIndex = index ~/ 2;
          return _buildRow(newIndex);
        },
        itemCount: _items.length * 2,
      ),
    );
  }
}
