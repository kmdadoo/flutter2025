import 'package:flutter/material.dart';
import 'package:open_api_xml_parser/src/home.dart';
import 'package:open_api_xml_parser/src/provider/ev_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Api Parser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // MultiProvider를 통해 여러 개의 Provider를 관리
      // 여기서는 EvProvider 하나만 사용하고 있지만, 다른 데이터 공급자가 
      // 필요할 때 이 배열(providers: [])에 추가할 수 있습니다.
      home: MultiProvider(
        // ChangeNotifierProvider 통해 변화에 대해 구독
        providers: [
          // ChangeNotifierProvider: 이 앱의 상태 관리를 담당하는 핵심 부분입니다. 
          // EvProvider라는 클래스를 create 함수를 통해 생성하고, 이 EvProvider가 가지고 
          // 있는 데이터가 변경될 때마다 이를 '구독'하고 있는 위젯들에게 알려줍니다.
          ChangeNotifierProvider(
            // ChangeNotifier를 상속받아 데이터의 변화를 알리는 기능을 구현
            create: (BuildContext context) => EvProvider())
        ],
        // MultiProvider의 자식 위젯으로 Home 위젯을 지정
        child:
            const Home() // home.dart 
      )
    );
  }
}