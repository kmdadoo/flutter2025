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
  String _myText = '00.00'; 
  Timer? _timer;  
  int _timerCount = 0; 

  @override
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
  

  void doOneTimer() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _myText = '2초후 출력';
      });
    });
  }
  
  void doPeriodicTimerStart() {
    if (_timer!= null && _timer!.isActive) {
      return;
    }
    _timerCount = 0;
    setState(() {
      _myText = '$_timerCount';
    });
    
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _timerCount++;
      setState(() {
        _myText = _timerCount.toString();
      });
    });
  }
  
  void doPeriodicTimerEnd() {
    _timer?.cancel();
  }
}
