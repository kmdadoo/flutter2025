import 'dart:convert';  // utf8.decode UTF-8로 인코딩된 한글 데이터를 올바르게 디코딩하기 위해 사용
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  //  HTTP 요청을 보내기 위한 핵심 패키지

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
      home: const MyHomePage(title: 'Ex50 Http Exam'),
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
            ElevatedButton(
              // 레코드 조회
              child: const Text('Https (Get)', style: TextStyle(fontSize: 24)),
              onPressed: () {
                _getRequest();
              },
            ),
            ElevatedButton(
              // 레코드 입력
              child: const Text('Https (Post)', style: TextStyle(fontSize: 24)),
              onPressed: () {
                _postRequest();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _getRequest() async {  // GET 요청
    // https://sample.bmaster.kro.kr/contacts 여기에서 "no" 하나 복사할 것.
    // 이 URL은 특정 연락처 정보를 요청하는 엔드포인트입니다.
    var url = Uri.parse("https://sample.bmaster.kro.kr/contacts/6896e9410eec080fcefe0d72");
    http.Response response =  
      // 메서드를 사용하여 서버에 GET 요청을 보내고 await 키워드를 사용해 서버의 응답을 기다립니다.
      await http.get(url, headers: {"Accept": "application/json"}); // json으로 가져와라 요청
    // 접속 상태. HTTP 상태 코드를 가져옵니다. (예: 200은 성공)
    var statusCode = response.statusCode;
    // 응답 해더
    var responseHeaders = response.headers;
    // 요청 레코드 정보 json
    var responseBody = utf8.decode(response.bodyBytes); 
    // utf8.decode(response.bodyBytes) 응답 본문(body)의 데이터를 UTF-8 형식으로 디코딩합니다. 
    // 특히 한글이 포함된 데이터를 처리할 때 중요합니다.

    debugPrint("statusCode: $statusCode");
    debugPrint("responseHeaders: $responseHeaders");
    debugPrint("responseBody: $responseBody");
  }

  // POST 요청 
  void _postRequest() async {
    var url = Uri.parse('https://sample.bmaster.kro.kr/contacts');
    // 데이터를 입력해달라고 요청
    http.Response response = await http.post(
      url,
      headers: {
        //  요청 본문이 URL 인코딩된 폼 데이터 형식임을 서버에 알립니다.
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      // 전송할 데이터를 Map<String, String> 형태로 지정합니다. 
      // 이 데이터는 서버로 보내져 새로운 레코드를 생성하는 데 사용됩니다.
      body: {"name": "장그레", "tel": "010-7777-7777", "address": "서울시 종로구 금천동"},
    );

    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);

    debugPrint("statusCode: $statusCode");
    debugPrint("responseHeaders: $responseHeaders");
    debugPrint("responseBody: $responseBody");
  }
}
/**
 이 코드는 HTTP 통신의 기본 원리를 보여줍니다.

  - GET 요청: 서버로부터 정보를 가져올 때 사용합니다.
  - POST 요청: 서버에 새로운 정보를 보내거나 생성할 때 사용합니다.

이 두 가지 메서드를 이해하면 대부분의 웹 API와 효과적으로 통신할 수 있습니다. 
await를 사용하여 비동기 통신을 처리하고, utf8.decode를 사용하여 한글 깨짐 문제를 방지하는 방법도 잘 보여주고 있습니다.
 */