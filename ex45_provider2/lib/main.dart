import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2개이상의 provider를 사용할 수 있다.
    // 두 종류의 데이터를 애플리케이션 전체에 제공
    return MultiProvider(
      /**
       * 동일한 Provider가 존재하면 마지막에 선언된 것이 사용된다.
       */
      providers: [
        Provider<String>.value(value: '홍길동'),  // 무시됨
        Provider<String>.value(value: '전우치'),  // 사용됨.
        Provider<int>.value(value: 20),   // 사용됨.
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const Page1(),
      ),
    );
  }
}

// Page1에서는 Provider.of<T>(context)를 사용해 공유 데이터를 가져옵니다.
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String data = '';
  int number = 0;

  @override
  Widget build(BuildContext context) {
    // 데이터 사용 - 변경에 대한 알림 받기
    // 그리고 데이터만 변경하고 UI를 변경하지 않는 곳에서는 false를 해야 됩니다.
    // listen: true는 데이터가 변경될 때마다 Page1 위젯 전체가 다시 빌드되도록 합니다.
    data = Provider.of<String>(context, listen: true);  
    number = Provider.of<int>(context, listen: true);

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
            ),
            // 공유데이터 출력
            Text('$data - $number', style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}

// Page2에서는 Consumer2 위젯을 사용해 공유 데이터를 가져옵니다.
class Page2 extends StatefulWidget {
  const Page2({super.key});

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
                backgroundColor: Colors.deepPurple[100],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('2페이지 제거',
                                style: TextStyle(fontSize: 24)),
            ),
            // 데이터 사용 - 데이터 변경이 일어나면 bulider에 지정된 익명함수가
            // 호출되고 지정된 위젯만 재빌드된다. Provider가 2개이므로 
            // Consumer2<데이터1, 데이터2>를 사용한다.
            /**
            Consumer는 데이터가 변경될 때 **Consumer 위젯 내부의 
            특정 부분(builder 함수)**만 다시 빌드하도록 합니다. 
            이를 통해 불필요한 전체 위젯의 재빌드를 막아 성능을 최적화할 수 있습니다. 
             */
            Consumer2<String, int>(
              builder: (context, data1, data2, child) {
                debugPrint('11111');
                return Text('$data1 - $data2', style: const TextStyle(fontSize: 30));
              }
            ),
          ],
        ),
      ),
    );
  }
}
/**
 Provider를 이용해 여러 위젯 간에 데이터를 효율적으로 공유하고 접근하는 방법을 보여주며,
 Provider.of와 Consumer의 차이점을 설명하고 있습니다. Provider.of는 위젯 전체를 다시 빌드
 하는 반면, Consumer는 필요한 부분만 재빌드하여 성능을 향상시킨다는 점이 중요합니다.
 */