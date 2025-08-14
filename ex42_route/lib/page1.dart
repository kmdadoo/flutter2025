import 'package:flutter/material.dart';

// **Navigator.pushNamed**를 사용하여 이름이 지정된 라우트(route)로 
// 페이지를 이동하고, 돌아올 때 데이터를 받는 방법을 보여주는 예제
class Page1 extends StatefulWidget {
  final String data; // 불변성을 보장
  // 생성자를 통해 외부로부터 data를 필수로 전달받습니다.
  const Page1({super.key, required this.data});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  // State 클래스 내에서 변경 가능한 상태를 관리합니다.
  // data를 변경할 필요가 없으므로 initState에서 초기화만 합니다.
  late String _data = '';

  // data 속성을 _data로 초기화
  @override
  void initState() { // 초기화
    super.initState();
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('2페이지 추가', style: TextStyle(fontSize: 24)),
              onPressed: () async {
                // Rout에서는 push()대신 pushNamed()(경로를 지정)를 사용한다.
                // pushNamed는 미리 정의된 라우트 이름('/page2')을 사용하여 페이지를 이동합니다.
                // 새로운 페이지에서 콜백데이타가 올때까지 대기(await)한다.
                // 2페이지가 닫히고 반환값을 보낼 때까지 기다립니다.
                // 결과 데이터를 받을 변수는 var로 선언한다. String으로 받으면
                // 에러발생됨. 이미 있는 페이지를 부름.
                var result = await Navigator.pushNamed(context, '/page2');
                debugPrint('result(from 2) : $result');
                // 콜백 데이타를 화면에 적용하기 위해 재렌더링 한다.
                setState(() {
                  // 결과 데이터를 명시적으로 String으로 형변환 후 data에 설정
                  // 반환된 데이터로 data 변수를 업데이트하고 화면을 다시 그립니다.
                  _data = result as String;
                });
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              child: const Text('3페이지 추가', style: TextStyle(fontSize: 24)),
              // 동작 방식은 동일함. 콜백이 성공하면 then()절 실행됨.
              onPressed: () async {
                await Navigator.pushNamed(
                  context, '/page3'
                )
                .then((result) {  //  비동기 작업이 완료되면 then 블록이 실행
                  debugPrint('result(from 3) : $result');
                  setState(() {
                    _data = result as String;
                  });
                });
              },
            ),
            // data 변수의 현재 값을 화면에 출력
            // 앱 실행 초기에는 main.dart에서 전달한 '시작' 출력된다.
            Text(_data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}