import 'package:flutter/material.dart';

// 앱 시작 부분
void main() {
  // runApp() 함수를 호출해 앱의 루트 위젯인 MyApp을 실행
  runApp(const MyApp());
}

// 시작 클래스. 머티리얼 디자인 앱(MaterialApp) 생성.
// MyApp은 상태가 변하지 않는 위젯이라 StatelessWidget을 상속받습니다.
// 앱이 실행된 이후에는 이 위젯 내부의 데이터가 변하지 않습니다.
class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Material 디자인을 적용한 앱을 만들 때 사용
      title: 'Flutter Demo',
      // 앱의 색상, 폰트 등을 전역적으로 설정합니다. 여기서는 deepPurple 색상을 앱의 기본 색상으로 지정합니다.
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // 앱이 시작될 때 가장 먼저 보여줄 화면 위젯을 지정합니다. 여기서는 MyHomePage 위젯을 사용합니다.
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// 시작 클래스가 표시되는 클래스. 카운터 앱 화면. 실제 화면을 구성하는 위젯
class MyHomePage extends StatefulWidget { // 화면의 상태가 변하기 때문에 StatefulWidget을 상속. 정보가 변함
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 위 MyHomePage 클래스의 상태를 나타내는 State클래스 : StatefulWidget은 State 클래스와 짝을 이루며, 실제 위젯의 상태와 UI를 관리하는 역할을 합니다.
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;  // 화면에 표시할 상태값인 카운터 숫자

  // counter 변수를 1 증가시키고 화면을 다시 그리는 메서드
  void _incrementCounter() {
    setState(() {  // 화면을 다시 그리도록 하는 함수. StatefulWidget만 가능
      _counter++;
    });
  }

  // 화면에 UI를 그리는 메서드. 그려질 위젯을 반환
  @override
  Widget build(BuildContext context) {
    return Scaffold(   // 머티리얼 디자인 기본 뼈대 위젯
      // 상단 앱바
      appBar: AppBar( 
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      //  화면의 메인 콘텐츠 영역. 표시할 내용
      body: Center( // Center 위젯
        child: Column(  //  Column 위젯
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',   // _counter 변수를 표시
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // 클릭시 _incrementCounter() 메서드 실행
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add), // 하단 + 버튼
      ), 
    );
  }
}
