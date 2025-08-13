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
      home: const MyHomePage(title: 'Ex33 Grid View #2'),
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
      // 자식 위젯이 화면보다 클 경우 스크롤이 가능하도록 만들어주는 위젯
      // 이 위젯 덕분에 두 개의 GridView가 한 화면에서 함께 스크롤
      body: SingleChildScrollView( 
        child: Column(
          children: [
            SizedBox(  
              height: 300,  // SizedBox로 감싸서 크기를 지정하면 이 영역 안에서 첫 번째 GridView가 표시. 스크롤 가능
              child: GridView.count(
                // 스크롤은 세로방향이 기본값
                // scrollDirection: Axis.vertical, 
                crossAxisCount: 3, // 가로 방향 타일의 갯수가 자동으로 계산된다.
                // 가로세로 비율이 1:1인 정사각형 타일을 만듭니다.
                childAspectRatio: 1, // 가로세로 비율을 정한다.
                // int(50)의 길이만큼 0부터 index-1까지 범위의 각 인덱스를
                // 오름차순으로 호출하여 만든 값으로 리스트를 생성한다.
                children: List.generate(50, (index) {
                  return const Card(
                    color: Colors.purpleAccent,
                    child: Icon(
                      Icons.face,
                      color: Colors.deepPurple,
                      size: 50,
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 200,
              child: GridView.count(
                scrollDirection: Axis.horizontal,  // 가로 스크롤 방향으로 설정
                //스크롤 방향(가로)의 반대 방향(세로)으로 2개의 타일을 배치
                crossAxisCount: 2,
                children: List.generate(50, (index) {
                  return const Card(
                    color: Colors.deepPurpleAccent,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
