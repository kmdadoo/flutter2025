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
      home: const MyHomePage(title: 'Ex20 Material Banner'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text(
                'Banner',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                // SnackBar와 다른 점 : duration 옵션이 없다.
                // 스낵바는 화면위에 플로팅되지만, 머터리얼배너는
                // 출력시 다른 위젯을 밀어낸다.
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    // 출력할 메세지
                    content: const Text('안녕하세요, 오른쪽 닫기를 누루세요!'),
                    // 좌측 아이콘
                    leading: const Icon(Icons.info),  
                    // 배경색
                    backgroundColor: Colors.yellow,  
                    actions: [ 
                      TextButton(
                        child: const Text('닫기'),
                        // 머티리얼 배너를 숨김처리한다.
                        onPressed: () => ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
