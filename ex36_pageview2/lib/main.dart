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
      home: const MyHomePage(title: 'Ex36 PageView Widget #2'),
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
  // 페이지 컨트롤러 생성
  final _pageController = PageController(
    initialPage: 0,
  );
  // 각 페이지의 페이지명으로 사용할 리스트
  List<String> pages = ['Page 1', 'Page 2', 'Page 3'];

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
            Row(  // 버튼
              mainAxisAlignment: MainAxisAlignment.center,
              // 세개의 페이지 바로가기 버튼
              children: [
                ElevatedButton(
                  child: const Text('Page 1', style: TextStyle(fontSize: 20)),
                  onPressed: () => onClick(0),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  child: const Text('Page 2', style: TextStyle(fontSize: 20)),
                  onPressed: () => onClick(1),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  child: const Text('Page 3', style: TextStyle(fontSize: 20)),
                  onPressed: () => onClick(2),
                ),
              ],
            ),
            const Text( // 안내 문구
              '터치한 후 좌우로 Swipe 하세요.',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Expanded(
              flex: 1,
              // PageView.builder 위젯을 사용하여 동적으로 페이지를 생성
              // 페이지가 화면에 나타날 때만 위젯을 생성하여 메모리를 효율적으로 사용합니다.
              child: PageView.builder(
                controller: _pageController,  //  페이지 전환을 제어할 컨트롤러
                itemCount: pages.length,  // 페이지 개수
                itemBuilder: (context, index) { // 페이지를 동적으로 생성하는 빌더 함수
                  debugPrint('PageView.builder호출');
                  // 여기서 호출하여 컨테이너를 반환받아 출력
                  return getPage(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClick(int index) {
    if (_pageController.hasClients) { // 컨트롤러가 뷰와 연결되어 있는지 확인
      // 애니메이션 효과 없이 화면 전환
      // _pageController.jumpToPage(index);

      // 적용된 시간만큼 애니메이션 적용되어 전환
      _pageController.animateToPage(
        index,
        // duration: const Duration(milliseconds: 1), // 효과 없는 것처럼 보임
        // 애니메이션이 진행되는 시간을 400밀리초로 설정
        duration: const Duration(milliseconds: 400),
        //  애니메이션의 속도를 처음과 끝에서 느리게, 중간에서 빠르게 만드는 효과를 줍니다.
        curve: Curves.easeInOut,  //애니메이션 진행 효과 조절. 자동완성에서 골라서 해볼 것.
      );
    }
  }

  // 각 페이지 위젯을 반환
  Widget getPage(int index) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getIcon(index),
            Text(
              pages[index],
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  // 아이콘 위젯을 반환
  // 페이지 인덱스에 따라 다른 아이콘과 색상을 반환하는 간단한 헬퍼 메서드
  Widget getIcon(int index) {
    if (index == 0) {
      return const Icon(Icons.camera_alt, color: Colors.red, size: 35.0);
    } else if (index == 1) {
      return const Icon(Icons.add_circle, color: Colors.orange, size: 35.0);
    } else {
      return const Icon(Icons.star, color: Colors.indigo, size: 35.0);
    }
  }
}
