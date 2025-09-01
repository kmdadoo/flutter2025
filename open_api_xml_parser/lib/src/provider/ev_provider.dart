import 'package:flutter/material.dart';
import 'package:open_api_xml_parser/src/model/ev.dart';
import 'package:open_api_xml_parser/src/repository/ev_repository.dart';

// Flutter 앱에서 전기차(EV) 충전소 데이터를 관리하는 역할을 합니다. 
// Provider 패키지를 사용해 데이터를 여러 위젯에 쉽게 공유하고, 데이터가 업데이트될 때마다 화면을 새로고침하도록 알려줍니다.
class EvProvider extends ChangeNotifier {
  // EvRepository를 접근(데이터를 받아와야 하기 때문에)
  // EvRepository는 실제로 외부 API나 데이터베이스에서 데이터를 가져오는 역할을 담당
  final EvRepository _evRepository = EvRepository(); 
  // EvProvider는 이 EvRepository를 통해 데이터를 얻습니다.

  // 데이터 저장 변수: Ev 타입의 객체들을 담을 리스트입니다. 
  // _ (언더바)가 붙어 있어 클래스 내부에서만 접근할 수 있는 프라이빗(private) 변수임을 의미합니다.
  List<Ev> _evs = []; // 전기차 충전소 데이터를 저장
  // 데이터 게터(Getter): 외부에서 _evs 변수에 접근할 수 있도록 해주는 게터입니다. 
  // 위젯들은 이 게터를 통해 EvProvider가 가지고 있는 데이터에 접근할 수 있습니다.
  List<Ev> get evs => _evs; // 외부에서 이 데이터에 접근

  // 데이터 로드
  // 데이터를 비동기적으로 가져오는 메서드
  loadEvs() async {
    // EvRepository 접근해서 데이터를 로드
    // listEvs에 _evs를 바로 작성해도 되지만 예외 처리와 추가적인 가공을 위해 나눠서 작성한다. 
    /** 
     List<Ev>? listEvs = await _evRepository.loadEvs();: _evRepository의 loadEvs() 메서드를 호출하여 
      데이터를 기다립니다(await). 이 메서드는 List<Ev> 또는 null을 반환할 수 있습니다.
    */
    List<Ev>? listEvs = await _evRepository.loadEvs();  // _evRepository를 통해 데이터를 가져온 후
    // _evs = listEvs!;: 가져온 데이터를 _evs 변수에 할당합니다. 
    // !(느낌표)는 listEvs가 null이 아님을 확신한다는 의미입니다.
    _evs = listEvs!;
    // 데이터가 변경되었음을 notifyListeners() 메서드를 호출하여 구독하는 모든 위젯에 알립니다.
    /**
    notifyListeners();: 가장 중요한 부분입니다. _evs 데이터가 성공적으로 업데이트되었음을 이 EvProvider를 
    구독하고 있는 모든 위젯(예: ListWidget)에게 알립니다. 
    이 호출로 인해 UI가 자동으로 다시 그려져서 새로운 데이터가 화면에 표시됩니다.
     */
    notifyListeners(); // 데이터가 업데이트가 됐으면 구독자에게 알린다.
  }
}
/**
 이 코드는 **ChangeNotifier**를 활용하여 데이터와 UI를 분리하고, **_evRepository**를 통해 데이터를 가져온 후, 
 데이터의 변화를 **notifyListeners()**로 화면에 자동으로 반영하는 Provider 패턴의 전형적인 구현 사례입니다.
 */