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
      home: const MyHomePage(title: 'Ex22 Progress Dialog'),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Show ProgressDialog',
                                style: TextStyle(fontSize: 24)),
              onPressed: () => _showProgressDialog('loading...'),
            ),
          ],
        ),
      ),
    );
  }

  Future _showProgressDialog(String message) async { 
    await showDialog(
      context: context,
      // 대화 상자 바깥 영역을 터치하면 종료 된다.
      barrierDismissible: true,      // false : 눌렀을 때 아무런 변화 없음.
      builder: (BuildContext context) {   
        //테스트시 3초후 창닫기. 비동기 작업에 해당
        Future.delayed(const Duration(seconds: 3), () { 
          // 작업 완료시(로그인 등) 아래 명령을 퉁해 창을 닫아준다.
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        });

        return Theme(
          data: ThemeData(dialogTheme: DialogThemeData(backgroundColor: Colors.white)),
          // 대화 상자의 모양을 정의하는 위젯
          child: AlertDialog(
            // 모서리를 둥글게 만듭니다
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            // 대화창의 외부 크기
            content: SizedBox(
              height: 200,  // 높이를 지정해보세요.
              child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,                  
                  children: [
                    // 인디케이트의 크기 설정
                    const SizedBox(
                      height: 50.0,
                      width: 50.0,
                      // 인디케이드의 모양 혹은 색깔 설정
                      child: CircularProgressIndicator( // 원형 로딩 표시를 생성
                        valueColor: AlwaysStoppedAnimation(Colors.blue),  // 색상
                        strokeWidth: 5.0  // 두께를 조절
                      ),
                    ),
                    const SizedBox(height: 20.0,),                    
                    Text(
                      message,
                      style: const TextStyle(fontSize: 24, height: 1.5)
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
