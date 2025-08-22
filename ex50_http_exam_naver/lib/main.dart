import 'dart:convert';  // utf8.decode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      home: const MyHomePage(title: 'Ex50 Http Exam Never'),
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
  var text = '';
  String resultText = 'API 응답을 기다리는 중...'; // API 결과를 표시할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView( // 내용이 길어질 경우를 대비해 스크롤 가능하게
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '검색어를 입력하세요.',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),     
              const SizedBox(height: 20),   
              TextField(
                maxLength: 10,  // 입력 가능한 글자 수를 10자로 제한
                maxLines: 2,  //  최대 2줄까지 표시되도록 설정
                // 입력 필드의 디자인을 꾸밉니다. 테두리 색상, 카운터 스타일 등을 설정
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  // labelText: '내용 입력',                  
                  // counterText: '',   // maxLength 를 감춘다.
                  counterStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.red,              
                                ),
                ),
                //  입력 내용이 바뀔 때마다 실행되는 함수
                onChanged: (text1) {
                  setState(() { // 입력 값 업데이트
                    text = text1;
                  });
                  debugPrint(text1);
                },
                // 사용자가 엔터키를 눌러 입력을 확정할 때 실행
                onSubmitted: (text) {
                  debugPrint('Submitted : $text');
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Http (Get)',
                                  style: TextStyle(fontSize: 18)),              
                onPressed: () {
                  _getRequest();
                },               
              ),
              const SizedBox(height: 20),
              // API 결과를 화면에 표시
              const Text(
                'API 응답:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                resultText,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 네이버 뉴스 검색 API를 호출하는 핵심 로직을 담고 있습니다.
  void _getRequest() async { 
    if (text.isEmpty) {
      setState(() {
        resultText = '검색어를 입력해주세요.';
      });
      return;
    }

    // Uri.encodeQueryComponent(text): 사용자가 입력한 텍스트에 한글이나 특수문자가 포함되어 있을 경우, URL에 맞게 인코딩합니다.
    String str = Uri.encodeQueryComponent(text);
    String url = 'https://openapi.naver.com/v1/search/news.json';
    String opt = '&display=10&sort=sim';

    var regUrl = Uri.parse("$url?query=$str$opt");
    debugPrint("요청 URL: ${regUrl.toString()}"); // 수정: toString() 사용
    
    // try-catch 블록을 추가하여 네트워크 오류 등 예외 상황을 처리하도록 개선했습니다.
    try {
      http.Response response = await http.get(
        regUrl,
        headers: {
          "X-Naver-Client-Id": "n2rE3LFU92tc11751Q3r",
          "X-Naver-Client-Secret": "X2t8njWhHP"
        },
      );

      final statusCode = response.statusCode;
      final responseBody = utf8.decode(response.bodyBytes);

      debugPrint("statusCode: $statusCode");
      debugPrint("responseBody: $responseBody");

      setState(() {
        if (statusCode == 200) {
          // 응답 데이터를 JSON으로 파싱
          final jsonBody = json.decode(responseBody);
          // 첫 번째 뉴스 기사 제목을 가져와서 화면에 표시
          if (jsonBody['items'] != null && jsonBody['items'].isNotEmpty) {
            resultText = '첫 번째 뉴스 제목: ${jsonBody['items'][0]['title']}';
          } else {
            resultText = '검색 결과가 없습니다.';
          }
        } else {
          resultText = 'API 요청 실패. 상태 코드: $statusCode';
        }
      });
    } catch (e) {
      debugPrint("오류 발생: $e");
      setState(() {
        resultText = 'API 요청 중 오류가 발생했습니다.';
      });
    }
  }
}
// statusCode : 200  => 제대로 들어옴.
// 404 => 경로 에러, 403 =>로그인 정보에러, 401 => 인증에러
// 500 => 에러