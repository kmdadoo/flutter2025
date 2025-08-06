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
      // home: const Text('Flutter Demo Home Page'),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,  // 현재 테마의 반전 색상을 적용
          title: const Text('Example Title'),
          // const 로 상수 정의하면 화면을 더이상 그리지 않음. const가 붙으면 상태가 없는 애
          // 즉 정보가 변하지 않는 애. 속도가 빨라짐. 나중에 바꿀려면 const 붙이지 않음. 자동
          // 완성에서 알려주는 방법이 최선은 아님. 모바일은 초당 60프레임이 나옴. 화면이 60번 
          // 깜박일때 까지 화면이 변하지 않으면 밧데리가 절약이 됨.
        ),
        body: const Center(
          child: Text('Example Body',
            style: TextStyle(fontSize: 30),
          ),
        )
      ),
    );
  }
}

