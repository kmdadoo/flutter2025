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
      home: const MyHomePage(title: 'Ex23 Date Picker'),
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
  // 현재 날짜를 저장하는 상태 변수입니다. 초기값은 앱이 실행된 시점의 날짜
  String _selectedDate = DateTime.now().toString();

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
            // 현재날짜 혹은 선택한 날짜
            Text(_selectedDate, style: const TextStyle(fontSize: 30)),
            ElevatedButton(
              child: const Text('Show DatePicker',
                                style: TextStyle(fontSize: 24)),
              onPressed: () => selectDate(),
            ),

          ],
        ),
      ),
    );
  }

  // 현재 날짜를 가져와 주말(토요일, 일요일)이면 다음 주 월요일을 반환하는 함수
  DateTime selectNowDate() {
      DateTime now = DateTime.now();
      if (now.weekday == 6) {
        now = now.add(const Duration(days: 2)); // 2일 후
      } else if (now.weekday == 7 ) {
        now = now.add(const Duration(days: 1)); // 1일 후
      }
      return now;
  }

  // 특정 날짜를 비활성화(오늘 날짜가 포함되면 에러발생)
  bool _predicate(DateTime day) {

    // 1/5 ~ 1/9까지 활성화
    if ((day.isAfter(DateTime(2023, 1, 5)) &&
        day.isBefore(DateTime(2023, 1, 9)))) {
      return false; // 활성화 시킴
    }

    // 아래와 겹치므로 하나만 주석을 해제할 것.
    // if (day.weekday != 6 && day.weekday != 7) {  
    //   if (day != DateTime(day.year, day.month, 25)) {
    //     return true;
    //   }
    //   return true;
    // }

    // 매달 1~7일까지 비활성화 시킴
    List days = [1,2,3,4,5,6,7];
    if (!days.contains(day.day.toInt())) {
      return true;  // 비활성화
    }
    return false; //  활성화
  }

  // 데이터 피커를 오픈 한다.
  Future selectDate() async {
    DateTime now = DateTime.now();

    // 날짜 선택 대화 상자를 표시. 
    DateTime? picked = await showDatePicker(  
      context: context, // 현재 위젯의 빌드 컨텍스트를 전달
      // 시작화면이 연도별 선택화면이 나옴
      // initialDatePickerMode: DatePickerMode.year,  
      initialDate: selectNowDate(), // selectNowDate() 함수를 통해 평일 날짜를 초기값으로 사용
      firstDate: DateTime(now.year - 2), // 선택가능 한 년도 시작(시작일). 현재 년도의 2년 전으로 설정
      lastDate: DateTime(now.year + 2), // 선택가능한 년도 종료(마직막일), 현재 년도의 2년 후로 설정
      selectableDayPredicate: _predicate, // 특정 날짜를 활성화 또는 비활성화
      // 날짜 선택기의 테마를 커스터마이징할 수 있습니다
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // data: ThemeData.dark(),  // dark 테마
          // data: ThemeData.light(),    // 기본 태마
          data: ThemeData(primarySwatch: Colors.pink),
          child: child!,
        );
      },
    );  
    // 여기서 사용자가 날짜를 선택할 때까지 코드가 잠시 멈춥니다.
    // 사용자가 날짜를 선택하면 picked 변수에 선택된 DateTime 객체가 저장
    if(picked != null) {
      //선택된 날짜가 있을 경우, setState()를 호출하여 _selectedDate 변수를 업데이트하고 
      // 화면을 다시 그립니다. 
      setState(() {
        // toString().substring(0, 10)을 사용하여 년-월-일 형식으로 날짜를 표시합니다.
        _selectedDate = picked.toString().substring(0, 10);
      });
    }
  }
}
// 폰의 시간이 달라 보이는 것은 폰의 지역 설정이 미국이기 때문이다.
// 폰에서 이 설정을 바꾸면 된다. 코드에서 바꿀 문제는 아니다.
