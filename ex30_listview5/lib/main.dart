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
      home: const MyHomePage(title: 'Ex30 Listview #5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 메인 화면에 세로 스크롤이 가능한 리스트를 만들고, 그 안에 가로 스크롤이 
// 가능한 리스트뷰를 포함시키는 구조를 보여줍니다. 
// 즉, ListView 안에 ListView.builder를 중첩하여 사용
class _MyHomePageState extends State<MyHomePage> {
  // 리스트 컬렉션 생성
  late List<Person> persons;

  //앱 실행시 딱 한번만 호출되어 초기화를 담당한다. 핫리로드가 적용되지 않는다.
  @override
  void initState() {
    super.initState();
    //이런 데이터가 있다고 치고...  더미데이터
    persons = [];
    for (int i=0; i<15; i++) {
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
      body: Container(
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(0.0),
        // width: 250,    // 크기를 지정하지 않으면 부모의 크기
        // height: 250,   // 크기를 지정하지 않으면 자식의 크기
                          // 화면 크기보다 자식이 크면 화면의 크기
        child: ListView(  // 세로 스크롤이 가능한 ListView
          children: [
            Container(
              width: double.infinity,   // like Match_parent in Android
              height: 200,
              alignment: Alignment.center,
              color: Colors.amber[700],
              child: const Text('Entry A', style: TextStyle(fontSize: 30)),
            ),
      
            // 2.  ListView.builder를 사용해서 생성.
            SizedBox( // 가로 스크롤 리스트뷰를 포함한 SizedBox 위젯
              width: double.infinity, 
              height: 200,     
               //빌더를 통해 가로형 리스트뷰를 출력
              child: ListView.builder(
                //스크롤방향을 수평방향으로 설정
                scrollDirection: Axis.horizontal, 
                padding: const EdgeInsets.all(8),
                itemCount: persons.length,   //리스트뷰의 타일 갯수
                itemBuilder: (BuildContext context, int index) {
                  return PersonTile(persons[index], index);
                }
              ),
            ),
      
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              color: Colors.amber[500],
              child: const Text('Entry b', style: TextStyle(fontSize: 30)),
            ),
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              color: Colors.amber[300],
              child: const Text('Entry c', style: TextStyle(fontSize: 30)),
            ),
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              color: Colors.amber[100],
              child: const Text('Entry d', style: TextStyle(fontSize: 30)),
            ),
          ],
        ),
      ),
    );
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
      color: Colors.amber[100],
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        splashColor: Colors.blue, // 파란색 물결 효과
        onTap: (){
          debugPrint('$index번 타일 클릭됨');
        },
        child: SizedBox(
          width: 140,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,   // like Match_parent in Android
                height: 100,
                alignment: Alignment.center,
                color: Colors.blue[50],
                child: Column(
                  children: [
                    //이름 출력
                    Text(
                      _person.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    //나이 출력
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
              // 각 타일별로 존재하는 버튼
              ElevatedButton(                
                onPressed: () => _onClick(index),
                // 버튼 색깔 변경
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[80],
                ),                
                child: const Text('ElevatedButton',
                                  style: TextStyle(fontSize: 13)),
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
// 이 코드는 세로 스크롤 ListView의 항목 중 하나로 가로 스크롤 ListView를 
// 배치하는 복합적인 리스트 구조를 보여주고 있습니다. 이는 다양한 정보를 
// 한 화면에 효율적으로 구성하는 데 유용한 패턴입니다.