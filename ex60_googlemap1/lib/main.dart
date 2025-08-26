import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
/// Maps_flutter 패키지를 사용하여 구글 지도 위젯을 구현하고 제어하는 예제입니다. 
/// 지도에 마커를 추가하고, 버튼 클릭 시 특정 위치로 지도를 이동시키는 기능을 포함하고 있습니다.
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
      home: const MyHomePage(title: 'Ex60 GoogleMap Widget #1'),
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
  // _controller: Completer는 비동기 작업을 완료시키기 위해 사용되는 객체입니다. 
  // 여기서는 지도 컨트롤러(GoogleMapController)가 생성될 때까지 기다렸다가 완료되면 
  // 그 객체를 다른 곳에서 사용할 수 있게 해줍니다.
  final Completer<GoogleMapController> _controller = Completer();

  final LatLng _myLoc1 = const LatLng(37.57979551550774, 126.97706246296076); // 경복궁
  final LatLng _myLoc2 = const LatLng(37.578932311976125, 126.99489126244981); // 창경궁
  // 지도에 표시할 마커 목록을 저장하는 리스트
  final List<Marker> _markers = [];

  // _markers리스트에 마커 데이터를 추가하는 함수
  void setMarkerData() {
    /**
     *  마커 추가 : 마커 클릭시 인포윈도우를 띄울수 있다.
     *      제목과 간단한 설명 글 그리고 탭(클릭) 앴을 때
     *      호출할 메서드를 지정할 수 있다.
     */
    final marker1 = Marker(
      // markerId: 각 마커를 고유하게 식별하는 ID입니다.
      markerId: const MarkerId('A01'),
      // position: 마커가 위치할 위도 및 경도 좌표
      position: _myLoc1,
      // infoWindow: 마커를 탭했을 때 나타나는 정보창
      infoWindow: InfoWindow(
          title: "경복궁",  // 정보창의 제목.
          snippet: "여기는 경복궁입니다.", // 정보창의 부제.
          // 정보창을 탭했을 때 실행될 콜백 함수입니다. 여기서는 디버그 콘솔에 메시지를 출력합니다.
          onTap: () {
            debugPrint('여기는 경복궁입니다.');
          }),
    );
    _markers.add(marker1);
    final marker2 = Marker(
      markerId: const MarkerId('A02'),
      position: _myLoc2,
      infoWindow: InfoWindow(
          title: "창경궁",
          snippet: "여기는 창경궁입니다.",
          onTap: () {
            debugPrint('여기는 창경궁입니다.');
          }),
    );
    _markers.add(marker2);
  }

  @override
  // 젯이 처음 생성될 때 호출되는 초기화 메서드
  // setMarkerData()를 호출하여 _markers 리스트를 초기화
  void initState() {
    super.initState();
    setMarkerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.amber,
            height: 400,
            child: GoogleMap(
              // mapType: 지도의 유형을 설정합니다. MapType.normal은 일반적인 지도를 의미합니다.
              mapType: MapType.normal,
              // initialCameraPosition: 지도가 처음 로드될 때의 시작 위치와 줌 레벨을 설정합니다. 
              // 여기서는 경복궁(_myLoc1)을 중심으로 줌 레벨 15로 설정합니다.
              initialCameraPosition: CameraPosition(
                target: _myLoc1,
                zoom: 15.0,
              ),
              // markers: _markers 리스트를 Set 형태로 변환하여 지도에 마커들을 표시합니다. 
              // (Set은 중복을 허용하지 않습니다.)
              markers: Set.from(_markers),
              // onMapCreated: 지도가 생성될 때 호출되는 콜백 함수입니다. 
              // 이 함수를 통해 지도의 컨트롤러(controller)를 얻고,
              // _controller.complete(controller)를 호출하여 컨트롤러를 저장합니다.
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('경복궁 이동', style: TextStyle(fontSize: 24)),
                onPressed: () => goToLocation(_myLoc1),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                child: const Text('창경궁 이동', style: TextStyle(fontSize: 24)),
                onPressed: () => goToLocation(_myLoc2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 이통버튼 클릭시 카메라의 위치 및 이동방식, 표현방식 설정
  Future<void> goToLocation(LatLng loc) async {
    // _controller.future를 사용하여 지도 컨트롤러 객체를 비동기적으로 가져옵니다.
    final GoogleMapController controller = await _controller.future;
    
    // CameraPosition 객체를 생성하여 이동할 위치(target)와 줌 레벨(zoom)을 설정합니다.
    final CameraPosition pos = CameraPosition(
      target: loc,
      zoom: 17,   // 줌레벨(숫자가 커질수록 확대됨)
      // bearing: 180.0,  // 지도 동서남북 회전
      // tilt: 60.0, // 지도 눕히기 : Camera is directly facing the Earth.
    );
    // 애니메이션 효과가 없는 카메라 이동
    // controller.moveCamera(CameraUpdate.newCameraPosition(pos));
    // 애니메이션 효과 있음.
    controller.animateCamera(CameraUpdate.newCameraPosition(pos));
  }
}
