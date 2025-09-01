import 'package:flutter/material.dart';
import 'package:studycard/flippable_box.dart';

/// 플립(Flip) 가능한 학습용 카드(Study Card) 앱을 만드는 Flutter 예제입니다. 
/// 사용자가 화면을 탭할 때마다 카드의 앞면과 뒷면이 뒤집히는 애니메이션을 구현합니다.
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
      home: const MyHomePage(title: 'Study Card'),
    );
  }
}

// 카드의 뒤집힘 상태(_isFlipped)를 관리해야 하므로 StatefulWidget으로 정의되었습니다.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 카드의 현재 상태(앞면 또는 뒷면)를 추적하는 불리언(boolean) 변수입니다.
   bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // GestureDetector: 사용자 탭(Tap)을 감지하는 위젯
        child: GestureDetector(
          // onTap: 탭 이벤트가 발생하면 setState를 호출하여 _isFlipped의 값을 반전시키고, 
          // 이로 인해 화면이 다시 그려지면서 카드가 뒤집히는 애니메이션이 실행됩니다.
          onTap: () => setState(() => _isFlipped = !_isFlipped),
          // FlippableBox: studycard 라이브러리의 커스텀 위젯으로, 앞면(front)과 뒷면(back) 
          // 위젯을 인자로 받아 뒤집기 애니메이션을 처리합니다.
          child: FlippableBox(
            // 카드의 앞면 위젯
            front: _buildCard("Front!", 250, 200, Colors.green),
            //  카드의 뒷면 위젯
            back: _buildCard("Back...", 250, 200, Colors.red),
            flipVt: true,
            // _isFlipped 변수의 현재 값에 따라 카드가 뒤집힌 상태로 표시될지 결정합니다.
            isFlipped: _isFlipped,
          ),
        ),
      ),
    );
  }

  // Widget을 Container로 바꿈.
  // 카드의 앞면과 뒷면을 구성하는 재사용 가능한 Container 위젯을 만듭니다. 
  // 이 메서드는 라벨(글자), 크기, 배경색을 인자로 받아 카드를 생성합니다.
  Container _buildCard(String label, double width, double height, Color color) {
    return Container(
      color: color,
      width: width,
      height: height,
      child: Center(
        child: Text(label, style: const TextStyle(fontSize: 32)),
      ),
    );
  }
}
/**
상태 관리(State Management)의 기본적인 원리를 사용하여 사용자의 인터랙션에 따라 동적으로 UI를 변경하는 방법을 잘 보여줍니다. 
FlippableBox와 같은 커스텀 위젯을 활용하여 복잡한 애니메이션을 간결하게 구현하는 예시로도 볼 수 있습니다.
 */