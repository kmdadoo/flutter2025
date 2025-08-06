import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Ex05 Image #1'),
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
  // 현재 실행한 단말기의 다양한 화면 정보를 출력
  void getWindowSize() {  // print 로 출력한 결과는 디버그 콘솔에서 확인
    // 앱 화면에 논리적 크기. 개발자가 UI를 디자인할 때 주로 사용하는 크기 단위. Ex> Size(411.4, 683.4)
    print(MediaQuery.of(context).size);
   
    // 화면 배율. 이 값은 논리적 픽셀 1개가 실제 물리적 픽셀 몇 개로 표현되는지를 나타냅니다. ex> 2.625
    // 이 값을 기준으로 Flutter는 적절한 해상도의 이미지를 자동으로 선택
    print(MediaQuery.of(context).devicePixelRatio);

    // 상단 상태 표시줄(배터리, 시계 등이 표시되는 부분) 높이 double Ex> 24.0
    print(MediaQuery.of(context).padding.top);

    // 앱 화면 실제 크기(물리적 픽셀 단위). 논리적 크기 * 픽셀 밀도 = 물리적 크기 관계가 성립    Ex>Size(1080.0, 1794.0)
    print(PlatformDispatcher.instance.views.first.physicalSize);
  }

  @override
  Widget build(BuildContext context) {
    getWindowSize();    // 메서드 호출

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        // 정렬 관련된 속성
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 이 이미지는 해상도별 폴더(예: 2.0x, 3.0x)에 존재하지 않으므로, Flutter는 기본 폴더의 이미지를 사용
          Image.asset(
          'assets/images/300x300a.png',
          ),

          // 이 이미지는 기기의 픽셀 밀도에 맞는 폴더(예: 2.6x)에 존재하기 때문에, 
          // Flutter는 해당 해상도의 이미지를 자동으로 선택하여 표시합니다. 
          // 크기를 따로 지정하지 않으면, 픽셀 밀도를 고려해 적절한 크기로 축소됩니다.
          Image.asset(
            'assets/images/300x300b.png',
          ),

          // 두 번째 이미지와 동일한 이미지를 사용하지만, width: 100 속성을 추가했습니다. 
          // 이 경우, Flutter는 해상도에 맞는 이미지를 가져오지만, 
          // 최종적으로 위젯의 크기는 100 논리적 픽셀로 고정됩니다
          // Image.asset의 크기가 지정된 것이지 내부의 이미지 크기가 지정된 것은 아니다.
          Image.asset(
            'assets/images/300x300b.png',
            // fit: BoxFit.fill,
            width: 100,  // 액자의 크기를 지정해 주는 것임. 이렇게 지정해서 사용하는 것이 좋다.
          ),

          // 기본 폴더의 이미지에 크기 지정하기. 첫 번째 이미지와 동일한 이미지를 사용 100 논리적 픽셀로 고정
          Image.asset(
            'assets/images/300x300a.png',
            width: 100,
          ),
        ]
      ),
    );
  }
}
