import 'package:flutter/material.dart';

// SliverAppBar 위젯의 다양한 동작을 보여주는 예제입니다. 
// 사용자가 하단의 스위치를 통해 pinned, snap, floating 속성을 
// 제어하며 스크롤 동작에 따라 앱바가 어떻게 변하는지 확인할 수 있습니다.
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
      home: const MyHomePage(title: 'Ex31 Silver Appbar'),
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
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: CustomScrollView( // 복잡한 스크롤 효과를 만들 수 있는 위젯
        slivers: <Widget>[
          SliverAppBar(   // 맨 위에 위치하는 확장 가능한 앱바. 헤더 영역
            //  스크롤을 내렸을 때 앱바가 완전히 사라지지 않고, 축소된 상태로 상단에 고정될지 여부를 결정합니다. 
            pinned: _pinned, 
            // 스크롤을 약간만 올렸을 때 앱바가 완전히 펼쳐지는 효과를 만듭니다.
            // 상단바가 나오는 효과 true면 바로 다나옴.아니면 일부만 나온뒤 나옴.
            snap: _snap,   
            // 스크롤을 내리다 멈추고 다시 올릴 때, 콘텐츠가 다 올라오지 않아도 앱바가 바로 나타나게 합니다.
            floating: _floating,  // false이면 끝까지 나와야 실버바가 나옴.
            expandedHeight: 160.0,   // 앱바가 확장되었을 때의 최대 높이
            // SliverAppBar가 확장될 때 나타나는 유연한 공간으로, 
            // FlexibleSpaceBar 위젯을 사용하여 제목과 배경 이미지(FlutterLogo)를 표시합니다.
            flexibleSpace: const FlexibleSpaceBar(  // 늘어나는 영역의 UI정의
              title: Text('SliverAppBar'),   // 텍스트
              background: FlutterLogo(),    // 이미지
            ),
          ),
          // CustomScrollView 내부에 **일반적인 위젯(non-sliver)**을 포함할 수 있게 해주는 어댑터 역할
          const SliverToBoxAdapter(
            child: SizedBox(  // 간단한 설명 텍스트를 담은 SizedBox 위젯
              height: 20,
              child: Center(
                child: Text('SliverAppBar 효과를 확인해 보세요 신기하죠.'),
              ),
            ),
          ),
          // 스크롤 가능한 항목들의 리스트를 효율적으로 보여주는 위젯
          SliverList(
            delegate: SliverChildBuilderDelegate( // 20개의 항목을 동적으로 생성
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaler: TextScaler.linear(5.0)),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
      // 화면 하단에 고정된 바를 제공하는 위젯
      bottomNavigationBar: BottomAppBar(  // BottomAppBar를 사용하여 세 개의 스위치를 배치합니다.
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(  
            // 사용 가능한 수평 공간이 "오버플로"되지 않는 한 자식을 
            // 행(열)에 배치 하는 위젯입니다
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('pinned'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() { // 화면을 다시 그리도록 합니다.
                        _pinned = val;
                      });
                    },
                    value: _pinned,
                  ),
                ],
              ),
              // snap 스위치를 켤 때는 _floating도 true로 설정
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;                        
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),
              // floating 스위치를 끌 때는 _snap도 false로 설정
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('floating'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
              // snap 속성이 floating 속성에 의존하기 때문에 의존성 로직이 포함됨
            ],
          ),
        ),
      ),
    );
  }
}
