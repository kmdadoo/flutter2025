import 'package:flutter/material.dart';
import 'color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { // 여기서 테마 선언
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( //앱의 라이트 모드(light mode) 테마를 설정
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        // 최신 Material Design 3를 사용하도록 설정
        useMaterial3: true, 
        //  미리 정의된 color_schemes.g.dart에 있는 lightColorScheme를 사용
        colorScheme: lightColorScheme,
        // 선택되지 않은 라디오 버튼 색깔
        // unselectedWidgetColor: Colors.green,
        // scaffoldBackgroundColor: Colors.yellow[50],
        fontFamily: 'D2Coding',
        textTheme: const TextTheme( //  앱의 텍스트 스타일
          bodyMedium: TextStyle( // 앱의 모든 Text 위젯에 영향을 줍니다
            // button
            fontSize: 25,
            height: 1.5,
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // 앱의 다크 모드(dark mode) 테마를 설정. darkColorScheme을 사용하도록 지정
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const MyHomePage(title: 'Ex18 Theme'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Fruit { apple, banana }

class _MyHomePageState extends State<MyHomePage> {
  Fruit _myGroup = Fruit.banana;
  bool _chk1 = false;
  bool _chk2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 5,  // 상단바 그림자 옵션
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '디폴트 테마가 적용된 글자',
            ),
            // textTheme에 정의된 스타일을 기본적으로 따르지만, 
            // TextStyle을 직접 지정하여 텍스트 색상을 빨간색으로 재정의
            TextButton(
              onPressed: () => debugPrint('aaa'),
              child: const Text('TextButton 0',
                style: TextStyle(fontSize: 24, color: Colors.red)),
            ),
            // 기본 textTheme의 bodyMedium 스타일에 따라 텍스트가 표시
            ElevatedButton(
              child:
                  const Text('디폴트 테마 - 버튼 0', style:                        
                                     TextStyle(fontSize: 24)),
              onPressed: () {
                debugPrint('bbb');
              },
            ),
            ElevatedButton(
              // ElevatedButton.styleFrom을 사용하여 버튼의 배경색, 글자색, 
              // 테두리, 그림자, 모양 등 다양한 스타일을 직접 지정
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // 테두리색
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                    fontSize: 20, fontStyle: FontStyle.italic),
                shadowColor: Colors.blueAccent,
                elevation: 5,
                side: const BorderSide(color: Colors.red, width: 1),
                shape: const BeveledRectangleBorder(
                    borderRadius: // 네모끝
                        BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () {
                debugPrint('ccc');
              },
              child: const Text('글자색 변경 - 버튼 0',
                  style: TextStyle(fontSize: 24,
                                    color: Colors.white)
              )
            ),
            RadioListTile<Fruit>(
              title: const Text('사과'),  // 테마에서
              groupValue: _myGroup,
              value: Fruit.apple,
              onChanged: (Fruit? value) {
                setState(() {
                  _myGroup = value!;
                  debugPrint('$_myGroup');
                });
              },
            ),
            Theme(  // 새로운 테마를 적용
              data: Theme.of(context).copyWith( // 기존 테마를 복사
                // 선택되지 않은 라디오 버튼의 색상을 재정의
                unselectedWidgetColor: Colors.indigo,
              ),
              child: RadioListTile<Fruit>(
                title: const Text('바나나'),
                groupValue: _myGroup,
                value: Fruit.banana,
                activeColor: Colors.pink, // 체크되었을 때 색
                onChanged: (value) {
                  setState(() {
                    _myGroup = value!;
                    debugPrint('$_myGroup');
                  });
                },
              ),
            ),
            Checkbox( // 기본 테마
                value: _chk1,
                checkColor: Colors.pink, // 체크되었을 때 마크의 색
                activeColor: Colors.green, // 체크되었을 때 배경색
                // 노멀 상태의 배경색은 테마로 변경
                onChanged: (value) { // 위에서 bool?처리했기때문에 이곳에서는 안씀
                  setState(() {
                    _chk1 = value!;
                  });
                }),
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.red,  // 두번째 테두리색
              ),
              // 체크되지 않은 체크박스의 테두리 색상을 재정의
              child: Checkbox(
                value: _chk2,
                checkColor: Colors.pinkAccent, // 체크되었을 때 마크의 색
                activeColor: Colors.greenAccent, // 체크되었을 때 배경색
                onChanged: (value) { // 위에서 bool?처리했기때문에 이곳에서는 안씀
                  setState(() {
                    _chk2 = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   icon: const Icon(Icons.thumb_up),
      //   label: const Text('Approve'),
      //   tooltip: 'Increment', //버튼을 길게 누르면 나옴
      //   backgroundColor: Colors.purple,
      //   onPressed: () {
      //     print('ddd');
      //   },
      // ),
      
      floatingActionButton: Theme(
        // 위젯을 사용하여 버튼의 색상을 재정의했습니다. 
        // 특히 colorScheme의 secondary 색상을 const Color(0xFF4A6361)로 
        // 변경하여 버튼의 기본 색상을 바꾸고 있습니다
        data: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
                   .copyWith(secondary: const Color(0xFF4A6361),),
        ),
        child: FloatingActionButton(
          tooltip: 'Increment',
          onPressed: () => (debugPrint('ddd')),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
