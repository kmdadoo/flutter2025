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
      home: const MyHomePage(title: 'Ex19 Snackbar'),
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
  // toast 보다 스낵바룰 사용하는 것이 더 좋음.
  String msg = "Hello world";

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
            ElevatedButton(
              child: const Text('SnackBar 기본', 
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                // 낵바를 화면에 표시하는 가장 일반적인 방법입니다. 
                // ScaffoldMessenger는 현재 화면(Scaffold)과 관련된 스낵바, 시트 등을 관리하는 역할을 합니다.
                ScaffoldMessenger.of(context).showSnackBar(
                  // SnackBar 구현하는 법 context는 위에 BuildContext에 있는
                  // 객체를 그대로 가져오면 됨. 
                  SnackBar( // 스낵바 위젯을 생성
                    // snack bar의 내용. icon, button같은것도 가능하다.
                    content: Text(msg), // 스낵바에 표시될 내용을 정의
                    // 스낵바가 화면에 나타나는 시간을 1초(1000ms)로 설정
                    duration: const Duration(milliseconds: 1000), 
                      // 추가로 작업을 넣기. 버튼 넣기라 생각하면 편하다.
                      action: SnackBarAction(  
                        label: 'Exit',  // 버튼 이름 
                        onPressed: (){}, // 버튼 눌렀을 때
                      ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10,),
            ElevatedButton( // 옵션을 적용한 스낵바 띄우기
              child: const Text('SnackBar 옵션', 
                                style: TextStyle(fontSize: 24)),
              onPressed: () => callSnackBar("안녕하세요~ 홍길동님!"),
            ),
          ],
        ),
      ),
    );
  }

  callSnackBar(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg,  // 메세지 스타일
            style: const TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.yellow[800],    // 스낵바의 배경색
        duration: const Duration(milliseconds: 1000), // 닫히는 시간
        // 스낵바에 별도의 텍스트버튼을 추가할 수 있다.
        action: SnackBarAction(
          label: 'Exit',
          textColor: Colors.black,
          onPressed: () {},
        ),
        // 스낵바의 표시 형태를 변경
        behavior: SnackBarBehavior.floating, // 플로팅(아레쪽 부분에서 띄움). 기본값 fixed
        shape: RoundedRectangleBorder( // 스낵바의 모영을 커스텀 할 수 있다.
          // 모서리를 약간 둥글게 처리함
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide( // 테두리 선
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}
