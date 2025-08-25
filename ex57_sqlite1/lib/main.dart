import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
      home: const MyHomePage(title: 'Ex57 Sqlite #1'),
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
  // sqlite 사용을 위한 데이터베이스 객체 생성
  late Future<Database> database;
  int seqNum = 0;
  // 텍스트필드에 입려된 내용을 얻어오기 위한 컨트롤러
  final ctlMyText1 = TextEditingController();

  @override
  // createDatabase() 함수를 호출하여 데이터베이스를 초기화
  void initState() {
    super.initState();
    // 앱이 최초 시작될때 데이터베이스 생성
    createDatabase();
  }

  // openDatabase() 함수를 사용하여 'telbook.db'라는 SQLite 데이터베이스 파일을 생성하거나 엽니다.
  void createDatabase() async {
    database = openDatabase(
       // 각 플랫폼 별로 데이터베이스 경로 생성
      // `path` 패키지의 `join` 함수를 사용
      // join(await getDatabasesPath(), 'telbook.db')를 통해 각 플랫폼(Android, iOS 등)에 맞는 
      // 적절한 경로에 데이터베이스 파일을 생성합니다.
      join(await getDatabasesPath(), 'telbook.db'),
      // 데이터베이스가 처음 생성될 때 테이블 생성.
      onCreate: (db, version) {
        return db.execute(  // telbook이라는 이름의 테이블을 생성
          "CREATE TABLE telbook(id INTEGER PRIMARY KEY, name TEXT, telnum TEXT)",
        );
      },
      // onCreate 함수에 DB 업그레이드와 다운그레이드를 위한 경로 제공
      version: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Insert',
                                  style: TextStyle(fontSize: 24)),
                onPressed: () => doInsert(),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                child: const Text('Select All',
                                  style: TextStyle(fontSize: 24)),
                onPressed: () => doSelectAll(),
              ),
              const SizedBox(height: 10,),
              SizedBox(     // TextField 의 너비를 외부에서 지정
                width: 240,
                child: TextField(
                  controller: ctlMyText1,
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                child: const Text('Select One',
                                  style: TextStyle(fontSize: 24)),
                onPressed: () {
                  // 텍스트 필드에 입력된 내용(일련번호)을 얻어 온다.
                  var sNum = ctlMyText1.text;
                  // 얻어온 내용을 int형으로 변환한다.
                  int nNum = int.parse(sNum);
                  doSelectOne(nNum);
                },
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                child: const Text('Update',
                                  style: TextStyle(fontSize: 24)),
                onPressed: () {
                  var sNum = ctlMyText1.text;
                  int nNum = int.parse(sNum);
                  doUpdate(nNum);
                },
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                child: const Text('Delete',
                                  style: TextStyle(fontSize: 24)),
                onPressed: () {
                  var sNum = ctlMyText1.text;
                  int nNum = int.parse(sNum);
                  doDelete(nNum);
                },
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                child: const Text('Delete All',
                                  style: TextStyle(fontSize: 24)),
                onPressed: () => doDeleteAll(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 전체 레코드 조회. telbook 테이블의 모든 레코드를 조회
  void doSelectAll() async {
    // 데이터베이스 reference를 얻기
    final Database db = await database;
    // select한 결과는 List로 반환한다.
    List<Map> datas = await db.rawQuery('select * from telbook');
    /**
     *  컬렉션에 어떤 것이 포함되어 있는지 확인하기 위해 호출 lenth하는 것은 
     * 매우 느릴 수 있습니다. 대시 더 빠르고 더 읽기 쉬운 게터가 있습니다.:
     * isEmpty 및 isNotEmpty. 결과를 부정할 필요가 없는 것을 사용하십시오
     */
    if (datas.isNotEmpty) {     
      for (int i=0; i<datas.length; i++) {
        // 각 레코드는 인덱스i 를 통해 접근하여 컬럽명으로 값을 얻어온다.
        int id = datas[i]['id'];
        String name = datas[i]['name'];
        String telnum = datas[i]['telnum'];

        debugPrint('$id $name $telnum');
      }
    } 
    else {
      debugPrint('SelectAll : 데이터가 없습니다.');
    }
  }

  // 하나의 레코드 조회
  void doSelectOne(int num) async {
    // 데이터베이스 reference를 얻기
    final Database db = await database;

    List<Map> data = await db.rawQuery('select * from telbook where id = $num');
    // print(data);
    if (data.isNotEmpty) {
      int id = data[0]['id'];
      String name = data[0]['name'];
      String telnum = data[0]['telnum'];

      debugPrint('$id $name $telnum');
    } 
    else {
      debugPrint('SelectOne : 데이터가 없습니다.');
    }
  }

  // 새로운 레코드 입력
  Future<void> doInsert() async {
    final Database db = await database;
    // 시퀀스로 사용할 변수
    seqNum = seqNum + 1;
    var telnum = '010-1234-$seqNum$seqNum$seqNum$seqNum';

    // 쿼리문은 인파라미터 ? 가 있는 형태로 작성한다.
    int count = await db.rawInsert(
      'insert into telbook (id, name, telnum) values (?, ?, ?)',
      [seqNum, '홍길동$seqNum', telnum]);
    
    debugPrint('Insert : $count');
  }

  // 레코드 수정
  Future<void> doUpdate(int id) async {
    final db = await database;

    int count = await db.rawUpdate(
      'update telbook set name = ?, telnum = ? where id = ?',
      ['손오공', '010-1234-xxxx', id]);
    
    debugPrint('Update : $count');
  }

  // 레코드 삭제
  Future<void> doDelete(int id) async {
    final db = await database;

    int count = await db.rawDelete(
      'delete from telbook where id = ?', [id]);

    debugPrint('Delete : $count');
  }

  // 전체 데이터 삭제
  Future<void> doDeleteAll() async {
    final db = await database;
    int count = await db.rawDelete('delete from telbook');
    debugPrint('DeleteAll : $count');
  }
}