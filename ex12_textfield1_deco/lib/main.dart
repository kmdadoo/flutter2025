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
      home: const MyHomePage(title: 'Ex12 Text Field #1 Deco'),
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
  // 전역변수(멤버변수)를 private으로 선언
  int _count = 0; // 입력된 텍스트의 길이를 저장하는 정수형 변수
  // 화면 상단에 표시되는 텍스트를 저장하는 문자열 변수
  String _myText = "TextField 사용 예제입니다.";
  
  // 입력값을 얻어오기 위한 컨트롤러 생성
  final ctlMyText1 = TextEditingController();
  final ctlMyText2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(      // 세로형 배치
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // 택스트위젯 : 텍스트 출력
            Text(
              _myText,
              style: const TextStyle(fontSize: 30.0),
            ),
            const SizedBox(     // 간단한 간격 설정
              height: 20,
            ), 
            // ctlMyText1을 통해 OutlinedButton을 눌렀을 때 이 필드의 텍스트를 가져와 _myText를 업데이트하는 데 사용
            TextField(      // 입력값이 없는 텓스트 필드
              controller: ctlMyText1,  
            ),
            const SizedBox(
              height: 20,
            ),
            // 입력된 텍스트의 길이를 출력하는 용도(개발자 정의)
            Text(
              '$_count / 10',
              style: const TextStyle(
                fontSize: 30.0,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(   // 텍스트칠드의 너비를 SizedBox를 통해 지정한다.
              width: 240,
              child: TextField( // 커스터마이징 속성들을 보여줍니다.
                controller: ctlMyText2,
                cursorColor: Colors.red,  // 커서의 컬러 지정. 커서의 색상을 빨간색으로 설정
                // cursorWidth: 4.0,        // 두께 지정

                // maxLength를 추가하면 자동적으로 아래에 counter가 생성된다.
                maxLength: 10,              // 입력할 문자열의 최대 길이
                obscureText: true,          // 입력문자 숨김 옵션. 비밀번호 필드처럼 보이게 합니다.
              enabled: true,                // 입력 필드가 활성화 / 비활성화
                // 가상 키보드 타입 설정
                // keyboardType: TextInputType.emailAddress,
                keyboardType: TextInputType.number,
                // keyboardType: TextInputType.phone,
                // keyboardType: TextInputType.name,

                // InputDecoration 위젯을 사용하여 입력 필드의 외관을 꾸밉니다
                decoration: const InputDecoration(  
                  // border: InputBorder.none,
                  // border: OutlineInputBorder(),

                  // 입력 필드에 포커스가 있을 때의 테두리 모양을 설정
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 1.0),
                  ),
                  //입력 필드가 활성화되어 있을 때의 테두리 모양을 설정
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  // 입력 필드가 비활성화되어 있을 때의 테두리 모양을 설정
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  // 텍스트 입력란 왼쪽에 아이콘을 추가
                  prefixIcon: Icon(Icons.perm_identity),
                  // prefixText: 'Pw',
                   // 입력 필드 위에 떠다니는 레이블 텍스트(힌트)를 설정
                  labelText: 'Password',   
                  // 입력 필드 아래에 도움말 텍스트를 표시
                  helperText: '비밀번호를 입력하세요',  // 박스 아래쪽 안내문구
                  // 주석을 풀면 카운터가 없어진다.
                  // counterText: '',

                  // maxLength로 인해 생성된 카운터의 스타일을 변경
                  counterStyle: TextStyle(
                    fontSize: 30.0,
                    color: Colors.red,
                  ),
                ),
                
                // 입력값이 변할때마다 이벤트가 발생된다.
                onChanged: (text) {
                  // 해당 메서드에서 변수가 변화하면 화면이 재렌더링 된다.
                  setState(() {
                    // _count 변수를 현재 텍스트 길이로 업데이트하고, 화면에 $_count / 10 텍스트를 다시 그립니다.
                    _count = text.length;
                  });
                  debugPrint('$text - $_count');
                },
                // 포커싱된 상태에서 엔터키를 누를때 이벤트 발생된다.
                onSubmitted: (text) {
                  debugPrint('Submitted : $text');
                },
              ),
            ),
            // 빈 텍스트를 통해 설정하므로, 텍스트를 지우는 효과가 발생됨.
            OutlinedButton(
              child: const Text(
                'Text 입력버튼',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onPressed: () {
                setState(() {
                  _myText = ctlMyText1.text;
                });
              },
            )
          ],
        ),
      ),
      
      // 플로팅 버튼을 누르면 페스워드 입력값이 텍스트 위젯에 적용된다. 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _myText = ctlMyText2.text;
          });
        },
        tooltip: 'TextFiend Submit',
        child: const Icon(Icons.send),
      ),
    );
  }
}
