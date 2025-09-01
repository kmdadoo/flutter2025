import 'package:flutter/material.dart';
import 'package:netflixex/widget/bottom_bar.dart';

/// 넷플릭스(Netflix)와 유사한 UI를 만들기 위한 기초를 설정하고 있습니다. 앱의 이름은 'Bbongflix'로 되어 있네요.
void main() {
  runApp(const MyApp());
}

// StatefulWidget을 상속받았는데, 이는 위젯의 상태(데이터)가 변할 수 있다는 것을 의미합니다. 
// (하지만 현재 코드에서는 TabController가 사용되지 않아 StatelessWidget으로도 충분합니다.)
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TabController controller;

  @override
  // 위젯의 UI를 구성
  Widget build(BuildContext context) {
    // MaterialApp: 앱의 기본적인 디자인(Material Design)과 테마를 정의합니다
    return MaterialApp(
      title: 'Bbongflix', // 앱의 제목을 'Bbongflix'로 설정
      // theme: 앱의 전체 테마를 설정합니다. Brightness.dark는 다크 모드를 적용하고, 
      // primaryColor는 검정색, hintColor는 흰색으로 설정하여 넷플릭스와 비슷한 어두운 분위기를 만듭니다.
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        hintColor: Colors.white,
      ),
      // DefaultTabController: TabBar와 TabBarView를 자동으로 연결하고 관리해주는 위젯입니다.
      home: DefaultTabController(
        length: 4,  // 탭의 개수를 4개로 지정
        child: Scaffold(
          // body: 화면의 본문 영역입니다. 여기에 **TabBarView**를 넣어서 탭에 따라 다른 화면을 보여줍니다.
          // DefaultTabController와 함께 사용되며, 탭을 선택할 때마다 해당하는 위젯을 보여주는 역할을 합니다.
          body: TabBarView(
            // physics: const NeverScrollableScrollPhysics(): 사용자가 손가락으로 좌우 스와이프하여 탭을 
            // 변경하는 것을 막습니다. 탭은 오직 하단 바를 눌러야만 이동할 수 있습니다.
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                color: Colors.red.shade100,
                child: const Center(
                  child: Text('home'),
                ),
              ),
              Container(
                color: Colors.red.shade200,
                child: const Center(
                  child: Text('search'),
                ),
              ),
              Container(
                color: Colors.red.shade300,
                child: const Center(
                  child: Text('save'),
                ),
              ),
              Container(
                color: Colors.red.shade400,
                child: const Center(
                  child: Text('more'),
                ),
              ),
            ],
          ),
          // bottomNavigationBar: 하단 내비게이션 바를 설정하는 곳입니다. 
          // Bottom() 위젯을 사용하고 있는데, widget/bottom_bar.dart 파일에서 가져온 것으로 보입니다.
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}