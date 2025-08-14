import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /**
     * 기본형인 MatrialApp을 Provider로 감사면, 앱 전체에서 사용할 수 있는
     * 공유 데이터가 된다.
     * MaterialApp을 감싸고 있어 앱의 모든 하위 위젯이 공유 데이터를 사용할 수 있게 만듭니다.
     */
    return Provider<String>.value(
      value: '홍길동',
      // Provider의 자식 위젯으로 MaterialApp을 두어, MaterialApp과 그 안에 있는 
      // 모든 위젯이 이 데이터를 사용할 수 있게 됩니다.
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Page1(),
      ),
    );
  }
}

// stful로 페이지 생성
// StatefulWidget으로,공유 데이터를 읽어와 화면에 표시하고 다음 페이지로 이동하는 역할
class Page1 extends StatefulWidget {
  const Page1({ super.key });

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  // 공유 데이터를 읽어 저장할 변수 생성
  String data = '';

  @override
  Widget build(BuildContext context) {
    
    // 데이터 사용
    // listen: false // 변경에 대한 알림 받지 않으려면 추가
    // data = Provider.of<String>(context, listen: false);

    // Provider를 통해 공유 데이터를 얻어옴.
    data = Provider.of<String>(context);
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
              child: const Text('2페이지 추가',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                // 버튼을 누르면 스택에 Page2를 추가한다.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
            ),
            // 공유데이터 출력
            Text(data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({ super.key });

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
              ),
              onPressed: () {
                // 현재 페이지(Page2)를 닫고 이전 페이지(Page1)로 돌아갑니다.
                Navigator.pop(context);
              },
              child: const Text('2페이지 제거', style: TextStyle(fontSize: 24)),
            ),
              /*
              공유 데이터 사용 : 데이터의 변경이 일어나면
              builer에 지정된 익명함수가 호출되고 지정된 위젯만 재빌드된다.
            */
            //Provider의 데이터를 사용하는 또 다른 방법
            Consumer<String>(
              // Provider의 데이터가 변경될 때마다 이 builder 함수가 호출되어 내부 위젯을 다시 빌드
              // value는 Provider가 제공하는 데이터('홍길동')입니다.
              // child는 Consumer 위젯의 자식으로, 데이터 변경과 관계없이 한 번만 빌드될 위젯을 지정할 때 사용합니다.
              builder: (context, value, child) { 
                debugPrint("111111"); // 디버그 메시지
                // Provider에서 제공하는 value를 화면에 출력
                return Text(value, style: const TextStyle(fontSize: 30));
              }
            ),
          ],
        ),
      ),
    );
  }
}