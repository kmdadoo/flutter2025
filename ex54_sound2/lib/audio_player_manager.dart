import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

// just_audio 및 rxdart 패키지를 사용하여 오디오 재생 상태를 관리하는 클래스를 보여줍니다.
const url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

// 오디오 재생을 관리하는 핵심 클래스
class AudioPlayerManager {
  final player = AudioPlayer(); // 오디오 플레이어 인스턴스를 생성
  // 시간 관련 상태를 실시간으로 스트리밍하는 변수
  // 이 스트림은 Rx.combineLatest2를 사용하여 두 개의 다른 스트림을 결합하여 생성됩니다.
  Stream<DurationState>? durationState;

  void init() {
    // xdart 패키지의 **Rx.combineLatest2**를 사용해 player.positionStream (현재 재생 위치)과 
    // player.playbackEventStream (재생 이벤트)라는 두 개의 스트림을 하나로 합칩니다.
    // 이렇게 결합된 스트림은 두 원본 스트림 중 하나라도 새로운 데이터를 방출할 때마다 DurationState 객체를 생성하여 방출합니다. 
    // 이 덕분에 오디오의 재생 위치, 버퍼링 상태, 총 재생 시간 정보를 항상 최신 상태로 유지할 수 있습니다.
    durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        player.positionStream,
        player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    // 지정된 URL(SoundHelix-Song-2.mp3)에서 오디오 파일을 로드
    player.setUrl(url);
  }

  void dispose() {
    // 오디오 플레이어가 점유하고 있던 시스템 리소스를 해제하여 메모리 누수를 방지합니다.
    player.dispose();
  }
}

// durationState 스트림이 방출하는 데이터를 담는 간단한 클래스
class DurationState {
  const DurationState({
    // progress: 오디오의 현재 재생 위치를 나타내는 Duration 객체
    required this.progress,
    // buffered: 오디오가 미리 버퍼링된 위치를 나타내는 Duration 객체
    required this.buffered,
    // 오디오의 전체 길이를 나타내는 Duration 객체입니다. 
    // total은 null이 될 수 있는데, 이는 오디오의 전체 길이를 아직 알 수 없는 
    // 경우(예: 스트리밍이 시작되기 전) 때문입니다.
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
