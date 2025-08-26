import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
/// 이 코드는 현재 위치를 실시간으로 추적하고, 지도에 사용자 정의 마커를 표시하며, 
/// 마커를 탭하면 스낵바를 띄우는 기능을 구현한 Flutter 앱입니다.
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
      home: const MyHomePage(title: 'Ex62 GoogleMap Widget #3'),
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
  // _controller: 지도 컨트롤러를 담을 Completer 객체입니다.
  final Completer<GoogleMapController> _controller = Completer();
  // locationSettings: Geolocator의 위치 스트림 설정을 정의합니다. 
  // accuracy를 높게(high) 설정하고, distanceFilter를 10미터로 지정하여 
  //사용자가 10미터 이상 이동할 때만 위치 업데이트를 받습니다.
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );
  // _myLoc: 현재 위치의 위도/경도를 저장하는 LatLng 객체입니다.
  LatLng _myLoc = const LatLng(0, 0);
  String lat = '';
  String lon = '';
  final List<Marker> _markers = [];
  final Random _random = Random();

  // 위도, 경도 계속 구하기
  void getCurrentLocation() async {
    // Permission.location.request()로 위치 권한을 요청합니다.
    await Permission.location.request().then((stauts) {
      // 권한이 허용되면, Geolocator.getPositionStream()을 사용하여 
      // **위치 정보의 스트림(Stream)**을 받습니다. 
      // 이 스트림은 기기의 위치가 변할 때마다 새로운 위치(Position)를 전달합니다.
      if(stauts == PermissionStatus.granted){
        // 거리가 10미터 이상 변해야 리스너에 위치가 전달된다.
        Geolocator.getPositionStream(locationSettings: locationSettings)
            // listen() 메서드로 스트림을 구독하고, 위치가 업데이트될 때마다 newPosition() 함수를 호출합니다.
            .listen((Position position) => newPosition(position));

      }
    });
  }

  // 새로운 위치(position)가 전달될 때마다 호출
  void newPosition(Position position) async {
    // position.accuracy > 25일 경우, 정확도가 낮은 위치 정보는 무시합니다.
    if(position.accuracy > 25) return;
    // print(position.latitude.toString() + ', ' + position.longitude.toString());
    
    // 변수를 업데이트합니다.
    lat = '${position.latitude}';
    lon = '${position.longitude}';
    _myLoc = LatLng(position.latitude, position.longitude);
    
    // _controller.future를 통해 지도 컨트롤러를 가져와 controller.moveCamera()를 
    // 호출하여 지도를 현재 위치로 이동시킵니다.
    final GoogleMapController controller = await _controller.future;
    // 값은 변해 있지만, 애니메이션은 별도의 동작을 해줘야 한다.
    controller.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _myLoc, zoom: 17)));
    
    debugPrint('444');
    markerAdd();  // 현재 위치에 마커를 추가
  }

  // customMarker: 커스텀 마커 이미지를 담을 BitmapDescriptor 객체
  late BitmapDescriptor customMarker;
  Future<void> setCustomMarker() async {
    // BitmapDescriptor.asset()을 사용하여 assets/images/marker2.png 
    // 파일을 읽어와 customMarker 변수에 할당합니다. 
    // ImageConfiguration을 사용하여 이미지의 크기를 48x48로 지정합니다.
    customMarker = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(48, 48)),
        'assets/images/marker2.png');
  }

  @override
  void initState() {
    super.initState();
    //debugPrint('111');
    // setCustomMarker()를 호출하여 커스텀 마커 이미지를 미리 로드합니다.
    // .then()을 사용하여 마커 이미지 로드가 완료된 후에만 getCurrentLocation()을 호출하여 위치 추적을 시작합니다.
    setCustomMarker().then((value) {
      //debugPrint('222');
      getCurrentLocation();
      //debugPrint('333');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 600,
            // width: 400,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
                zoom: 17.0,
              ),
              // onMapCreated: _onMapCreated,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set.from(_markers),
            ),
          ),
          Text("$lat $lon"),
        ],
      ),
    );
  }

  // Future<void> _onMapCreated(GoogleMapController controller) async {
  //   _controller.complete(controller);
  //   markerAdd();
  // }

  //마커추가
  void markerAdd() {
    final marker = Marker(
      markerId: const MarkerId('maker'),
      position: _myLoc,
      // icon 속성을 customMarker로 지정하여 커스텀 이미지를 마커로 사용합니다.
      icon: customMarker,
      // infoWindow: const InfoWindow(
      //   title: "내위치",
      //   snippet: "내 위치 이동 표시",
      //   // onTap: () { print('bbbb'); },
      // ),
      // onTap 속성으로 마커를 탭했을 때 callSnackBar() 함수를 호출하도록 설정합니다.
      onTap: () => callSnackBar("안녕하세요~ 홍길동님!"),
    );

    // 화면을 갱신하면 지도에 새로운 위치의 마커가 표시
    setState(() {
      debugPrint('666');
      // 기존 마커를 지우고
      _markers.clear();
      // 새로운 마커를 추가
      _markers.add(marker);
    });
  }

  // 마커 탭 시 호출되며, 화면 하단에 커스텀 디자인의 **SnackBar**를 띄웁니다.
  callSnackBar(msg) {
    int myRandomCount = _random.nextInt(5);
    debugPrint('$myRandomCount');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 60,
          child: Row(
            children: [
              Image.asset(
                'assets/images/marker3.png',
                width: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(msg,
                      style: const TextStyle(
                        color: Colors.black,
                      )),
                  Row(
                    children: [
                      IconTheme(
                        data: const IconThemeData(
                          color: Colors.red,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(5, (index) {
                            return Icon(
                              index < myRandomCount
                                  ? Icons.star
                                  : Icons.star_border,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        backgroundColor: Colors.yellow[800],
        // 스넥바 구현 3초
        duration: const Duration(milliseconds: 3000),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.black,
          onPressed: () {},
        ),
        // 스넥바 모양
        // behavior: SnackBarBehavior.floating,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   side: const BorderSide(
        //     color: Colors.red,
        //     width: 2,
        //   ),
        // ),
      ),
    );
  }
}
