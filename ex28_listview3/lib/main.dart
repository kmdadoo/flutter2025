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
      home: const MyHomePage(title: 'Ex28 List View #3'),
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
  // 나중에 초기화 될것임을 명시함. 데이터로 사용할 컬렉션.
  late List<Person> persons;

  // 위젯 초기화시 딱 한번만 호출되는 함수로
  // 변경했을때 Hot reload가 지원되지 않으므로 재시작해야 한다.
  @override
  void initState() {  // 더미데이터
    super.initState();

    persons = []; // 초기화
    // 더미데이터로 사용하기 위한 반복
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
        // 3. ListView.separated를 사용해서 Lazy 하게 생성.
        // ListView.separated를 사용하여 리스트 항목과 구분선을 효율적으로 생성하는 방법

        // ListView.builder처럼 화면에 보이는 만큼만 리스트 
        // 아이템을 동적으로 생성하여 메모리를 효율적으로 사용
        ListView.separated(
          itemCount: persons.length,  // 리스트에 표시할 총 아이템의 개수
          itemBuilder: (BuildContext context, int index) {
            // Person 객체외에 추가데이터인 index를 사용한다.
            return PersonTile(persons[index], index);
          },
          // 항목들 사이에 표시될 구분선을 만드는 함수
          separatorBuilder: (BuildContext context, int index){
            return const Divider(     // 구분선
              color: Colors.black,   // Colors.transparent(투명색)
              height: 1,   // 구분선은 해당 속성에 따라 다른 결과를 출력한다.
              thickness: 1.0, // 두께
            );
          },
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

class PersonTile extends StatelessWidget {
  final Person _person;
  final int index;  // 타일에 추가 데이터가 필요한 경우 생성자에 추가하면 된다.
  const PersonTile(this._person, this.index, {super.key});

  @override
  Widget build(BuildContext context){
    /*
      리스트 타일에 배경색을 부여하고 싶을 때는 Container로 감싼후 (Ctrl + .)    
     */
    return Container( // 교안에서 추가한 부분
      color: Colors.amber, 
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(_person.name),
        subtitle: Text("${_person.age}세"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          debugPrint('추가 데이터 : $index');
        },
      ),
    );
  }
}
