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
      home: const MyHomePage(title: 'Ex08 Container'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // 상단부터 위젯을 배치
          mainAxisAlignment: MainAxisAlignment.start,   
          children: [
            Container( 
              // 4방향으로 마진이나 패딩을 적용한다.
              // margin: const EdgeInsets.all(10.0), // 컨테이너 주변에 여백을 적용
              // 지정한 방향에만 적용한다.
              margin: const EdgeInsets.only(left: 10, top: 10), // 상단과 왼쪽에 10픽셀씩 설정
              // 컨테이너의 경계와 자식 위젯 사이의 내부 여백을 정의
              padding: const EdgeInsets.all(0.0), 
              color: Colors.yellow,  // 컨테이너 크기를 알기 위해 지정. 
              // width: 300,    // 크기를 지정하지 않으면 부모의 크기
              height: 100,      // 크기를 지정하지 않으면 자식의 크기
              // 자식 위젯을 컨테이너 내에서 배치합
              alignment: Alignment.topLeft,
              child: const Text( // 자식 위젯
                '홍길동',
                style: TextStyle(fontSize: 30, color: Colors.blue),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(0.0),
              // 자식 위젯인 Text 주변에 80픽셀의 패딩이 적용되어 컨테이너의 전체 크기를 결정
              padding: const EdgeInsets.all(80.0),  // 자식과의 패딩으로 크기가 정해짐
              alignment: Alignment.center,
              // 컨테이너의 모양을 결정하는 속성
              decoration: const BoxDecoration(  // BoxDecoration: 시각적 스타일을 적용하는 데 사용
                shape: BoxShape.circle,  // 컨테이너를 완벽한 원으로 표현한다.
                // decoration 내에서 배경색을 설정합니다. decoration 속성을 사용할 때는 
                // Container의 color 속성을 직접 사용할 수 없습니다.
                color: Colors.blue,
              ),
              child: const Text(
                '전우치',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(0.0),
              padding: const EdgeInsets.all(0.0),
              width: 400,       // 크기를 지정하지 않거나 초과하면 부모의 크기
              height: 100,      // 크기를 지정하지 않으면 자식의 크기
              // Text 자식 위젯이 컨테이너의 오른쪽 아래에 배치
              alignment: Alignment.bottomRight,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,  // 사각형 모양으로 설정
                color: Colors.brown,
              ),
              child: const Text(
                '손오공',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            const SizedBox(height: 5,),

            // 컨테이너에 이미지를 데코레이션으로 삽입한 후 ...
            Container(
              width: 100.0,
              height: 60.0,
              // 라운드 형태로도 만들수 있음. 모양을 바꿀수 있음.
              decoration: const BoxDecoration(   // 상태창 꾸미기
                image: DecorationImage(
                  image: AssetImage('assets/images/300x100.png',)
                ),
              ),
              // 텍스트 버튼으로 마치 이미지 버튼과 같은 효과를 적용한다.
              // TextButton은 텍스트가 없으므로 이미지 전체를 덮는 투명하고 클릭 가능한 영역이 됩니다. 
              child: TextButton(
                child: const Text('',),
                onPressed: () => _onClick(1),
              ),
            ),

            // 제스처가 감지될 때 머티리얼 디자인의 잉크 효과를 제공하는 특수 위젯입니다. 
            // 탭 가능한 이미지 컨테이너를 만들 때 주로 사용됩니다.
            Ink.image(
              // 전체가 변함
              image: const AssetImage('assets/images/300x100.png'),
              width: 100.0,
              height: 40.0,
              // fit: BoxFit.fill,
              // 해당 위젯은 onTop으로 클릭 설정을 한다.
              // InkWell의 잉크 리플(번지는) 효과는 Ink.image가 제공하는 이미지 위에 표시됩니다. 
              // 이 방법은 머티리얼 디자인 리플 효과가 있는 이미지 버튼을 만드는 더 일반적인 방식입니다.
              child: InkWell(
                  // child: Text(''),
                  onTap: () => _onClick(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClick(int num) {
    debugPrint('Hello~ $num');
  }
}
