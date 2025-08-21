import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferences 패키지를 사용해서 앱이 종료되어도 데이터를 보존하는 
/// 방법을 보여주는 간단한 카운터 앱입니다. 이 패키지는 앱의 간단한 설정이나 
/// 소량의 데이터를 영구적으로 저장할 때 유용합니다.
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
      home: const MyHomePage(title: 'Ex47 Shared Preferences'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 스마트폰에서 앱을 완전 종료 후 다시 실행 해야 함.
class _MyHomePageState extends State<MyHomePage> {
  // SharedPreferences 객체에 저장할 데이터 생성
  late int counter = 0;  // 정수형 변수를 가집니다. 이 변수는 화면에 표시될 카운터 값
  late SharedPreferences prefs; // 객체를 저장할 prefs 변수가 선언

  @override
  void initState() {
    super.initState();
    // SharedPreferences 메서드로 객체 생성
    getSharedPreferences();
  }

  /*
    getSharedPreferences()는 비동기 함수로, **SharedPreferences.getInstance()**를 
    호출하여 SharedPreferences의 인스턴스를 가져옵니다. 이 작업은 시간이 걸릴 수 
    있어 await 키워드를 사용합니다.
  */
  getSharedPreferences() async {  
    // 객체 생성
    prefs = await SharedPreferences.getInstance();
    setState(() {   // 위젯의 상태를 업데이트   
      // 기존에 저장된 값이 없다면 0, 있다면 해당 값으로 변수값을 설정한다.
      counter = (prefs.getInt("counter") ?? 0);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: FloatingActionButton(
                heroTag: "빼기",
                child: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    counter--;  // counter 변수 값을 1 감소
                  });  
                  // 숫자 감소후 객체에 값을 저장한다.
                  /*
                    현재 counter 값을 "counter"라는 키에 저장합니다.
                   */
                  prefs.setInt("counter", counter);
                },
              ),
            ),
            const Text("Shared preferences value: "),
            Text(
              "$counter",
              style: const TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 40,
              child: FloatingActionButton(
                heroTag: "더하기",
                child: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    counter++;  // counter 변수 값을 1 증가
                  });
                  // 숫자 증가 후 객체에 값을 저장한다.
                  prefs.setInt("counter", counter);
                },
              ),
            )
          ],
        ),      
      ),
    );
  }
}
/**
 * 이 코드의 핵심은 앱을 닫았다가 다시 열었을 때 이전에 저장된 카운터 값이 그대로 
 * 유지된다는 점입니다. SharedPreferences는 작은 데이터를 키-값 쌍 형태로 영구적으로 
 * 저장하여 앱 재실행 시에도 데이터를 불러올 수 있게 해줍니다.
 
 * SharedPreferences 사용의 장점과 용도
  간편성: 복잡한 데이터베이스 설정 없이 소량의 데이터를 쉽게 저장하고 읽을 수 있습니다.
  용도: 사용자 설정(테마, 알림 설정 등), 로그인 상태, 간단한 카운터, 체크박스 상태 등 
    앱의 간단한 정보를 저장하는 데 매우 적합합니다.
    
 * 주의사항
 SharedPreferences는 단순한 데이터를 저장하는 용도로, 대량의 데이터나 복잡한 구조의 
 데이터(예: 객체 리스트)를 저장하는 데는 적합하지 않습니다. 그런 경우에는 SQLite나 
 Hive 같은 데이터베이스를 사용하는 것이 좋습니다.
 */