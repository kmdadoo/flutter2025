import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Ex24 Time Picker'),
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
  // 현재 시간 가져오기. TimeOfDay 타입의 상태 변수
  TimeOfDay _selectedTime = TimeOfDay.now();

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
          children: <Widget>[
            // 전역변수를 통해 시간과 분을 화면에 출력
            Text(
              '${_selectedTime.hour}:${_selectedTime.minute}',
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              child: const Text('Show TimePicker',
                                style: TextStyle(fontSize: 24)),
              onPressed: () => selectTime(),
            ),
          ],
        ),
      ),
    );
  }

  Future selectTime() async {
    // showTimePicker객체가 반환한 값을 통해 선택한 시간 설정
    TimeOfDay? picked = await showTimePicker( // 시간 선택 대화 상자를 표시하는 핵심 함수
      /*
        context값이 필요하면 future타입으로 TimeOfDay타입의 값을 반환한다.
        TimeOfDay 클래스에는 시간과 분 정보가 있다.
       */
      context: context,  // 현재 위젯의 빌드 컨텍스트를 전달
      initialTime: TimeOfDay.now(),   // 대화 상자가 처음 열렸을 때 기본으로 선택된 시간을 설정. 현재 시간을 기본값으로 설정
      // ### --------------------------------------------------
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light( // 기본 라이트 테마를 복사한 후, colorScheme을 수정
              // 테마의 주요 색상을 deepPurple로 변경하여 시간 선택기의 테두리나 주요 UI 색상을 바꿉니다.
              primary: Colors.deepPurple,
              // 배경 위젯에 표시되는 텍스트 색상을 purpleAccent로 변경
              onSurface: Colors.purpleAccent,
            ),
            // ### button colors ###
            // buttonTheme: ButtonThemeData(
            //   colorScheme: ColorScheme.light(
            //     primary: Colors.green,
            //   ), 
            // ),
          ),
          child: child!,
        );
      },  // 여기서 사용자가 시간을 선택할 때까지 코드가 블록됨.
      // ### --------------------------------------------------
    );
    // 타입피커를 통해 선택한 시간으로 설정한다.
    if(picked != null) {
      // picked 변수에 값이 할당되면, setState()를 호출하여 _selectedTime을 업데이트. 
      // 화면에 표시되는 시간이 변경
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}
