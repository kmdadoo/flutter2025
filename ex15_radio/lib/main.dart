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
      home: const MyHomePage(title: 'Ex15 Radio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// enum은 클래스 내부에 선언할 수 없고, 상수는 소문자로... (자바와 다르다.). 
// 클래스 외부에 enum을 선언하는 것이 일반적이며 라디오 버튼 그룹의 값을 명확하게 구분하고 관리하기 위해 사용
enum Fruit { apple, banana }

class _MyHomePageState extends State<MyHomePage> {
  // 상태 변수
  Fruit _myGroup1 = Fruit.apple;    // 첫 번째 라디오 그룹 부분에 사용할 변수
  Fruit _myGroup2 = Fruit.banana;   // 두번 째 라디오 그룹 부분에 사용할 변수

  bool _btn = true;   // 버튼의 활성화 / 비활성화를 위한 변수

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
            // 라디오 버튼을 정확히 클릭해야 선택됨.
            ListTile(
              title: const Text('사과'),
              leading: Radio<Fruit>(  // Fruit 열거형을 타입으로 사용한 라디오 위젯
                // 현재 그룹에서 선택된 값을 나타냅니다. 
                // 이 값이 value와 일치하면 라디오 버튼이 선택된 상태로 표시됩니다.
                groupValue: _myGroup1,
                value: Fruit.apple, // 이 라디오 버튼이 나타내는 값
                /* 
                  Flutter2.0에서 적용되면서 Null Safrty가 적용되어 널 체크
                  부분이 강화되었다.
                */
                onChanged: (Fruit? value) {
                  setState(() {
                    // 널 체크를 해야한다.
                    _myGroup1 = value!; // value!는  value가 null이 아님을 확신하는 '널 체크' 연산자
                    debugPrint('$_myGroup1');
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('바나나'),
              leading: Radio<Fruit>(
                // 라디오를 하나의 그룹으로 만들 때 사용하는 속성
                groupValue: _myGroup1,
                // 해당 라디오의 값으로 사용하는 속성
                value: Fruit.banana,
                // 라디오 클릭시 이벤트 리스너
                onChanged: (value) {
                  setState(() {
                    // 변수 뒤에 ! - 변수 값이 null이 들어 오면 런 타입 에러 발생시킴.
                    _myGroup1 = value!;
                    debugPrint('$_myGroup1');
                  });
                },
              ),
            ),
            const SizedBox(height: 50), // 간단한 간격 조정
            // 라디오 버튼의 영역이 넓어지므로 해당 라인을 클릭하면 된다.
            // 라디오 버튼뿐만 아니라 라인 전체를 클릭해도 선택이 되므로 사용자 경험이 더 좋습니다.
            RadioListTile<Fruit>(
              title: const Text('사과'),
              groupValue: _myGroup2,
              value: Fruit.apple,
              onChanged: (value) {
                setState(() {
                  _myGroup2 = value!;
                  debugPrint('$_myGroup2');
                  // 아래 엘리베이트버튼을 활성화/비활성화 시키는 기능이 추가된다.
                  _btn = true;
                });
              },
            ),
            RadioListTile<Fruit>(
              title: const Text('바나나'),
              groupValue: _myGroup2,
              value: Fruit.banana,
              activeColor: Colors.pink,
              // 노멀 상태의 배경색은 테마로 변경 : unselectedWidgetColor
              onChanged: (value) {
                setState(() {
                  _myGroup2 = value!;
                  debugPrint('$_myGroup2');
                  _btn = false;
                });
              },
            ),
            const SizedBox(height: 50), // 간단한 간격 조정
            ElevatedButton(
              // 버튼이 활성화 되었을때만 _onClick1메서드를 호출할 수 있다.
              // 버튼의 onPressed 매개변수를 null 로 설정하면 버튼을 비활성화 할 수 있다.
              onPressed: _btn ? _onClick1 : null, // 함수 호출
              child: const Text('ElevatedButton',
                  style: TextStyle(fontSize: 24, color: Colors.black54)),
            ),
          ],
        ),
      ),
    );
  }

  void _onClick1() {
    debugPrint('Radio 2 : $_myGroup2');
  }
}
