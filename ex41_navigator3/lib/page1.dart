import 'package:ex41_navigator3/page2.dart';
import 'package:ex41_navigator3/page3.dart';
import 'package:flutter/material.dart';

// Navigator.push를 사용하여 새 페이지를 스택에 추가하고, 
// 새 페이지에서 Navigator.pop으로 데이터를 반환받습니다.
class Page1 extends StatefulWidget {
  /// StatefulWidget의 속성은 변경되지 않는 final이어야 하고, 변경 가능한 상태(state)는 State 클래스에서 관리해야 합니다.
  const Page1({super.key, required String data});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  // 파라미터로 전달된 값을 받을 상태 변수
  String _data = '';
  
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
              // 버튼 1을 누르면... 비동기로 동작한다.
              onPressed: () async {
                // 변수 data의 값을 반을 문자열로 만든다.
                setState(() {
                  _data = '';
                });
                // 2페이지를 스택에 추가한다.
                // 2페이지에서 반환되는 데이터가 넘어오길 기다린다.(await)
                // final을 추가하여 변수가 한 번 할당된 후에는 변경되지 않도록 했습니다.
                final String value = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    // 2페이지를 추가하면서 파라미터를 전달한다.
                    builder: (context) => Page2(
                      data: '1페이지에서 보냄 (1->2)',
                    )
                  ),
                );
                // 2페이지에서 콜백해준 데이터를 여기서 출력
                debugPrint('result(1-1) : $value');
                // 콜백 데이터를 통해 화면을 갱신한다.
                setState(() {
                  _data = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text('3페이지 추가', style: TextStyle(fontSize: 24)),
              // 버튼 2를 누르면 3페이지로 스택에 추가한다.
              onPressed: () async {
                // 변수내용 지움
                setState(() {
                  _data = '';
                });
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Page3(
                      data: '1페이지에서 보냄 (1->3)',
                    )
                  ),
                ).then((value) {
                  // 3페이지에서 콜백 데이터가 정상적으로 넘어오면 then절이 
                  // 실행된다. 콘솔출력 및 화면 재렌더링
                  debugPrint('result(1-2) : $value');
                  setState(() {
                    _data = value;
                  });
                });
              },
            ),
            // 파라미터로 넘어오는 데이타를 출력하는 텍스트 위젯
            Text(_data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}