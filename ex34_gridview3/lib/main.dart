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
      home: const MyHomePage(title: 'Ex34 GridView Widget #3'),
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
  late List<Person> persons;

  @override
  void initState() {
    super.initState();

    persons = [];
    for (int i = 0; i < 15; i++) {
      persons.add(Person(i + 21, '홍길동$i', true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(   
        // height: 400.0,   // 주석 처리하면 자식 크기로 설정
        child: GridView.count(
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10, // 가로 방향 타일 간의 간격
          mainAxisSpacing: 10,  // 세로 방향 타일 간의 간격을
          crossAxisCount: 3,    // 자동으로 크기가 계산된다. 한 줄에 3개의 타일을 배치
          // 화면이 깨지면 여기를 조절할 것.
          childAspectRatio: 0.7,  // 가로 세로 비율
          children: getGridPage(),
        ),
      ),
    );
  }

  List<Widget> getGridPage() {
    // 그리드로 사용할 리스트 생성
    List<Widget> grid = [];
    for (int i = 0; i < persons.length; i++) {
      Widget myWiget = Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2),
        color: Colors.purple[100],
        child: PersonTile(persons[i], i),
      );

      grid.add(myWiget);
    }

    return grid;
  }
}

// 데이터로 사용할 클래스 ======================================================
class Person {
  int age;
  String name;
  bool isLeftHand;

  Person(this.age, this.name, this.isLeftHand);
}

// PersonTile 정의 =============================================================
class PersonTile extends StatelessWidget {
  final Person _person;
  final int index;
  const PersonTile(this._person, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple[100],
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        splashColor: Colors.purple,
        onTap: () {
          debugPrint('$index번 타일 클릭됨');
        },
        child: SizedBox(
          // width: 140,
          // height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded( // 여기를 Expanded 감싸면 에러 안남.
                child: const SizedBox(
                  child: Icon(
                    Icons.account_box,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                width: double.infinity, // like Match_parent in Android
                height: 60,
                alignment: Alignment.center,
                color: Colors.deepPurple[50],
                child: Column(
                  children: [
                    Text(
                      _person.name,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "'${_person.age}세'",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('Button',
                style: TextStyle(fontSize: 14)),
                onPressed: () => _onClick(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClick(int index) {
    debugPrint('$index 클릭됨');
  }
}
