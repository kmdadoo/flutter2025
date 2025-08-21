import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ChangeNotifier를 상속받은 커스텀 클래스를 통해 데이터를 공유하고, 
/// Provider.of와 Consumer의 차이점을 보여줍니다. 

void main() {
  runApp(const MyApp());
}

// 데이터로 사용할 클래스 정의 
// (ChangeNotifier를 상속받은 클래스fh, 상태(데이터)를 담고 있습니다.)
class MyData extends ChangeNotifier {
  // 초기값 설정 vo객체
  String name = '홍길동';
  int age = 25;

  // 데이터 변경시 호출할 메소드 정의
  // (새로운 값으로 변경하는 역할)
  void change(String name, int age) {
    // 로그 및 갑 설정
    debugPrint('change called...');
    this.name = name;
    this.age = age;
    
    // 데이터 변경 후 호출하면 변경을 반영할 수 있다.
    /**
     이 클래스의 데이터가 변경되었음을 알려주는 중요한 메서드입니다. 
     이 메서드를 호출하면 ChangeNotifierProvider에 연결된 위젯들이 
     데이터 변경을 감지하고 필요한 경우 다시 빌드됩니다.
     */
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp을 ChangeNotifierProvider로 감싼다.
    /**
     MyData 클래스의 인스턴스를 애플리케이션의 모든 하위 위젯에서 
     공유할 수 있도록 설정하는 역할을 합니다
     */
    return ChangeNotifierProvider<MyData>(
      // 공유할 데이터를 생성
      create: (_) => MyData(), // MyData 객체를 생성하여 Provider에 등록
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // 앱이 실행되면 Page1이 로드된다.
        home: const Page1(),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
 
  late MyData myData;

  @override
  Widget build(BuildContext context) {
    /**
     * 데이터사용 : 변경에 대한 알림을 받지 않기로 설정
     *    이 경우 데이터 변경이 있더라도 즉시 build되지 않는다.
     */
    myData = Provider.of<MyData>(context, listen: false);
    debugPrint("Page1 빌드됨...");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('2페이지 추가', style: TextStyle(fontSize: 24)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
            ),
            const SizedBox(height: 50,),
            /**
             *  아래 버튼을 누르면 기존의 데이터가 변경된다. 변경을
             *  위해 공유객체의 change()를 호출한다.
             */
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                myData.change('전우치1', 30);
              },
              child: const Text('전우치로', style: TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                myData.change('홍길동1', 25);
              },
              child: const Text('홍길동으로', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 50,),
            // 처음 빌드될때의 데이터로 표시된다.
            // Provider.of를 통해 가져온 myData를 사용 
            // 처음 로드된 '홍길동 - 25'라는 값이 계속 유지
            Text(
              '${myData.name} - ${myData.age}',
              style: const TextStyle(fontSize: 30)
            ),
            
            /**
             *  데이터 사용 - 데이터 변경이 일어나면  builder에 저장된 익명함수
             *      가 호출되고 지정된 위젯만 재빌드 된다.
             */
            /**
             이때 Consumer는 변경을 감지하여 내부의 Text 위젯만 다시 빌드하므로, 
             이 텍스트 위젯은 **바뀐 데이터('전우치1 - 30' 또는 '홍길동1 - 25')**로 업데이트됩니다.
             이것이 바로 Provider.of(listen: false)와 Consumer의 가장 큰 차이점입니다.
             */
            Consumer<MyData>(
              builder: (context, myData, child) {
                debugPrint('Consumer<MyData> 여기도 빌드됨');
                return Text('${myData.name} - ${myData.age}', 
                        style: const TextStyle(fontSize: 30));
              }
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late MyData myData;

  @override
  Widget build(BuildContext context) { 
    /**
     *  데이터 사용 - 변경에 대한 알림을 받도록 설정 데이터 변경이
     *    있을 때마다 알림을 받아 페이지가 재빌드 된다.
     */
    myData = Provider.of<MyData>(context, listen: true);  // 데이터 변경 알림을 받도록 설정. 전체가 다시 실행
    debugPrint("Page2 빌드됨...");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[100],
              ),
              onPressed: () {
                Navigator.pop(context); // Page1으로 돌아갑니다.
              },
              child: const Text('2페이지 제거', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                myData.change('전우치2', 31);
              },
              child: const Text('전우치로', style: TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                myData.change('홍길동2', 26);
              },
              child: const Text('홍길동으로', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 50,),
            // 바뀐 데이터를 처리하기 위해 전체를 다시 빌드해야한다.
            /**
             Provider.of를 사용하므로, 데이터가 변경될 때마다 페이지 
             전체가 다시 빌드되어 바뀐 데이터로 업데이트됩니다.
             */
            Text(
              '${myData.name} - ${myData.age}',
              style: const TextStyle(fontSize: 30)
            ),
            // 데이터 사용 - 데이터 변경이 일어나면 bilder에 지정된 익명 함수가
            //    호출되고 지정된 위젯만 재 빌드 된다.  
            /**
             Consumer 내부의 Text 위젯은 데이터 변경 시 선택적으로 다시 빌드됩니다.
             */
            Consumer<MyData>(
              builder: (context, myData, child) {
                return Text('${myData.name} - ${myData.age}', 
                          style: const TextStyle(fontSize: 30));
              }
            ),
          ],
        ),
      ),
    );
  }
}