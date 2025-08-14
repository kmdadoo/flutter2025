import 'package:ex41_navigator3/page2.dart';
import 'package:flutter/material.dart';

// 이전 페이지로 데이터를 반환하거나, 현재 페이지를 다른 페이지로 교체하는 방법
class Page3 extends StatefulWidget {
  final String data;  // 불변성을 보장
  const Page3({super.key, required this.data});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  // 상태 변수는 State 클래스 내부에 정의합니다.
  late String _data = '';

  // data 속성을 _data로 초기화
  @override
  void initState() {
    super.initState();
    // 위젯의 초기 데이터를 상태 변수로 가져옵니다.
    _data = widget.data;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton( // Navigator.pop 이 호출
              child: const Text('3페이지 제거',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                // 현재 페이지(Page3)를 내비게이터 스택에서 제거하고, 
                // '3페이지에서 보냄 (Pop)'이라는 문자열을 이전 페이지로 반환합니다.
                // 이 반환값은 Page1 또는 Page2의 await Navigator.push() 부분에서 받게 됩니다.
                Navigator.pop(context, '3페이지에서 보냄 (Pop)');
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
              ),
              onPressed: () {
                // 화면 전환시 파라미터 전달
                // 현재 페이지(Page3)를 스택에서 제거하고, 그 자리에 새로운 페이지(Page2)를 넣습니다.
                // 뒤로 가기 버튼을 눌렀을 때 Page3가 아닌 그 이전 페이지(Page1 또는 Page2로 진입하기 전의 페이지)로 바로 돌아갑니다.
                Navigator.pushReplacement(
                  context, 
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Page2(
                      data: '3페이지에서 보냄 (Replacement)',
                    ),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: const Text('2페이지로 변경',
                                style: TextStyle(fontSize: 24)),
            ),
            // Page3 위젯의 data 속성을 화면에 출력
            Text(_data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}