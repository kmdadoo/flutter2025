import 'package:flutter/material.dart';
// 모든 페이지 전환에 **Navigator.pushReplacement**가 사용
// 현재 화면을 스택에서 제거하고, 새로운 화면을 그 자리에 추가
// 따라서 pushReplacement로 이동한 후에는 기본적인 뒤로가기 버튼(<-)이 나타나지 않으며, 이전 화면으로 돌아갈 수 없습니다.
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
      // 개발자가 직접 정의한 Page1클래스를 사용함.
      // Page1 위젯을 지정하여 앱 시작 시 첫 번째 화면을 띄웁니다.
      home: const Page1(),
    );
  }
}

// Page1, Page2, Page3 (StatefulWidget) 각각 독립적인 화면을 나타내는 위젯
// stful 단축키를 통해 자동완성
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page1'),
      ),
      body: Center(   
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('2페이지로 교체', style: TextStyle(fontSize: 24)),
              // 2패이지로 전환됨(1페이지는 사라짐)
              onPressed: () {
                Navigator.pushReplacement(  // Page2로 화면을 전환
                  context,
                  // 커스텀 애니메이션 효과를 적용
                  PageRouteBuilder(
                    // 전환될 화면(Page2)을 생성
                    pageBuilder: (context, anim1, anim2) => const Page2(),
                    // 초단위로 시간 설정
                    // 애니메이션 지속 시간을 2초로 설정하여 페이지 전환이 천천히 이루어지도록 합니다.
                    transitionDuration: const Duration(seconds: 2),
                    //밀리세컨즈로 시간 설정
                    // transitionDuration: const Duration(milliseconds: 500),

                    // 화면 전환 시 적용될 애니메이션을 정의
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      /*
                        Offset(0.0, 1.0) : 하단에서 올라옴
                        Offset(1.0, 0.0) : 오른쪽에서 나옴
                        Offset(0.0, -1.0) : 상단에서 내려옴
                        Offset(-1.0, 0.0) : 좌측에서 나옴
                      */
                      // begin과 end로 시작 및 종료 위치(Offset)를 설정하여 
                      // 화면이 아래에서 위로 올라오는 효과를 만듭니다.
                      var begin = const Offset(0.0, 1.0);
                      var end = Offset.zero; //Offset(0.0, 0.0)와 동일함.

                      // 일반적인 애니메이션 곡선 줄때 자세한 것은 교안참조.
                      var curve = Curves.elasticInOut; 
                      // Tween을 사용하여 Animation을 Animation으로 변환합니다:
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      // SlideTransition은 Animation<Offset>을 가져와서 
                      // 애니메이션 값이 변경될 때마다 자식을 변환합니다.
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    }
                  ),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, anim1, anim2) => const Page3(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: const Text('3페이지로 교체', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('3페이지로 교체', style: TextStyle(fontSize: 24)),
              onPressed: () {
                Navigator.pushReplacement(  // Page3로 화면을 즉시 전환
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, anim1, animation2) => const Page3(),
                    // 애니메이션 없이 즉시 전환
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
              ),
              onPressed: () {
                Navigator.pushReplacement(  // Page1으로 즉시 전환
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, anim1, animation2) => const Page1(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: const Text('1페이지로 교체', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('1페이지로 교체', style: TextStyle(fontSize: 24)),
              onPressed: () {
                Navigator.pushReplacement(  // Page1으로 즉시 전환
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, anim1, animation2) => const Page1(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
              ),
              onPressed: () {
                Navigator.pushReplacement(  // Page2로 즉시 전환
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, anim1, animation2) => const Page2(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: const Text('2페이지로 교체', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}