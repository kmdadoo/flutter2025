import 'package:ex43_tabbar/page_a1.dart';
import 'package:ex43_tabbar/page_b1.dart';
import 'package:ex43_tabbar/page_c1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

// persistent_bottom_nav_bar_v2 패키지를 사용하여 Flutter 앱에 하단 
// 탭바(Bottom Navigation Bar)를 구현하는 방법을 보여줍니다. 
// 탭바를 통해 여러 페이지를 쉽게 전환할 수 있습니다.
void main() {
  // Flutter 프레임워크가 바인딩되었는지 확인합니다. 
  // 위젯 라이프사이클 초기화 전에 플랫폼 채널을 호출할 때 필요합니다.
  WidgetsFlutterBinding.ensureInitialized();
  // 상태 바(상단)와 내비게이션 바(하단)의 색상을 투명하게 만듭니다.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  // UI를 화면 가장자리까지 확장하여 시스템 UI(상단바, 하단바)가 겹치지 않게 합니다.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

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
      home: const MyHomePage(title: 'Ex43 Tabbar'),
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
  // 탭바 사용을 위한 컨트롤러 선언
  // 이 컨트롤러는 탭바의 현재 상태(어떤 탭이 선택되었는지)를 관리
  late PersistentTabController _controller;

  @override
  void initState() {  // 앱 실행 시 첫 번째 탭(인덱스 0)이 기본으로 선택되도록 합니다.
    super.initState();
    //컨트롤러 객체 생성 및 첫 페이지 설정
    _controller = PersistentTabController(initialIndex: 0);
  }
  
  @override
  Widget build(BuildContext context) {
    // 탭바 위젯
    // return PersistentTabView(  // 커스터마이징 전
    //   controller: _controller,    // 컨트롤러 연결
    //   // 아래에서 정의한 _tabs() 함수를 호출하여 탭바에 표시될 탭 목록을 가져옵니다.
    //   tabs: _tabs(),  
    //   navBarBuilder: (navBarConfig) => Style4BottomNavBar(
    //     navBarConfig: navBarConfig,
    //   ),
    // );
      
      return PersistentTabView(  // 커스터마이징 후
      controller: _controller,    // 컨트롤러
      tabs: _tabs(),  
      // 탭바의 스타일을 지정
      // Style4BottomNavBar를 사용하여 패키지가 제공하는 특정 스타일을 적용
      // 스타일 종류 https://pub.dev/packages/persistent_bottom_nav_bar_v2 참조
      navBarBuilder: (navBarConfig) => Style4BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: const NavBarDecoration(
          color: Colors.yellow, // 여기서 배경색을 바꿀 수 있다.
        ),
      ),
      // backgroundColor: Colors.yellow, // 여기서 전체 변경 안됨.
      // 탭 전환 시 화면 애니메이션을 설정
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Curves 종류 https://api.flutter.dev/flutter/animation/Curves-class.html 참조
        curve: Curves.linear,
        duration: Duration(milliseconds: 1000), // 부드러운 전환 효과
      ),
    );
  }

  // 탭바를 클릭했을 때 처리될 페이지 선언
  List<PersistentTabConfig> _tabs() { // 각 탭에 대한 설정을 정의
    return [
      PersistentTabConfig(  // 탭 하나하나의 설정을 담는 객체
        // 탭을 클릭했을 때 보여줄 페이지 위젯(예: PageA1)을 지정
        screen: const PageA1(), 
        //  탭바에 표시될 아이콘과 제목을 설정
        item: ItemConfig(
          icon: const Icon(Icons.home), // 아이콘
          title: "Home",  // 텍스트
        ),
      ),
      PersistentTabConfig(
        screen: const PageB1(),
        item: ItemConfig(
          icon: const Icon(Icons.search),
          title: "Search",
        ),
      ),
      PersistentTabConfig(
        screen: const PageC1(),
        item: ItemConfig(
          icon: const Icon(Icons.add),
          title: "Add",
        ),
      ),
    ];
  }
}
