import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:ex54_sound2/audio_player_manager.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// 오디오 플레이어를 구현하는 방법
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
      home: const MyHomePage(title: 'Ex54 Sound Play 2'),
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
  // 페이지메니져 객체 준비
  // AudioPlayerManager: 별도로 분리된 클래스(파일)로, 오디오 플레이어 로직을 캡슐화합니다.
  late AudioPlayerManager manager;

  @override
  // 위젯이 생성될 때 AudioPlayerManager 객체를 초기화하고, 
  // manager.init()을 호출하여 플레이어를 설정합니다.
  void initState() {
    super.initState();
    // 페이지메니져 객체 생성
    manager = AudioPlayerManager();
    manager.init();
  }

  // 위젯이 사라질 때 manager.dispose()를 호출하여 오디오 플레이어의 
  // 리소스를 해제합니다. 이는 메모리 누수를 막는 데 필수적입니다.
  @override
  void dispose() {
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const SizedBox(height: 100,),
            _progressBar(), // 오디오의 재생 진행 상태를 보여주는 위젯
            const SizedBox(height: 20,),
            _playButton(),  // 재생, 일시 정지, 로딩 상태를 표시하는 버튼 위젯
            const SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('노래 1',
                                    style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    manager.player.setAsset('assets/sounds/background1.mp3');
                  },
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  child: const Text('노래 2',
                                    style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    manager.player.setAsset('assets/sounds/background2.mp3');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 진행 바 위젯
  StreamBuilder<DurationState> _progressBar() {
    // StreamBuilder: AudioPlayerManager의 durationState 스트림을 구독하여 
    // 오디오의 시간 상태가 변할 때마다 UI를 자동으로 업데이트합니다.
    return StreamBuilder<DurationState>(
      stream: manager.durationState,
      builder: (context, snapshot) {
        // snapshot.data: 스트림에서 전달받은 최신 DurationState 객체를 가져옵니다.
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        // audio_video_progress_bar 패키지의 위젯으로, 오디오의 진행 상황을 시각적으로 보여줍니다. 
        // progress, buffered, total 값을 전달받아 진행 바를 그립니다.
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          // nSeek: 사용자가 진행 바를 드래그하여 특정 위치로 이동했을 때 
          // **manager.player.seek**를 호출해 오디오 재생 위치를 변경합니다.
          onSeek: manager.player.seek,
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
        );
      },
    );
  }

  // 재생 버튼 위젯 
  StreamBuilder<PlayerState> _playButton() {
    // StreamBuilder: manager.player.playerStateStream 스트림을 구독하여 오디오 
    // 플레이어의 상태(재생 중, 일시 정지, 로딩 등)가 변할 때마다 UI를 업데이트합니다.
    return StreamBuilder<PlayerState>(
      stream: manager.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        // 로딩/버퍼링 상태: processingState가 loading 또는 buffering일 때 
        // CircularProgressIndicator를 보여주어 사용자에게 로딩 중임을 알립니다.
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          // 재생 중이 아닐 때: playing이 false일 때 재생(Icons.play_arrow) 아이콘 
          // 버튼을 표시하고, 누르면 manager.player.play()를 호출합니다.
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: manager.player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          // 재생 중일 때: processingState가 completed가 아닐 때 일시 정지(Icons.pause) 
          // 아이콘 버튼을 표시하고, 누르면 manager.player.pause()를 호출합니다.
          return IconButton(
            icon: const Icon(Icons.pause),
            iconSize: 32.0,
            onPressed: manager.player.pause,
          );
        } else {
          // 재생이 완료되었을 때: processingState가 completed일 때 다시 재생(Icons.replay) 
          // 아이콘 버튼을 표시하고, 누르면 manager.player.seek(Duration.zero)를 호출하여 처음부터 다시 재생합니다.
          return IconButton(
            icon: const Icon(Icons.replay),
            iconSize: 32.0,
            onPressed: () =>
                manager.player.seek(Duration.zero),
          );
        }
      },
    );
  }
}
