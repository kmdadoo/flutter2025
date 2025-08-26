import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
/// sqflite 패키지를 사용하여 SQLite 데이터베이스를 다루는 예제입니다. 
/// 특히, 앱을 처음 실행할 때 미리 준비된 SQLite DB 파일(original.db)을 
/// 앱의 내부 저장소로 복사하여 사용하는 기능을 중점적으로 보여주고 있습니다.
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
      home: const MyHomePage(title: 'Ex58 Sqlite #2'),
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
  // 데이터베이스 객체 선언
  // 데이터베이스 객체를 담을 변수를 선언합니다. 
  // late 키워드는 변수가 나중에 초기화될 것을 보장합니다.
  late Future<Database> database;

  // 위젯이 처음 생성될 때 호출되는 메서드입니다. 
  // 여기서 getDB() 함수를 호출하여 데이터베이스를 비동기적으로 초기화합니다.
  @override
  void initState() {
    super.initState();
    database = getDB();
  }

  // DB가 존재하지 않는 경우, 미리 준비한 DB를 복사하여 사용
  // 테스트시 에러가 발생하면 DB가 만들어지므로 앱을 삭제하고 다시 테스트

  // getDB() 함수: 앱 내부에 미리 포함된 DB 파일을 복사하는 함수
  Future<Database> getDB() async {
    // 시스템(루트)경로를 얻어온 후 mytest.db를 찾는다.
    var databasesPath = await getDatabasesPath(); // getDatabasesPath()를 사용하여 앱의 내부 저장소 경로를 얻습니다.
    // join() 함수로 경로와 파일 이름(mytest.db)을 합칩니다
    var path = join(databasesPath, 'mytest.db');
    // databaseExists(path)를 통해 해당 경로에 DB 파일이 이미 존재하는지 확인합니다
    var exists = await databaseExists(path); 
    // mytest.db가 없다면 우리가 준비한 db를 사용한다.
    if (!exists) {  //  존재하지 않는 경우 아래실행
      //  DB 파일이 존재하지 않는 경우, 아래의 로직을 실행
      try {
        // 데이터베이스 파일을 저장할 폴더가 없을 경우, 새로운 폴더를 생성
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // rootBundle.load(): assets/database/original.db에 있는 DB 파일을 읽어옵니다. 
      var data = await rootBundle.load(join('assets/database', 'original.db'));
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      // File(path).writeAsBytes(bytes, flush: true): 읽어온 데이터를 
      // 바이트 배열 형태로 앱의 내부 저장소(mytest.db)에 복사합니다.
      await File(path).writeAsBytes(bytes, flush: true);
    }
    // 데이터베이스 파일을 오픈합니다.
    // 복사가 완료되거나 이미 파일이 존재하는 경우, 
    // 최종적으로 해당 DB 파일을 열어 Database 객체를 반환합니다.
    return await openDatabase(path);
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
              child: const Text(
                'select',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => doSelectAll(),
            ),
          ],
        ),
      ),
    );
  }

  void doSelectAll() async {
    // 데이터베이스 reference를 얻기. 초기화된 데이터베이스 객체를 비동기적으로 가져옵니다.
    final Database db = await database;
    // family 테이블의 모든 데이터를 조회하는 SQL 쿼리를 실행합니다.
    List<Map> datas = await db.rawQuery('select * from family');
    if (datas.isNotEmpty) {
      for (int i = 0; i < datas.length; i++) {
        String name = datas[i]['name'];
        int age = datas[i]['age'];
        String relation = datas[i]['relation'];

        debugPrint('$name $age $relation');
      }
    } else {
      debugPrint('SelectAll : 데이터가 없습니다. ');
    }
  }
}
