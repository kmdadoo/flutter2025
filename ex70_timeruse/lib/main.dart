import 'dart:async';

import 'package:flutter/material.dart';

///  Flutter 코드는 dart:async 라이브러리의 Timer 클래스를 사용하여 시간 기반 이벤트를 처리하는 방법을 보여줍니다.
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
      home: const MyHomePage(title: 'Ex70 Time Use'),
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
  // 상태 변수
  String _myText = '00.00'; // 화면에 표시될 텍스트
  Timer? _timer;  // 주기적인 타이머를 관리하는 Timer 객체
  int _timerCount = 0;  // 주기적 타이머의 카운터를 저장하는 정수

  @override
  // 메모리 누수를 방지하기 위해 **_timer.cancel()**을 호출하여 실행 중인 
  // 타이머를 명시적으로 취소합니다. 이는 매우 중요한 단계입니다.
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
  
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
          children: <Widget>[
            Text(
              _myText,
              style: const TextStyle(fontSize: 30.0),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()=> doOneTimer(), 
              child: const Text('1회성 타이머',
                                style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()=> doPeriodicTimerStart(), 
              child: const Text('주기적 타이머 시작',
                                style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()=> doPeriodicTimerEnd(), 
              child: const Text('주기적 타이머 끝',
                                style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
  
  // Timer(const Duration(seconds: 2), ...)를 호출하여 일회성 타이머를 생성합니다
  void doOneTimer() {
    // 2초가 지나면 콜백 함수가 실행되고, setState()를 통해 _myText를 '2초후 출력'으로 업데이트합니다.
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _myText = '2초후 출력';
      });
    });
  }
  
  void doPeriodicTimerStart() {
    // 이미 타이머가 실행 중이면 아무것도 하지 않음
    if (_timer!= null && _timer!.isActive) {
      return;
    }
    // _timerCount를 0으로 초기화하고, 화면에 0을 표시합니다.
    _timerCount = 0;
    setState(() {
      _myText = '$_timerCount';
    });
    
    // _timer = Timer.periodic(const Duration(milliseconds: 10), ...)를 호출하여 주기적 타이머를 시작합니다.
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // _timerCount를 1씩 증가시키고, setState()를 통해 화면의 텍스트를 업데이트
      _timerCount++;
      setState(() {
        _myText = _timerCount.toString();
      });
    });
  }
  
  void doPeriodicTimerEnd() {
    // _timer.cancel()을 호출하여 현재 실행 중인 주기적 타이머를 중지
    _timer?.cancel();
  }
}
