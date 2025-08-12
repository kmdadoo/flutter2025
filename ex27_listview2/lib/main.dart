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
      home: const MyHomePage(title: 'Ex27 List View #2'),
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
  // 나중에 초기화 될것임을 명시함. 데이터로 사용할 컬렉션
  late List<Person> persons;

  // 위젯 초기화시 닥 한번만 호출되는 함수로 변경했을 때 Hot reload가
  // 지원되지 않으므로 재시작해야 한다.
  @override
  void initState() {
    super.initState();

    persons = [];   // 초기화
    // 더미 데이터로 사용하기위한 반복
    for(int i=0; i<15; i++){
      persons.add(Person(i+21, '홍길동$i', true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: 
        // 2. ListView.builder를 사용해서 리스트를 효율적으로 생성
        // index 를 이용하여 플러터가 알아서 필요한만큼 리스트를 생성한다.
        // ListView.builder : 화면에 보이는 만큼만 리스트 아이템을 만들고, 스크롤할 때마다 
        // 필요한 아이템을 동적으로 생성하여 메모리를 효율적으로 사용
        ListView.builder(
          padding: const EdgeInsets.all(8), // 리스트의 여백
          // 칼렉션에 저장된 아이템의 갯수만큼 알아서 반복 된다.
          itemCount: persons.length,
          itemBuilder: (BuildContext context, int index) {  // 현재 아이템의 위치(index)를 받아와서 해당 위치에 맞는 위젯을 반환
            // 리스트뷰의 아이템을 개수만큼 생성하여 반환
            // persons 리스트에서 index에 해당하는 Person 객체를 가져와 PersonTile 위젯으로 만들어서 반환
            return PersonTile(persons[index]);
          }
        ),
    );
  }
}

// 데이터로 사용할 클래스 ==========================================
class Person {
  int age;
  String name;
  bool isLeftHand;

  Person(this.age, this.name, this.isLeftHand);  // 생성자
}

// PersonTile 정의 
/*
  StatelessWidget클래스는 build()매서드를 가지고 있다. build()메서드는
  위젯을 생성할 때 호출되는데, 실제로 화면에 그릴 위젯을 작성해 반환
  합니다. 따라서 StatelessWidget클래스를 상속받은 PersonTile 클래스는 
  ListTile클래스의 인스턴스를 작성해 반환한다.
 */
class PersonTile extends StatelessWidget {
  // 멤버변수
  final Person _person;
  // 생성자. (필수 매개변수, {선택형 매개변수})
  const PersonTile(this._person, {super.key});

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(_person.name),
      subtitle: Text("${_person.age}살"),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        debugPrint(_person.name);
      },
    );
  }
}
// 이 코드는 ListView.builder를 통해 대량의 데이터를 효율적으로 처리하는 
// 방법을 보여주고, Person과 PersonTile이라는 사용자 정의 클래스를 활용
// 하여 데이터를 리스트 항목 위젯으로 깔끔하게 분리하는 구조를 잘 보여줍니다.
