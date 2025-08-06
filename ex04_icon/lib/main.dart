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
      home: const MyHomePage(title: 'Ex04 Icon'),
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
      body: const Row(    // 아이콘은 상수 이기때문에 아래 모두 상수 처리하지 말고 
                          // 여기서 상수 처리하면 됨.
        children: <Widget>[ // 우리가 만들고 자동으로 완성된 코드에는 앞에 있는 <Widget>이 없다.
                            // 없어도 된다는 뜻.
          Icon(
            Icons.camera_alt,
            color: Colors.red,
            size: 35.0,
          ),
          Icon(
            Icons.cancel,
            color: Colors.orange,
            size: 35.0,
          ),
          Icon(
            Icons.add_circle,
            color: Colors.yellow,
            size: 35.0
          ),
          Icon(
            Icons.delete,
            color: Colors.green,
            size: 35.0
          ),
          Icon(
            Icons.notifications,
            color: Colors.blue,
            size: 35.0
          ),
          Icon(
            Icons.settings,
            color: Colors.indigo,
            size: 35.0
          ),
          Icon(
            Icons.star,
            color: Colors.purple,
            size: 35.0
          ),
          Icon(
            Icons.star_border,
            color: Colors.purple,
            size: 35.0
          ),
          Icon(
            Icons.sync,
            color: Colors.black,
            size: 35.0
          ),
          Icon(
           Icons.fingerprint,
           color: Colors.black,
           size: 35.0
          ),
        ],
      ),
    );
  }
}
