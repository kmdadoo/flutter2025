import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
/// 이 코드는 Flutter 앱과 Cloud Firestore를 연동하여 기본적인 데이터 작업을 수행하는 예제입니다. 
/// 사용자가 입력 필드에 숫자를 넣고 버튼을 누르면, 해당 번호를 가진 회원 정보를 Firestore에 
/// 추가, 조회, 수정, 삭제하는 기능을 구현하고 있습니다.
late FirebaseApp fbApp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  // 비동기 초기화 작업이 정상적으로 수행되도록 도와줍니다.
  fbApp = await Firebase.initializeApp(); // Firebase SDK를 초기화
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
      home: const MyHomePage(title: 'Ex65 Firestore'),
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
  late CollectionReference members;
  int seqNum = 0;
  final ctlMyText1 = TextEditingController();

  @override
  //  Firestore의 members 컬렉션에 대한 참조를 설정
  void initState() {
    super.initState();
    // Firestore에 있는 members라는 데이터 저장소에 접근하게 됩니다.
    members = FirebaseFirestore.instance.collection('members');
    // print(members);
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
          children: <Widget>[
            ElevatedButton(
              child: const Text('회원정보 추가', style: TextStyle(fontSize: 24)),
              onPressed: () => doInsert(),
            ),
            SizedBox(
              // TextField 의 너비를 외부에서 지정
              width: 240,
              child: TextField(
                controller: ctlMyText1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: const Text('회원정보 조회', style: TextStyle(fontSize: 24)),
              onPressed: () => doSelectOne(),
            ),
            ElevatedButton(
              child: const Text('회원정보 수정', style: TextStyle(fontSize: 24)),
              onPressed: () => doUpdate(),
            ),
            ElevatedButton(
              child: const Text('회원정보 삭제', style: TextStyle(fontSize: 24)),
              onPressed: () => doDelete(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> doInsert() async {
    // 회원 정보를 firestore 문서로 추가
    String sNum = ctlMyText1.text;

    // int nNum = int.parse(sNum);
    // String sId = 'member$nNum';

    // 좀더 안전하게 코딩을 하려면
    // 1. 숫자로 안전하게 변환을 시도합니다.
    int? nNum = int.tryParse(sNum);
    // 2. 만약 변환에 실패했다면 (입력값이 숫자가 아니라면)
    if (nNum == null) {
      debugPrint('유효한 숫자를 입력해 주세요.');
      // 사용자에게 오류 메시지를 보여주는 UI를 추가할 수 있습니다.
      return; // 더 이상 코드를 진행하지 않고 함수를 종료합니다.
    }
    // 3. 변환에 성공했다면 나머지 로직을 실행합니다.
    String sId = 'member$nNum';
    debugPrint(sId);
    
    await members.doc(sId).get();
    // members.doc(sId).set({...})를 호출해 해당 ID의 문서에 회원 정보(비밀번호와 이메일)를 추가합니다. 
    // 만약 문서가 이미 존재하면 기존 데이터는 덮어쓰여집니다.
    members.doc(sId).set({
      'pw': '1234',
      'email': 'test1@test.com',
    });
  }

  void doSelectOne() async {
    // 회원 정보를 검색
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member$nNum';

    // members.doc(sId).get()를 사용해 Firestore에서 해당 문서의 데이터 스냅샷을 가져옵니다.
    var documentSnapshot = await members.doc(sId).get();
    // documentSnapshot.data()가 null이 아니면(즉, 문서가 존재하면) get('필드명')을 통해 필드 값을 가져와 출력합니다.
    if (documentSnapshot.data() != null) {
      String pw = documentSnapshot.get('pw');
      String email = documentSnapshot.get('email');
      debugPrint('pw : $pw');
      debugPrint('email : $email');
    } else {
      debugPrint('회원 정보가 존재하지 않습니다.');
    }
  }

  // 회원정보 수정
  Future<void> doUpdate() async {
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member$nNum';

    var documentReference = await members.doc(sId).get();
    if (documentReference.data() != null) {
      // members.doc(sId).update({...})를 호출하여 문서의 특정 필드(email)를 새로운 값으로 업데이트합니다.
      members.doc(sId).update({
        // 'pw' : '0000',
        'email': 'xxxx@test.com',
      });
    } else {
      debugPrint('회원 정보가 존재하지 않습니다.');
    }
  }

  // 회원정보 삭제
  Future<void> doDelete() async {
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member$nNum';

    var documentReference = await members.doc(sId).get();
    if (documentReference.data() != null) {
      //members.doc(sId).delete()를 호출하여 Firestore에서 해당 문서를 영구적으로 삭제합니다.
      var documentReference = members.doc( sId );
      documentReference.delete();
    } else {
      debugPrint('회원 정보가 존재하지 않습니다.');
    }
  }
}