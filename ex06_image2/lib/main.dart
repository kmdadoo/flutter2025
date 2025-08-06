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
      home: const MyHomePage(title: 'Ex06 Image #2'),
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
      body: Column(  // 열이 중심이므로 세로 방향으로 나열
        // 메인 방향으로 가운데 정렬하기, 여기서는 세로(주축)
        mainAxisAlignment: MainAxisAlignment.center,
        // 여기서는 가로방향(교차축)으로 처음 정렬하기
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
          'assets/images/900.png',
          // 위젯의 크기에 맞춰 이미지를 늘리거나 줄여서 빈 공간 없이 채웁니다. 
          // 이 과정에서 이미지의 원래 비율이 깨질 수 있습니다.
          fit: BoxFit.fill,     // 사이즈만 지정하면 자동 설정됨.
          alignment: Alignment.topLeft, // 이미지가 위젯 공간에 배치
          width: 120.0,         // 원래 사이즈가 비율대로 줄어듬.
          ),
          const SizedBox(height: 5,),   // 간격을 주기위한 것.
          Image.asset(
            'assets/images/900.png',
            // 위젯의 크기에 맞추되, 이미지의 가로세로 비율을 유지하면서 
            // 빈 공간 없이 채웁니다. 위젯의 크기보다 큰 부분은 잘려나갑니다.
            fit:BoxFit.cover,     // 큰 쪽에 맞춤. 작은 쪽 잘림
            alignment: Alignment.centerLeft,
            width: 150.0,
            height: 100.0,
          ),
          const SizedBox(height: 5,),
          Image.asset(
            'assets/images/900.png',
            fit:BoxFit.fill,   // 사이즈만 지정하면 자동 설정됨  (위아래가 작아짐) 
            alignment: Alignment.centerLeft,
            width: 150.0,
            height: 100.0,
          ),
          const SizedBox(height: 5,),
          Image.asset(
            'assets/images/900.png',
            // 위젯의 크기에 맞추되, 이미지의 가로세로 비율을 유지하면서 위젯 공간 
            // 안에 이미지를 모두 표시합니다. 남는 공간에는 여백이 생길 수 있습니다. 
            fit:BoxFit.contain,     // 작은 쪽에 맞춤. 큰 쪽에 여백 남음
            alignment: Alignment.topLeft,
            // 사이즈를 둘다 주면 fill 이 아니고 contain 이 된다.
            width: 150.0,  
            height: 100.0,
          ),
          const SizedBox(height: 5,),
          Image.asset(
            'assets/images/900.png',
            // fit:BoxFit.contain,
            alignment: Alignment.topLeft,  
            width: 150.0,  
            height: 100.0,  
          ),
          const SizedBox(height: 5,),
          Image.asset(
            'assets/images/900.png',
            // 이미지의 원래 크기를 그대로 유지합니다. 
            // 위젯의 크기보다 크면 잘려나가고, 작으면 여백이 생깁니다.
            fit:BoxFit.none,    // 원래 크기. 화면 배율 영향 안 받음.
            alignment: Alignment.topLeft, // 오른쪽, 아래쪽 잘림
            width: 320.0,   // 옵션은 한줄에 하나씩 하는 것이 수정할 대 편함.
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
