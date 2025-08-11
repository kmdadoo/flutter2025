import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Ex25 Scroll View'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(    // #3
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.all(10.0),
          // 아래 가로,세로 부분을 주석처리하면 화면을 꽉 채우게 된다.
          width: 300,   // 크기를 지정하지 않으면 부모의 크기
          height: 500,    // 크기를 지정하지 않으면 자식의 크기
          color: Colors.cyan, 
          alignment: Alignment.topLeft,

          child: SingleChildScrollView(     // #2
            // 스크롤 방향을 수직방향으로 설정
            scrollDirection: Axis.vertical, // #2-1 
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center, // 의미 없다
              children: [
                // #1
                // 화면을 벗어날 정도의 컨테이너를 추가한다.
                Container(
                  width: double.infinity, 
                  height: 200,
                  alignment: Alignment.center,
                  color: Colors.amber[700],
                  child: const Text('Entry a', style: TextStyle(fontSize: 30)),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  alignment: Alignment.center,
                  color: Colors.amber[500],
                  child: const Text('Entry b', style: TextStyle(fontSize: 30)),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  alignment: Alignment.center,
                  color: Colors.amber[300],
                  child: const Text('Entry c', style: TextStyle(fontSize: 30)),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  alignment: Alignment.center,
                  color: Colors.amber[100],
                  child: const Text('Entry d', style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
