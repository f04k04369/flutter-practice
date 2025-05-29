import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_page.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _counter2 = 1;
  String _text = '';
  String text = '';
  String sendTxt = '';

  List<String> favorite = ["ガンダム", "ドム", "ザク", "ジオング", "EZ-8"];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _twice() {
    setState(() {
      _counter2 = _counter2 * 2;
    });
  }

  Future<void> getRepos() async {
    // APIでgetするので非同期処理
    final url = Uri.https('api.github.com', 'users/f04k04369/repos');
    final response = await http.get(url);
    print(response.body);
    setState(() {
      text = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(sendTxt),
            const Text('足し算'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('2倍'),
            Text(
              '$_counter2',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _text = value;
                });
              },
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  text = _text;
                });
              },
              icon: Icon(Icons.arrow_downward),
            ),
            Text(text),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _twice,
            tooltip: 'twice',
            child: const Icon(Icons.heart_broken),
          ),
          FloatingActionButton(
            onPressed: getRepos,
            tooltip: 'api',
            child: const Icon(Icons.heart_broken),
          ),
          FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => PostPage(),
                ),
              );

              if (result != null && result.isNotEmpty) {
                setState(() {
                  sendTxt = result;
                });
              }
            },
            tooltip: 'write',
            child: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}

