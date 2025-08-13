import 'package:flutter/material.dart';
// 세 개의 탭으로 구성된 하단 메뉴를 만들고, 탭을 선택할 때마다 화면의 내용이 바뀌는 기능을 구현한 예제
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
      home: const MyHomePage(title: 'Ex37 Bottom Navigation Bar'),
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
  // 네비게이션바에서 현재 선택된 하단 메뉴의 인덱스를 저장하는 상태 변수
  int _curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // _curIndex 값에 따라 다른 페이지 위젯(page1(), page2(), page3())을 반환하여 화면을 동적으로 변경
        child: getPage(),
      ),

      // 앱 화면 하단에 고정된 내비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple[100],  // 배경색
        iconSize: 30,   // 아이콘 크기

        // 선택된 메뉴의 아이콘과 텍스트 스타일을 정의
        selectedItemColor: Colors.black,   // 선택했을 때 아이콘 색깔
        selectedLabelStyle: const TextStyle(fontSize: 16),  // 선택된 메뉴의 텍스트 스타일을 정의

        // 선택되지 않은 메뉴의 아이콘과 텍스트 스타일을 정의
        unselectedItemColor: Colors.white, // 선택 되지 않았을 때 색깔
        unselectedLabelStyle: const TextStyle(fontSize: 14),

        // 시각적으로 어떤 메뉴가 선택되었는지 표시
        currentIndex: _curIndex,    // 인덱스 설정
        onTap: (index) {  // 메뉴 아이템을 탭했을 때 호출되는 콜백 함수
          debugPrint("선택한메뉴:$index");  // 로그용
          setState(() {
            // 콜백된 인덱스를 통해 전역변수의 값 변경
            // _curIndex가 변경되면 build 메서드가 다시 호출되고, 
            // body에 표시되는 페이지도 자동으로 바뀝니다.
            _curIndex = index;
          });
        },

        // BottomNavigationBarItem 위젯 리스트를 사용하여 각 메뉴 아이템을 정의
        items: const [
          BottomNavigationBarItem(  // 아이콘과 텍스트 설정
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }

  // 각 페이지를 인덱스를 통해 반환한다.
  Widget getPage() {
    Widget? page;     // null safety 적용
    switch (_curIndex) {
      case 0:
        page = page1();
        break;
      case 1:
        page = page2();
        break;
      case 2:
        page = page3();
        break;
    }
    // non-nullable임을 확신하는 방식으로 구현
    return page!;  // null check operation(실행 시 null이면 런타임에러 발생됨)
  }

  // 각각의 페이지 화면을 구성하는 위젯을 반환하는 메서드
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
