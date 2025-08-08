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
      home: const MyHomePage(title: 'Ex15 Toggle Button'),
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
  // 토글버튼에서 사용할 리스트
  var multiSelected = [false, false, true];
  var singleSelected = [false, false, true];
  var fancySelected = [false, false, true];

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
            const Text(
              'multi-select',
              style: TextStyle(
                fontSize: 32, // 기본 크기(16)의 2배
              ),
            ),
            // multi-select
            ToggleButtons(
              //이벤트리스너 : 누른 버튼의 인덱스가 매개변수로 전달됨.
              onPressed: (int index) {
                setState(() {
                  //!가 변수 앞에 있으므로 Not연산자임(주의)
                  multiSelected[index] = !multiSelected[index];
                  debugPrint('multiSelected : $multiSelected');
                  debugPrint('index : $index');
                });
              },
              //각 버튼의 값으로 사용할 List설정
              isSelected: multiSelected,
              //각 버튼의 아이콘을 설정
              children: const [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake),
              ],
            ),
            const SizedBox(height: 20),
            // single select
            const Text(
              'single select',
              style: TextStyle(
                fontSize: 32, // 기본 크기(16)의 2배
              ),
            ),
            // single select
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  //항목중 하나만 선택할 수 있도록 for문으로 처리
                  for (var i = 0; i < singleSelected.length; i++) {
                    if (i == index) {
                      //선택한 항목만 활성화
                      singleSelected[i] = true;
                    } else {
                      //나머지는 비활성화 시킴
                      singleSelected[i] = false;
                    }
                  }
                  debugPrint('singleSelected : $singleSelected');
                });
              },
              isSelected: singleSelected,
              children: const [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake),
              ],
            ),
            const Text(
              'fancy',
              style: TextStyle(
                fontSize: 32, // 기본 크기(16)의 2배
              ),
            ),
            // fancy
            ToggleButtons(
              borderColor: Colors.blueGrey, // 버튼의 일반 상태(선택되지 않았을 때) 테두리 색상
              borderWidth: 10,  //  버튼의 테두리 두께
              selectedBorderColor: Colors.blue, // 버튼이 선택되었을 때 테두리 색상
              splashColor: Colors.yellowAccent, // 사용자가 버튼을 눌렀을 때 나타나는 물결 효과(스플래시) 색상
              color: Colors.red, // 버튼이 선택되지 않았을 때, 내부에 있는 자식 위젯(보통 아이콘이나 텍스트)의 색상
              selectedColor: Colors.green, // 선택된 그림의 색
              fillColor: Colors.yellow, // 선택된 버튼의 배경색
              borderRadius: BorderRadius.circular(10),  // 버튼의 모서리
              onPressed: (int index) {
                // 단일 선택 기능
                setState(() {
                  for (int i = 0; i < fancySelected.length; i++) {
                    if (i == index) {
                      fancySelected[i] = true;
                    } else {
                      fancySelected[i] = false;
                    }
                  }
                  debugPrint('fancySelected : $fancySelected');
                });
              },
              isSelected: fancySelected,
              children: const [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Text('cake'), //아이콘 대신 텍스트도 설정 가능
              ],
            ),
          ],
        ),
      ),
    );
  }
}
