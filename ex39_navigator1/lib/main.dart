import 'package:flutter/material.dart';
// 앱 내의 화면(Page) 전환을 구현하는 예제입니다. 
// Navigator 클래스를 사용해 화면 스택에 페이지를 쌓고(push), 
// 다시 제거하는(pop) 방식을 보여줍니다. 총 3개의 페이지가 있으며, 
// 각 페이지의 버튼을 통해 다음 페이지로 이동하거나 이전 페이지로 돌아갈 수 있습니다.
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
      // 개발자가 직접 정의한 Page1클래스를 사용함.
      // Page1 위젯을 직접 지정하여 앱이 시작될 때 첫 번째 화면을 띄웁니다.
      home: const Page1(),
    );
  }
}

// Page1, Page2, Page3 (StatefulWidget)이 세 클래스는 각각 앱의 독립적인 화면을 나타냅니다.
// stful 단축키를 통해 자동완성
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Page1');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('2페이지 추가', style: TextStyle(fontSize: 24)),
              onPressed: () {
                // 스택에 페이지 추가
                Navigator.push(
                  context,
                  // MaterialPageRoute를 사용하여 Page2 위젯을 생성하고, 이를 현재 화면 스택 위에 쌓습니다.
                  // 이로 인해 화면이 Page1에서 Page2로 전환됩니다.
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Page2');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('3페이지 추가', style: TextStyle(fontSize: 24)),
              onPressed: () {
                Navigator.push( // Page3 위젯을 화면 스택에 추가
                  context,
                  MaterialPageRoute(builder: (context) => const Page3()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // primary는 더 이상 상용되지 않으므로 
                // 대신 backgroundColor를 사용합니다.
                backgroundColor: Colors.purple.shade100,
              ),
              onPressed: () {
                debugPrint('Page2-pop');
                // 스택에서 페이지 제거
                Navigator.pop(context); // 현재 페이지(Page2)를 화면 스택에서 제거
                // Page2가 사라지면서 스택의 가장 아래에 있던 Page1이 다시 화면에 나타납니다.
              },
              // 가독성을 높이기 위해 순서를 아래로 이동
              child: const Text('2페이지 제거', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}


class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Page3');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
              ),
              onPressed: () {
                debugPrint('Page3-pop');
                Navigator.pop(context); // Page3를 화면 스택에서 제거
                // Page3가 사라지면서 Page2가 다시 화면에 나타납니다.
              },
              child: const Text('3페이지 제거', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}
/**
앱 시작: Page1이 화면에 표시됩니다.

Page1에서 '2페이지 추가' 클릭: Page2가 화면에 나타납니다. 화면 스택은 **[Page1, Page2]**가 됩니다.

Page2에서 '3페이지 추가' 클릭: Page3가 화면에 나타납니다. 화면 스택은 **[Page1, Page2, Page3]**가 됩니다.

Page3에서 '3페이지 제거' 클릭: Page3가 제거되고 Page2가 다시 나타납니다. 화면 스택은 **[Page1, Page2]**가 됩니다.

Page2에서 '2페이지 제거' 클릭: Page2가 제거되고 Page1이 다시 나타납니다. 화면 스택은 **[Page1]**이 됩니다.

Page1에서 뒤로가기: 앱이 종료됩니다.

 */