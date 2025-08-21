import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
/// webview_flutter 패키지를 사용하여 웹 페이지를 앱 내부에 표시하는 방법을 보여줍니다. 
/// 웹 페이지를 불러오는 것 외에, Flutter와 웹뷰 내부의 JavaScript 간에 통신하는 방법도 포함하고 있습니다.
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
      home: const MyHomePage(title: 'Ex49 Web View'),
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
  // // WebViewController 생성 -1단계
  // WebViewController controller = WebViewController() // 웹뷰를 제어하는 컨트롤러 객체를 생성
  // // 웹뷰에서 JavaScript 코드를 제한 없이 실행할 수 있도록 허용합니다. 대부분의 웹사이트는 JavaScript를 사용하므로 이 설정이 필수적입니다.
  // ..setJavaScriptMode(JavaScriptMode.unrestricted)
  // // 웹뷰의 배경색을 투명하게 설정
  // ..setBackgroundColor(const Color(0x00000000))
  // // 웹뷰의 페이지 이동을 제어하는 NavigationDelegate를 설정
  // ..setNavigationDelegate(
  //   NavigationDelegate(
  //     // 진행사항을 보고하기 위해 페이지가 로드될 때 호출합니다.페이지 로딩 진행 상황을 추적할 때 호출
  //     onProgress: (int progress) {/* Update loading bar. */},
  //     // 페이지 로드가 시작되면 호출됩니다.
  //     onPageStarted: (String url){},
  //     // 페이지 로드가 완료되면 호출됩니다. 여기서는 debugPrint로 로그를 남깁니다.
  //     onPageFinished: (String url){ debugPrint("onPageFinished");},
  //     // 리소스 로딩 오류가 발생했을 때 호출됩니다.
  //     onWebResourceError: (WebResourceError error) {},
  //     // 탐색요청에 대한 결정이 보류중일때 호출됩니다.
  //     onNavigationRequest: (NavigationRequest request) {
  //       if (request.url.startsWith('https://www.youtube.com/')){
  //         return NavigationDecision.prevent; // 페이지 이동을 막습니다.
  //       }
  //       return NavigationDecision.navigate;  // 이동을 허용
  //     },
  //   ),
  // )
  // ..loadRequest(Uri.parse('https://flutter.dev'));  // 웹 뷰에 연결할 URL

  // 2단계 - Flutter와 웹뷰 간의 통신을 보여주는 예시
  late final WebViewController controller;

  @override
  void initState(){
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // 뷰의 JavaScript 코드와 Flutter 앱 간에 메시지를 주고받는 채널을 생성합니다.
      ..addJavaScriptChannel(
        'JsFlutter', // 채널 이름. 웹뷰의 JavaScript 코드에서 이 이름을 사용하여 Flutter로 메시지를 보냅니다.
        // JavaScript에서 보낸 메시지를 받을 때 실행되는 콜백 함수
        onMessageReceived: (JavaScriptMessage message){
          // JavaScript 에서 Flutter 쪽으로 명령 보내기 처리
          // 메시지에 따라 일을 분기하여 처리
          debugPrint(message.message);
          ScaffoldMessenger
            .of(context)
            .showSnackBar(
              SnackBar(content: Text(message.message)),
          );
        }
      )
      // ..loadRequest(Uri.parse('https://map.kakao.com'));  // 카카오맵 웹뷰
      // 로컬에 있는 HTML 파일을 웹뷰에 로드
      ..loadFlutterAsset("assets/html/my.html");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        // child: Row(
        //   children: [
        //     // Expanded와 Flexible 위젯은 Row, Column, Flex와 같은 플렉스박스 
        //     // 모델을 사용하는 위젯 내부에서만 사용될 수 있다.
        //     Expanded(  // 1 번째
        //       child: WebViewWidget(            
        //         controller: controller,
        //       ),
        //     ),
        //   ],
        // ),

        child: Column(  // 2 번째
          children: [
            ElevatedButton(
              // 플러터 버튼에서 자바스크립트 함수 호출하기 : 카카오맵 사용시 필수
              onPressed: () => callJavaScript(),
              child: const Text('Flutter에서 자바스크립트 실행'),
            ),
            SizedBox(
              height: 500,
              child: WebViewWidget(
                controller: controller,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Flutter 앱에서 웹뷰의 JavaScript 함수를 호출하는 메서드
  void callJavaScript() {   // 2번째
    // controller.runJavaScript('alert("홍길동")');

    // 웹뷰에 appToJs("안녕하세요~")라는 JavaScript 코드를 직접 실행하도록 
    // 지시합니다. 이 함수는 로컬 HTML 파일에 정의되어 있어야 합니다.
    controller.runJavaScript('appToJs("안녕하세요~")');
  }
}
// http://주소는 보안 문제로 인해 기본적으로 열리지 않습니다. 안전한 https:// 프로토콜을 사용해야 합니다.
