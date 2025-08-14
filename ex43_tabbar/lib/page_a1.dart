import 'package:flutter/material.dart';
import 'page_a2.dart';

class PageA1 extends StatefulWidget {
  const PageA1({super.key});

  @override
  State<PageA1> createState() => _PageA1State();
}

class _PageA1State extends State<PageA1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page A-1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 현재 페이지가 'Page A-1'임을 나타내는 텍스트를 표시
            const Text('Page A-1', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 30,),
            ElevatedButton(
              child: const Text('2페이지 추가',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {        
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => const PageA2()),
                  // 페이지 전환을 위한 라우트를 만드는 클래스, 
                  // MaterialPageRoute와 달리, 전환 애니메이션을 직접 제어
                  PageRouteBuilder( // 페이지 전환을 위한 라우트를 만드는 클래스, 전환 애니메이션을 직접 제어
                    // 페이지를 빌드하는 함수로, 새로운 페이지인 PageA2를 생성
                    pageBuilder: (context, anim1, anim2) => const PageA2(),
                    transitionDuration: Duration(seconds: 3000),  // 실제 앱에서는 훨씬 짧은 시간. 효과 없음.
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}