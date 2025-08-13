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
      home: const MyHomePage(title: 'Ex35 Page View #1'),
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
  // 페이지뷰를 사용하기 위한 페이지컨트롤러 생성
  // PageView의 현재 페이지와 스크롤 위치를 제어하는 컨트롤러입니다.
  final _pageController = PageController(
    // 0으로 설정하여 앱이 시작될 때 첫 번째 페이지(인덱스 0)가 보이도록 합니다.
    initialPage: 0,
  );

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
          children: [
            const Text(
              '터치한 후 좌우로 Swipe 하세요.',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            // Column 내부에서 PageView가 남은 세로 공간을 모두 차지하도록 만듭니다.
            Expanded(
              flex: 1,  // 남은 공간을 1의 비율로 사용하겠다는 의미
              // PageView는 자체적으로 스크롤을 관리하므로, 
              // SingleChildScrollView 같은 다른 스크롤 위젯으로 감싸지 않아도 됩니다.
              child: PageView(
                // _pageController를 PageView에 연결하여 페이지를 제어할 수 있게 합니다.
                controller: _pageController,
                // pageSnapping: false, // 페이지 넘김 보정 끄기
                children: [
                  // 페이지는 위젯으로 생성한다.
                  page1(),
                  page2(),
                  page3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget page1() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, color: Colors.red, size: 50.0),
            Text(
              'Page index : 0',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget page2() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, color: Colors.orange, size: 50.0),
            Text(
              'Page index : 1',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget page3() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications, color: Colors.blue, size: 50.0),
            Text(
              'Page index : 2',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
