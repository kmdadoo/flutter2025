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
      home: const MyHomePage(title: 'Ex26 List View #1'),
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
      // 1. 명시적으로 Listview 의 children으로 List를 넘겨서 생성.
      body: ListView( // 스크롤이 가능한 리스트를 만드는 데 사용되는 위젯
        // children: <Widget>[
        //   // 리스트의 한 항목을 표현하는 데 유용한 위젯
        //   ListTile( 
        //     // 좌측 아이콘, 왼쪽을 담당
        //     leading: const FlutterLogo(
        //       size: 50.0, 
        //     ),
        //     // 타일에 출력할 제목, 중앙을 담당
        //     title: const Text("Basic #1"),
        //     // 출력할 내용
        //     subtitle: const Text('타이틀과 서브 타이틀로만 구성'),
        //     // 우측의 아이콘, 오른쪽을 담당
        //     trailing: const Icon(Icons.more_vert),
        //     onTap: () { // 사용자가 이 항목을 터치했을 때 실행되는 동작을 정의
        //       debugPrint('Basic #1');
        //     },
        //   ),
        // ],

        // 메서드의 리턴값으로 Scaffold의 body 구성. 
        // children: getMyList1(),
        children: getMyList2(),
      ),
    );
  }
  
  // // ListTile 위젯과 항목 사이에 구분선(Divider)을 추가하는 방법
  // List<Widget> getMyList1() { // 리스트 항목들을 위젯 형태로 구성
  //   List<Widget> myList = [
  //     ListTile(
  //       // 좌측 아이콘, 왼쪽을 담당
  //       leading: const FlutterLogo(
  //         size: 50.0, 
  //       ),
  //       // 타일에 출력할 제목, 중앙을 담당
  //       title: const Text("Basic #1"),
  //       // 출력할 내용
  //       subtitle: const Text('타이틀과 서브 타이틀로만 구성'),
  //       // 우측의 아이콘, 오른쪽을 담당
  //       trailing: const Icon(Icons.more_vert),
  //       onTap: () {
  //         debugPrint('Basic #1');
  //       },
  //     ),
  //     const Divider(    // 그래서 이 구분선을 사용함.
  //       color: Colors.black,
  //       height: 5,
  //       // indent: 10,    // 구분선 앞 공간
  //       // endIndent: 10, // 구분선 뒷 공간
  //     ),
  //   ];
  //   return myList;
  // }

  // 반복문을 사용하여 더미 데이터를 기반으로 여러 개의 ListTile 위젯을 동적으로 생성
  List<Widget> getMyList2() {

  // 이런 데이터가 있다 치고. 더미데이터
    List<Person> person  = [];
    for(int i=0; i<15; i++){
      person.add(Person(i+21, '홍길동$i', true));
    }

    // 위의 데이터를 이용하여 리스트 생성
    List<Widget> myList = [];
    for(int i=0; i<person.length; i++) {
      Widget wid = ListTile(
        leading: const FlutterLogo(
          size: 50.0, 
        ),
        title: Text("Basic #$i"),
        subtitle: Text('${person[i].name} - ${person[i].age}'),
        trailing: const Icon(Icons.more_vert),
        onTap: () {
          debugPrint('Basic #$i');
        },
      );
      myList.add(wid);
    }
    return myList;
  } 
}

// 데이터로 사용할 클래스==========================
class Person {
  int age;
  String name;
  bool isLeftHand;

  Person(this.age, this.name, this.isLeftHand);
}