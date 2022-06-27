import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_ui/google_ui.dart';
import 'package:http/http.dart' as http;
import 'package:infobip/new_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infobip Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _posts = [];
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infobip SMS'),
      ),
      body: Center(
        child: ListView.separated(
            separatorBuilder: (context, i) {
              return Divider(color: Colors.blue);
            },
            itemCount: _posts.length,
            itemBuilder: (context, i) {
              final post = _posts[i];
              return ListTile(
                subtitle: Text(post['body']),
                title: Text(post['title']),
                leading: CircleAvatar(
                  child: Icon(Icons.http),
                ),
                trailing: Text("$i"),
                style: ListTileStyle.list,
              );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewTransaction()));
        },
        tooltip: 'Make new Transaction',
        label: Text('Nouvelle Transaction'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green,
        isExtended: true,
        elevation: 20.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeOut,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        iconSize: 26.0,
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text("Home"),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text("Settings"),
              textAlign: TextAlign.center),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  fetchData() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    try {
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body) as List;
      setState(() {
        _posts = jsonData;
      });
    } catch (err) {
      print('Errorrrr : $err');
    }
  }
}
