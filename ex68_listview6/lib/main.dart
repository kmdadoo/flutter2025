import 'package:flutter/material.dart';

// 사용자가 목록 항목을 드래그 앤 드롭으로 재정렬할 수 있는 ReorderableListView를 사용합니다. 
// 또한, 목록에 항목을 추가하거나 삭제하는 버튼도 포함하고 있습니다.
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
      home: const MyHomePage(title: 'Ex68 ListView #6'),
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
  int nMax = 5; // 다음에 추가될 항목의 값을 저장
  List<int> myList = [0, 1, 2, 3, 4];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // debugPrint('$myList')를 호출하여 현재 myList의 내용을 디버그 콘솔에 출력합니다.
          ElevatedButton(
            onPressed: () {
              debugPrint('$myList');
            }, 
            child: const Text('Print Items',
                              style: TextStyle(fontSize: 24)),
          ),
          ElevatedButton( // 새 항목을 추가
            onPressed: () {
              addItem();
            }, 
            child: const Text('Add in Items',
                              style: TextStyle(fontSize: 24)),
          ),
          ElevatedButton( // 마지막 항목을 삭제
            onPressed: () {
              removeItem();
            }, 
            child: const Text('Delete from Items',
                              style: TextStyle(fontSize: 24)),
          ),
          // 목록을 생성하고 반환하는 커스텀 위젯
          Expanded( // <-- 이게 핵심!!!
            child: myListView()
          ),
        ],
      ),
    );
  }
  
  // **ReorderableListView**를 반환하여 재정렬 가능한 목록을 생성
  Widget myListView() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withValues(alpha: 0.05);
    final Color evenItemColor = colorScheme.primary.withValues(alpha: 0.15);
    
    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      children: <Widget>[
        // for 루프를 사용하여 myList의 각 항목에 대해 **ListTile**을 생성합니다.
        for (int index = 0; index < myList.length; index += 1)
          ListTile(
            // ReorderableListView의 각 자식 위젯은 **고유한 Key**를 가져야 합니다. 
            // 이 키는 Flutter가 항목을 효율적으로 식별하고 이동시키는 데 사용됩니다.
            key: Key('$index'),
            // 항목의 인덱스(myList[index])가 홀수인지 짝수인지에 따라 다른 배경색을 적용합니다.
            tileColor: myList[index].isOdd ? oddItemColor : evenItemColor,
            // 각 항목의 텍스트를 Item [값] 형식으로 표시
            title: Text('Item ${myList[index]}'),
          ),
      ],
      // 필수 매개변수로, 항목이 드래그되어 재정렬될 때 호출되는 콜백 함수
      onReorder: (int oldIndex, int newIndex) {
        setState(() { //위젯의 상태를 변경하고 UI를 다시 그립니다.
          // 항목을 아래로 이동시킬 때 Flutter의 onReorder 동작 특성상 newIndex가 하나 더 
          // 높게 전달되므로, 이를 보정하기 위해 newIndex에서 1을 줍니다.
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          // myList.removeAt(oldIndex): 원래 위치의 항목을 제거하고 반환합니다.
          final int item = myList.removeAt(oldIndex);
          // 제거한 항목을 새로운 위치에 삽입하여 목록의 순서를 변경합니다.
          myList.insert(newIndex, item);
        });
      },
    );
  }
  
  void addItem() {
    setState(() {
      myList.add(nMax);
    });
    nMax++;
  }
  
  void removeItem() {
    setState(() {
      myList.removeLast();
    });
    nMax--;
  }
}
// 상태 관리와 사용자 상호작용을 결합하여 동적으로 변하는 목록을 효율적으로 구현하는 방법을 보여줍니다. 