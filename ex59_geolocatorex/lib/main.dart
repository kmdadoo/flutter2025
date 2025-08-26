import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:permission_handler/permission_handler.dart';

// 이 코드는 Flutter에서 **geolocator**와 location_geocoder 패키지를 사용하여 
// 현재 기기의 위치(위도, 경도)를 얻고, 그 좌표를 실제 주소로 변환하여 화면에 표시하는 예제입니다.
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
      home: const MyHomePage(title: 'Ex59 geolocatorex'),
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
  // 에러가 나면 인증키 다시 만들어서 할 것.
  final String _apiKey = 'AIzaSyDk7yQTzqQDom7eiy8uX9CwgsKhojgZ0dA';
  // LocatitonGeocoder는 이 키를 사용하여 좌표를 주소로 변환하는 역할을 합니다. 
  late LocatitonGeocoder geocoder = LocatitonGeocoder(_apiKey);
  // _currentPosition은 현재 위치의 위도, 경도 정보
  late Position _currentPosition;
  // _currentAddress는 변환된 주소를 저장
  String _currentAddress = '';
  String lat = '';
  String lon = '';
  
  // 위도, 경도 구하기. 위치 얻기
  _getCurrentLocation() async {
    // Permission.location.request()를 호출하여 위치 정보 접근 권한을 요청
    await Permission.location.request().then((status){
      // geolocator 패키지의 최신 버전에서는 **LocationSettings**를 사용하여 더욱 
      // 세밀하고 플랫폼별로 특화된 설정을 제공합니다. desiredAccuracy 대신 
      // LocationSettings를 사용하는 것이 더 바람직합니다.
      // 1. 플랫폼별 설정을 담을 변수 선언
      LocationSettings locationSettings;

      // 2. 현재 실행 중인 플랫폼이 Android인지 확인
      if (Platform.isAndroid) {
        // 3. AndroidSettings 객체를 만들고 원하는 설정을 적용
        locationSettings = AndroidSettings(
          // 배터리 효율과 정확도를 모두 고려한 최신 안드로이드 위치 서비스(Fused Location Provider)를 사용하겠다는 의미
          forceLocationManager: false,
          // accuracy: LocationAccuracy.best 가장 높은 정확도로 위치를 찾으라는 설정입니다.
          accuracy: LocationAccuracy.best,
        );
      } else if (Platform.isIOS) {
        // 4. iOS의 경우 AppleSettings 객체를 사용
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        );
      } else {
        // 5. 그 외 플랫폼을 위한 기본 설정
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.best,
        );
      }

      // 사용자가 권한을 허용(PermissionStatus.granted)하면,
      if (status == PermissionStatus.granted){
        // Geolocator.getCurrentPosition()을 사용하여 현재 위치의 Position 객체를 얻습니다.
        Geolocator
          // 6. getCurrentPosition() 메서드에 locationSettings를 전달
          .getCurrentPosition(locationSettings: locationSettings,) 
          .then((Position position) {
            // 성공적으로 위치를 얻으면 _currentPosition에 저장하고, 
            // lat과 lon 변수를 업데이트하여 화면에 표시합니다.
            _currentPosition = position;
            debugPrint('현재 위치 : $_currentPosition');
            setState(() {
              lat = '${position.latitude}';   // 위도
              lon = '${position.longitude}';  // 경도
            });
          }).catchError((e) {
            debugPrint(e);
          });
      }else{
        debugPrint('위치 서비스를 사용할 수 없습니다.');
      }
    });
  }

  // 위도, 경도로 주소 구하기
  Future<void> _getAddressFromLatLng() async {
    // geocoder.findAddressesFromCoordinates()를 호출하여 _currentPosition에 
    // 저장된 위도와 경도 정보를 주소로 변환합니다.
    final address = await geocoder.findAddressesFromCoordinates(
      Coordinates(_currentPosition.latitude, 
                  _currentPosition.longitude));
    
    // 변환된 결과 리스트의 첫 번째 항목(address.first.addressLine)을 
    // 가져와 _currentAddress에 저장하고 화면을 갱신합니다.
    var message = address.first.addressLine;
    debugPrint('현재 주소 : $message');
    if(message == null) return;
    setState(() { // 화면 갱신
      _currentAddress = message;
    });
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
          children: [
            Text("$lat $lon"),
            Text(_currentAddress),
            const SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('현재 위치 찾기',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              child: const Text('현재 주소 구하기',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                _getAddressFromLatLng();
              },
            ),
          ],
        ),
      ),
    );
  }
}
