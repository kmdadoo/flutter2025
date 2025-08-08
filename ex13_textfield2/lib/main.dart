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
      home: const MyHomePage(title: 'Ex13 Textfield #2'),
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '내용을 입력하세요',
              style: TextStyle(fontSize: 30),
            ),
            /*
              텍스트필드를 멀티라인으로 사용하는 경우 화면사이즈를 넘어가면 제대로 표혀되지
              않으므로 이때는 Expanded위젯으로 감싸준다. 
              Expanded를 사용하면 TextField가 남은 세로 공간을 모두 차지하게 되어, 
              여러 줄을 입력할 때 화면을 벗어나는 오류(overflow)를 방지할 수 있습니다.
              이때 Ctrl + .을 사용하면 된다. (지울때도 마찬가지)
             */
            Expanded(
              child: TextField(
                // maxLength를 추가하면 자동적으로 아래에 couter가 생성된다.
                maxLength: 100,  // 입력할 문자열의 길이
                maxLines: 30,   // 30줄로 설정
                // 입력 필드의 시각적 스타일을 정의
                decoration: const InputDecoration(
                  // 용자가 텍스트 필드를 선택했을 때(포커스되었을 때) 테두리를 초록색으로 만듭니다.
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                  ),
                  // 사용자가 텍스트 필드를 선택하지 않았을 때 테두리를 빨간색으로 만듭니다.
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  // labelText: '내용입력',
                  // counterText: "",   // 주석처리하지 않으면 카운터가 없어진다.
                  // 글자 수 카운터의 글씨 크기와 색상을 설정합니다.
                  counterStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red
                  ),
                ),
                onChanged: (text) {
                  debugPrint(text);
                },
                onSubmitted: (text) {
                  debugPrint('Submitted : $text');
                },
              ),
            ),
            ElevatedButton(
              child: const Text('키보드 내리기',
                                style: TextStyle(fontSize: 24,
                                                 color: Colors.black54)),
              onPressed: () => _onClick(),
            ),
          ],
        ),
      ),
    );
  }

  void _onClick() {
    // 현재 포커스된 위젯(즉, TextField)에서 포커스를 해제하고, 
    // 키보드를 화면에서 내리는 역할을 합니다.
    FocusScope.of(context).unfocus();
  }
}
