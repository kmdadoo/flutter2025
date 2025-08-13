import 'package:flutter/material.dart';
// Drawer 위젯을 사용하여 앱의 왼쪽에서 슬라이드되는 메뉴를 구현한 예제입니다. 
// AppBar의 메뉴 버튼을 누르거나, 특정 버튼을 눌렀을 때 Drawer가 열리도록 구성되어 있습니다.
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
      home: const MyHomePage(title: 'Ex38 Drawer Use'),
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
  // Scaffold의 상태에 접근하기 위한 글로벌 키입니다. 
  // Scaffold.of(context)를 사용할 수 없는 상황(예: 버튼의 onPressed 콜백 내부)
  // 에서 Scaffold의 메서드(예: openDrawer())를 호출하기 위해 사용됩니다.
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 기본 슬라이딩 동작을 방지합니다.
      // 화면의 왼쪽 가장자리에서 오른쪽으로 스와이프하여 Drawer를 여는 기본 제스처를 비활성화합니다.
      drawerEnableOpenDragGesture: false, // true면 슬라이딩 된다.
      // 위에서 선언한 scaffoldKey를 Scaffold 위젯에 연결
      key: scaffoldKey,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

        // AppBar의 왼쪽에 위치하는 위젯
        leading: Builder(builder: (context) =>  // 상황에 맞게 있는지
          // Scaffold.of(context)를 호출할 수 있는 새로운 빌드 컨텍스트를 제공
          IconButton(
            // Scaffold.of(context).openDrawer()를 호출하여 Drawer를 엽니다.
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu),
          ),
        ),
      ),

      // drawer 메뉴를 위한 프로퍼티
      // Drawer 메뉴를 정의하는 위젯
      drawer: Drawer(
        // 해당 메뉴는 리스트뷰를 통해 구성한다.
        // ListView를 사용하여 메뉴 항목들을 스크롤 가능하게 만듭니다.
        child: ListView(
          padding: EdgeInsets.zero,
          /*
            만약 해당 위젯이 const로 선언되면 메뉴에 onTop()을
            추가했을 때 에러가 발생되므로 주의해야한다.
           */
          children: <Widget>[
            // Drawer 메뉴의 상단에 위치하는 헤더 부분입니다. 배경색과 텍스트를 설정
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            // 리스트타일을 통해 각 메뉴 구성
            // Drawer의 각 메뉴 항목을 구성하는 위젯
            ListTile(   // 아이콘과 텍스트(메뉴명)로 구성됨
              leading: const Icon(Icons.message), // 메뉴 아이템 왼쪽에 아이콘을 표시
              title: const Text('Messages'),  //메뉴 아이템의 텍스트(메뉴명)를 표시
              onTap: () { // 메뉴를 탭했을 때 실행될 콜백 함수
                debugPrint('Messages 클릭');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                debugPrint('Profile 클릭');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Drawer Close'),
              onTap: () {
                // Drawer 닫기
                // openEndDrawer()는 Scaffold의 오른쪽에 있는 EndDrawer를 열지만, 
                // Drawer만 사용했을 경우 닫는 동작을 수행합니다.
                scaffoldKey.currentState!.openEndDrawer();
                // Scaffold.of(context).openEndDrawer();    // 안됨
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '왼쪽 끝에서 오른쪽으로 드래그해 봅니다.', 
            ),
            ElevatedButton(
              onPressed: (){
                // Scaffold.of(context)가 여기서는 올바른 Scaffold를 찾지 못할 수 있으므로, 
                // scaffoldKey를 사용하는 것이 안전
                // Scaffold.of(context).openDrawer();    // 안됨
                
                // scaffoldKey.currentState!.openDrawer()를 호출하여 Drawer를 직접 엽니다. 
                scaffoldKey.currentState!.openDrawer();
              }, 
              child: const Text('Drawer 열기',
                          style: TextStyle(fontSize:  24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
