import 'package:flutter/material.dart';
import 'package:open_api_xml_parser/src/model/ev.dart';
import 'package:open_api_xml_parser/src/provider/ev_provider.dart';
import 'package:provider/provider.dart';

// Flutter 앱에서 전기차(EV) 충전소 목록을 화면에 표시하는 ListWidget 위젯입니다. 
// Provider 패키지를 사용해 데이터를 가져오고 UI를 업데이트하는 로직을 담고 있습니다.
class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  // 하나의 전기차 충전소(Ev 객체) 정보를 받아 UI 위젯으로 만들어 반환하는 메서드입니다.
  Widget _makeEvOne(Ev ev) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 충전소 주소
                Text(
                  ev.addr.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),

                // 충전기 타입
                Text(
                  ev.chargeTp.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),

                // 충전기 명칭
                Text(
                  "충전기 명칭 : ${ev.cpNm}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),

                // 충전기 상태 코드
                Text(
                  ev.cpStat.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),

                // 충전 방식
                Text(
                  ev.cpTp.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),

                // 충전소 명칭
                Text(
                  "충전소 명칭 : ${ev.csNm}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),

                // 위도
                Text(
                  "위도 : ${ev.lat}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),

                // 경도
                Text(
                  "경도 : ${ev.longi}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 리스트 뷰
  // 여러 개의 Ev 객체 리스트를 받아 ListView.separated 위젯을 만들어 반환합니다.
  Widget _makeListView(List<Ev> evs) {
    return ListView.separated(
      itemCount: evs.length,  // 리스트의 항목 개수를 지정
      // itemBuilder: 리스트의 각 항목을 그리는 방법을 정의합니다. 
      // 여기서는 _makeEvOne 메서드를 호출해 각 충전소 정보를 보여줍니다.
      itemBuilder: (BuildContext context, int index) {
        return Container(
            // 300이면 이미지가 깨질수 있음
            height: 310, color: Colors.white, child: _makeEvOne(evs[index]));
      },
      // separatorBuilder: 각 항목 사이에 구분선(Divider)을 추가합니다.
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  //  UI를 구성하는 핵심 메서드
  @override
  Widget build(BuildContext context) {
    // Provider.of를 통해 데이터를 접근한다. builder만을 업데이트 하기 위해 listen은 false로 한다.
    // EvProvider를 통해 외부에서 전기차 충전소 데이터를 가져옵니다.
    /**
     Provider.of<EvProvider>(context, listen: false): **EvProvider**에 접근해 데이터를 가져옵니다. 
     **listen: false**로 설정하여 이 위젯이 데이터 변화에 따라 자동으로 다시 그려지는 것을 막습니다. 
     이는 loadEvs()를 한 번만 호출하기 위함입니다.
     */
    final evProvider = Provider.of<EvProvider>(context, listen: false);
    // evProvider.loadEvs(): EvProvider의 loadEvs 메서드를 호출하여 데이터를 비동기적으로 가져오기 시작합니다.
    evProvider.loadEvs(); // EvProvider에 loadEvs()의 접근

    return Scaffold(
      appBar: AppBar(
        // 머티리얼3 테마 적용
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ev Provider"),
      ),
      // Consumer를 통해 데이터를 접근
      // Consumer<EvProvider>: EvProvider의 데이터 변화를 '구독'하는 위젯입니다. 
      // EvProvider의 데이터가 변경될 때마다 자동으로 builder 함수를 다시 실행하여 화면을 업데이트합니다.
      body: Consumer<EvProvider>(builder: (context, provider, wideget) {
        // 데이터가 있으면 _makeListView에 데이터를 전달
        // provider.evs.isNotEmpty를 통해 조건부로 화면을 그립니다.
        if (provider.evs.isNotEmpty) {
          // 데이터가 있을 경우: _makeListView를 호출하여 목록을 보여줍니다.
          return _makeListView(provider.evs);
        }

        // 데이터가 없으면 CircularProgressIndicator 수행(로딩)
        // 데이터가 없을 경우: CircularProgressIndicator (로딩 스피너)를 화면 
        // 중앙에 보여주어 데이터 로딩 중임을 사용자에게 알립니다.
        return const Center(
          child: CircularProgressIndicator(),
        );
      })
    );
  }
}
/**
 이 코드는 **Provider**를 이용한 상태 관리를 통해 비동기적으로 데이터를 가져와서, 데이터 유무에 따라 
 로딩 화면과 목록 화면을 효율적으로 전환하여 사용자에게 보여주는 기능을 구현하고 있습니다.
 */