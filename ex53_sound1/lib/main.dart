import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
      home: const MyHomePage(title: 'Ex53 Sound #1'),
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
  // 오디오 플레이어 인스턴스를 생성합
  final AudioPlayer _audioPlayer = AudioPlayer();

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
            IconButton(
              icon: const Icon(Icons.play_circle_fill_outlined),
              iconSize: 60.0,
              color: Colors.blue,
              tooltip: "Open my eyes", // 사용자가 아이콘을 길게 누르면 나타나는 힌트 텍스트
              onPressed: () async {
                await _audioPlayer.setAsset('assets/sounds/01_1_1.mp3')
                  .then((value) async { // setAsset 작업이 성공적으로 완료되면 실행
                    // 현재 재생 중인 오디오를 먼저 중지합니다. 이는 다음 오디오 파일이 즉시 재생되도록 하기 위함입니다.
                    await _audioPlayer.stop().then((value) {
                      _audioPlayer.play();  // 중지 후 로드된 오디오 파일을 재생
                    });
                  });
              },
            ),
            const SizedBox(width: 20,),
            IconButton(
              icon: const Icon(Icons.play_circle_fill_outlined),
              iconSize: 60.0,
              color: Colors.blue,
              tooltip: "Close my eyes", // 길게 누르면 나옴
              onPressed: () async {
                await _audioPlayer.setAsset('assets/sounds/01_1_2.mp3')
                  .then((value) async {
                    await _audioPlayer.stop().then((value) {   // 정상적으로 넘어왔을 때 then 실행
                      _audioPlayer.play();
                    });
                  });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //_audioPlayer 객체가 차지하고 있던 시스템 리소스(예: 메모리)를 해제합니다. 
    // 이 작업을 하지 않으면 앱이 종료된 후에도 오디오 리소스가 해제되지 않아 메모리 누수가 발생할 수 있습니다.
    _audioPlayer.dispose();
    // 상위 클래스의 dispose() 메서드를 호출하여 Flutter 프레임워크가 필요로 하는 추가적인 정리 작업을 수행하도록 합니다
    // 이 코드는 오버라이드된 dispose() 메서드의 가장 마지막에 위치해야 합니다.
    super.dispose();
  }
}
