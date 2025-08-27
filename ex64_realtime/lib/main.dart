import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
/// 제공된 Flutter 코드는 Firebase Realtime Database를 활용하여 실시간으로 
/// 데이터를 읽고 쓰는 예제 애플리케이션입니다. 이 앱은 여러 기기에서 버튼을 
/// 누른 횟수를 실시간으로 동기화하고, 메시지 목록을 표시하며, 데이터베이스에 
/// 대한 트랜잭션과 같은 고급 기능도 보여줍니다.

// FirebaseOptions 객체를 사용하여 Firebase 앱의 설정을 코드로 직접 정의하는 것은 google-services.json 파일의 내용을 대체할 수 있습니다.
late FirebaseApp fbApp; // 아래 옵션을 대체함.
// FirebaseOptions get firebaseOptions => const FirebaseOptions(
//         appId: '1:620353347659:android:59dad6cf2cd66c93cfedce',
//         // google-service.json 파일 안에 있음
//         apiKey: 'AIzaSyD30QJKBE1da2oNnnYF9cEjriKSUlaGsAI',
//         projectId: 'flutter-study-e24cd',
//         messagingSenderId: '620353347659', // 프로젝트 번호
//       );
Future<void> main() async {
   // 이것을 넣어야 에러 없이 진행이 됨.
   // WidgetsFlutterBinding.ensureInitialized(): Flutter 엔진의 위젯 바인딩이 초기화되었는지 확인합니다. 
   // 비동기 작업(await)을 runApp 호출 전에 수행해야 할 때 반드시 필요합니다.
  WidgetsFlutterBinding.ensureInitialized(); 
  // 시간이 걸리므로 먼저 db에 붙어야 한다.
  // Firebase.initializeApp(): Firebase SDK를 초기화하고 Firebase 프로젝트에 연결합니다. 
  // 이 과정은 시간이 걸리므로 async-await를 사용합니다.
  fbApp = await Firebase.initializeApp(); 
  debugPrint('Initialized default app $fbApp');
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
      home: const MyHomePage(title: 'Ex64 Firebase Realtime'),
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
  int _counter = 0;

  late DatabaseReference _counterRef;
  late DatabaseReference _messagesRef;
  late StreamSubscription<DatabaseEvent> _counterSubscription;
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  bool _anchorToBottom = false;

  final String _kTestKey = 'Hello';
  final String _kTestValue = 'world!';
  FirebaseException? _error;

  @override
  void initState() {
    super.initState();
    // _counterRef: counter라는 경로를 가리키는 **참조(DatabaseReference)**를 만듭니다. 
    // 이 경로의 값은 앱의 모든 사용자가 버튼을 누른 횟수를 저장합니다.
    _counterRef = FirebaseDatabase.instance.ref('counter');
    // _messagesRef: messages라는 경로를 가리키는 참조를 만듭니다. 
    // 이 경로에는 사용자가 버튼을 누를 때마다 생성되는 메시지들이 저장됩니다.
    _messagesRef = FirebaseDatabase.instance.ref('messages');

    // 리스너 설정 - 데이터베이스의 값이 변하면 앱에 반영된다.
    // _counterRef.onValue.listen(): counter 경로의 데이터가 변경될 때마다 실행되는 스트림 리스너를 설정합니다. 
    // Firebase의 실시간 데이터베이스는 서버에서 데이터가 변경되면 연결된 모든 클라이언트에게 자동으로 업데이트를 보내줍니다.
    _counterSubscription = _counterRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        _counter = (event.snapshot.value ?? 0) as int;
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    _messagesSubscription =
        // _messagesRef.onChildAdded.listen(): messages 경로에 새로운 자식(메시지)이 추가될 때마다 실행되는 리스너를 설정합니다. 
        // limitToLast(10)은 최근 10개의 메시지만 구독하도록 제한합니다.
        _messagesRef.limitToLast(10).onChildAdded.listen((DatabaseEvent event) {
      debugPrint('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      final error = o as FirebaseException;
      debugPrint('Error: ${error.code} ${error.message}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }

  Future<void> _increment() async {
    // set 메서드를 사용해 counter 값을 1 증가시킵니다. 
    // ServerValue.increment(1)는 여러 클라이언트가 동시에 값을 증가시켜도 
    // 정확한 값을 보장하는 서버 측 증가 기능입니다. 
    await _counterRef.set(ServerValue.increment(1));
    // push()를 사용해 messages 경로에 고유한 키를 가진 새로운 메시지를 추가합니다.
    await _messagesRef
        .push()
        .set(<String, String>{_kTestKey: '$_kTestValue $_counter'});
  }

  Future<void> _incrementAsTransaction() async {
    try {
      final TransactionResult transactionResult =
          // 트랜잭션을 사용하여 counter 값을 증가시킵니다. 
          // 트랜잭션은 여러 사용자가 동시에 데이터를 수정하려 할 때 데이터의 **정합성(consistency)**을 보장하는 매우 중요한 기능입니다. 
          // 데이터베이스에서 현재 값을 읽고, 로컬에서 변경한 후, 다시 데이터베이스에 쓰는 일련의 과정을 원자적으로(atomic) 처리합니다.
          await _counterRef.runTransaction((mutableData) {
        return Transaction.success((mutableData as int? ?? 0) + 1);
      });

      if (transactionResult.committed) {
        final newMessageRef = _messagesRef.push();
        await newMessageRef.set(<String, String>{
          _kTestKey: '$_kTestValue ${transactionResult.snapshot.value}'
        });
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> _deleteMessage(DataSnapshot snapshot) async {
    final messageRef = _messagesRef.child(snapshot.key!);
    await messageRef.remove();
  }

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
          children: [
            Flexible(
              child: Center(
                child: _error == null
                    ? Text(
                        'Button tapped $_counter time${_counter == 1 ? '' : 's'}.\n\n'
                        'This includes all devices, ever.',
                      )
                    : Text(
                        'Error retrieving button tap count:\n${_error!.message}',
                      ),
              ),
            ),
            ElevatedButton(
              child: const Text('Increment as transaction'),
              onPressed: () async {
                await _incrementAsTransaction();
              },
            ),
            ListTile(
              title: const Text('Anchor to bottom'),
              leading: Checkbox(
                // 리스트 반전 
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() {
                      _anchorToBottom = value;
                    });
                  }
                },
                value: _anchorToBottom,
              ),
            ),
            Flexible(
              // FirebaseAnimatedList: Firebase 쿼리(_messagesRef)를 받아, 쿼리 결과에 해당하는 
              // 데이터가 추가, 삭제, 변경될 때마다 자동으로 애니메이션과 함께 목록을 업데이트하는 강력한 위젯입니다.
              child: FirebaseAnimatedList(
                key: ValueKey<bool>(_anchorToBottom),
                query: _messagesRef,
                // _anchorToBottom: 이 체크박스를 통해 FirebaseAnimatedList의 reverse 속성을 변경하여 리스트의 
                // 스크롤 방향을 제어합니다. true일 경우, 최신 메시지가 목록 하단에 표시됩니다.
                reverse: _anchorToBottom,
                // itemBuilder: FirebaseAnimatedList의 필수 속성으로, 각 데이터 스냅샷(snapshot)을 화면에 표시할 위젯으로 변환합니다. 
                // 여기서는 ListTile을 반환하며, 각 메시지 옆에 삭제 버튼(IconButton)을 제공합니다.
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () => _deleteMessage(snapshot),
                        icon: const Icon(Icons.delete),
                      ),
                      title: Text(
                        '$index: ${snapshot.value.toString()}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}