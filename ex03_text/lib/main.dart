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
      home: const MyHomePage(title: 'Ex03 Text'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 우리가 작업할 공간
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // 텍스트 스타일을 변수로 선언한 후 위젯에 적용한다.
    var myTextStyle1 = TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          color: Colors.red.withValues(alpha: 0.8), // 색상에 투명도. 이 경우 const 키워드를 사용할 수 없습니다.
                        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // body: const Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       Text(
      //         '홍길동',
      //         style: TextStyle(
      //           fontSize: 30,
      //         ),
      //       ),
      //       Text(
      //         '전우치',
      //         style: TextStyle(
      //           fontSize: 30,
      //         ),
      //       )
      //     ]
      //   ),
      // ),

      // 위젯의 배치를 수직 방향으로 설정한다.
      // 가로로 설정 할때는 Row를 사용한다.
      body: Column(
        // 위젯을 2개 이상 배치하기 위해 사용하는 속성
        // 주로 배열형태로 기술함.
        children: [
          /*
            텍스트를 표현하기 위한 위젯
            Text(출력내용, 스타일)
           */
          // Text선택한 후 ctrl + .누르면 메뉴가 나옴 그중에 컬럼을 
          // 선택해서 추가할 것. center은 똑같이 선택한 후
          // remove해서 지울것.
          const Text(
            '0123456789Aa가#',
            style: TextStyle(
              fontSize: 30.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              fontFamily: "D2Coding",
              letterSpacing:  4.0,   // 자간
            ),
          ),
          const Text(
            '0123456789Aa가#',
            style: TextStyle(
              fontSize: 30.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,  // 미리 정해진 상수값 사용
              color: Color(0xFF000000),
            ),
          ),
          // withOpacity 사용시 const와 충돌
          Text(
            '0123456789Aa가#',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w500,
              color: Colors.black.withValues(alpha: 0.8),  // 투명도
            ),
          ),
          Text(
            '0123456789Aa가#',    // 정렬
            textAlign: TextAlign.left, 
            style: myTextStyle1,  // 앞에서 변수로 선언한 스타일 적용
          ),
        ],
      ),
    );
  }
}
