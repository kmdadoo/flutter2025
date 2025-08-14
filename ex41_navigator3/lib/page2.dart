import 'package:ex41_navigator3/page3.dart';
import 'package:flutter/material.dart';

// Page2에서 Page1으로 데이터를 반환하거나, Page2를 Page3으로 대체하는 방법
class Page2 extends StatefulWidget {
  final String data;  // 불변성을 보장
  const Page2({super.key, required this.data});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton( // Navigator.pop() 이 호출
              child: const Text('2페이지 제거', style: TextStyle(fontSize: 24)),
              onPressed: () {
                // pop 메서드는 현재 페이지(Page2)를 내비게이터 스택에서 제거하고,
                // '2페이지에서 보냄 (Pop)' 이라는 문자열을 이전 페이지(Page1)로 반환합니다.
                // Page1의 await Navigator.push() 부분에서 이 반환값을 받게 됩니다.
                Navigator.pop(context, '2페이지에서 보냄 (Pop)');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
              ),
              onPressed: () {
                // 화면을 전환하면서 파라미터 전달. 이경우 1페이지로 다시 
                // 돌아가더라도 텍스트 위젯에 메세지가 출력되지 않는다.
                /** 
                 * pushReplacement 메서드는 현재 페이지(Page2)를 스택에서 제거하고, 그 자리에 새로운 페이지(Page3)를 넣습니다.
                 * 이 방식은 뒤로 가기 버튼을 눌렀을 때 Page2가 아닌 Page1로 바로 돌아가게 만듭니다.
                */
                Navigator.pushReplacement( 
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Page3(
                      data: '2페이지에서 보냄 (Replacement)',
                    ),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: const Text('3페이지로 변경', style: TextStyle(fontSize: 24)),
            ),
            // 파라미터로 정달받은 값을 텍스트 위젯에 출력
            // Page1에서 전달받은 데이터를 화면에 출력합니다.
            Text(_data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}