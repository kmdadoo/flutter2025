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
      home: const MyHomePage(title: 'Ex17 Drodown Popup'),
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
  // 드롭다운 버튼에서 선택한 항목을 출력하기 위한 전역변수(함수외부에서 선언)
  String _chosenValue = 'Flutter';

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
            // HTML5의 <select>태그와 비슷한 형태의 위젯
            // 선택된 항목이 버튼 자체에 표시되며, 클릭 시 목록이 아래로 펼쳐지는 형태
            DropdownButton<String>(
              // 버튼에 표시되는 텍스트 스타일 지정
              style: const TextStyle(color: Colors.red),
              // 드롭다운 버튼에 표시될 현재 선택값을 지정
              value: _chosenValue,
              // 항목을 지정(리스트를 통해 지정하면 된다.)
              items: [
                'Android',
                'IOS',
                'Flutter',
                'Node',
                'Java',
                'Python',
                  'PHP',
                ].map((value) { // map 함수를 사용
                // 드롭다운에서 선택한 항목을 반환한다.
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              // 드롭다운의 가로크기를 텍스트만큼 지정한다.
              // value 속성이 설정되어 있어 초기에는 힌트가 보이지 않습니다.
              hint: const Text(
                "힌트글인데 이걸로 크기 조정을...",
              ),
              // 특정 항목을 선택시 실행할 메서드를 지정함(Null safety체크 필요함.)
              onChanged: (String? value) {
                // 외부에서 선언되 메서드 호출
                popupButtonSelected(value!);
                // 변수의 값이 변환할 때 렌더링을 다시한다.
                setState(() {
                  // 이부분이 주석처리되면 화면은 변하지 않는다.
                  _chosenValue = value;
                });
              },
            ),
            // 위젯간의 간격을 조금 띄움
            const SizedBox(height: 50,),
            // 드롭다운 버튼과 기능은 동일하나 UI가 조금 다른 위젯
            // 아이콘(기본값은 세로 점 세 개)을 클릭하면 팝업 메뉴가 나타나고, 
            // 선택된 항목은 별도의 변수나 화면에 표시해야 합니다.
            PopupMenuButton(
              // 팝업 메뉴에 표시될 항목 리스트를 생성하는 함수\
              // PopupMenuItem 위젯들을 담는 List<PopupMenuEntry<String>>를 반환해야 합니다.
              itemBuilder: (BuildContext context) => 
                 <PopupMenuEntry<String>>[
                  const PopupMenuItem(
                    value: "팝업메뉴Value",   //값으로 사용
                    child: Text("팝업메뉴Text"), 
                  ),
                  const PopupMenuItem(
                    value: "Value 1",
                    child: Text("child 1"),
                  ),
                  const PopupMenuItem(
                    value: "Value 2",
                    child: Text("child 2"),
                  ),
                ],
              // 특정 항목을 선택시 메서드 호출
              onSelected: popupMenuSelected,
            )
          ],
        ),
      ),
    );
  }

  // 외부에서 정의한 메서드.
  // 드롭다운 버튼에서 항목을 선택했을 때 호출되는 함수
  void popupButtonSelected(String value) {
    debugPrint(value);
  }

  // 팝업 메뉴에서 항목을 선택했을 때 호출되는 함수
  void popupMenuSelected(String value) {
    debugPrint(value);
  }
}
