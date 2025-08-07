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
      home: const MyHomePage(title: 'Ex10 Layout'),
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
      /*
        위젯을 감쌀필요가 있는 경우 Ctrl + .을 사용한다.
       */
      // 이 위젯은 기기의 노치(notch)나 상태 표시줄과 같은 OS UI 요소들을 침범하지 
      // 않는 영역에 자식 위젯을 배치하도록 해줍니다. 
      // 즉, 화면의 안전한 영역(safe area) 내에 UI를 표시합니다.
      body: SafeArea(
        // 전체 화면을 차지
        child: Container( 
          color: Colors.orange,
          child: Column(
            children: [
              // flex: 1로 설정되어 전체 남은 공간의 1/3을 차지
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.yellow,
                  width: 300,
                  height: 100,
                  child: Row(       // 가로형(수평) 배치
                    mainAxisAlignment: MainAxisAlignment.center,  // 가로에 가운대 배치
                    // Row가 사용 가능한 최대 공간을 차지
                    mainAxisSize: MainAxisSize.max,
                    // children : 2개 이상의 위젯을 배치할 때 사용
                    // child : 1개의 위젯을 배치할 때 사용
                    children: [
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                      
                      // const SizedBox(width: 10,),    // 위젯사이의 간격 조정

                      // 버튼들 사이의 공간을 1:2 비율로 나눕니다. 이 덕분에 SizedBox처럼 
                      // 고정된 간격을 주는 대신, 화면 크기에 따라 간격이 자동으로 조절됩니다.
                      const Spacer(flex: 1,),     // 위젯의 전체적인 배치 조정, 비율
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                      // const SizedBox(width: 10,),
                      const Spacer(flex: 2,),
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                    ],
                  ),
                ),
              ),
              // flex: 2로 설정되어 전체 남은 공간의 2/3를 차지
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.cyan,
                  width: 300,
                  height: 100,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(     // 가로형 배치
                    mainAxisAlignment: MainAxisAlignment.center, 
                    // Row의 교차 축(수직)에서 위젯들을 하단에 정렬
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                      // const SizedBox(width: 10,),
                      const Spacer(flex: 1,),
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                      // const SizedBox(width: 10,),
                      const Spacer(flex: 2,),
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
