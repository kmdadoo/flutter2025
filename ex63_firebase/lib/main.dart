import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// 제공된 Flutter 코드는 Firebase 앱을 초기화하고 관리하는 기능을 보여주는 예제입니다. 
/// 이 코드는 Firebase의 여러 기능을 다루기보다는, Firebase 앱 인스턴스를 다루는 기본 원리에 초점을 맞추고 있습니다.
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
      home: const MyHomePage(title: 'Ex63 Firebase'),
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
  String name = '';  // 현재 다루고 있는 앱의 이름을 저장하는 변수

  // Firebase 앱 초기화에 필요한 설정 정보를 정의합니다.
  // 이 정보는 보통 `google-services.json` 파일에서 가져옵니다.
  // 이 코드는 예시이므로 실제 프로젝트에서는 `Firebase.initializeApp()`만 사용해도 충분합니다.
  // 이 예제에서는 두 번째 앱을 수동으로 초기화하기 위해 별도의 `FirebaseOptions`를 정의했습니다.
  FirebaseOptions get firebaseOptions => const FirebaseOptions(
        appId: '1:620353347659:android:59dad6cf2cd66c93cfedce',
        // google-service.json 파일 안에 있음
        apiKey: 'AIzaSyD30QJKBE1da2oNnnYF9cEjriKSUlaGsAI',
        projectId: 'flutter-study-e24cd',
        messagingSenderId: '620353347659', // 프로젝트 번호
      );

  // 기본 Firebase 앱을 초기화합니다.
  // 이 코드는 인자 없이 호출되어 기본(default) Firebase 앱을 초기화합니다.
  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    name = app.name;
    debugPrint('Initialized default app $app');
  }

  // 두 번째(보조) Firebase 앱을 초기화합니다.
  // 이 코드는 name과 options 인자를 사용하여 두 번째(secondary) Firebase 앱을 초기화합니다. 
  // 이는 하나의 앱 내에서 여러 개의 Firebase 프로젝트를 연결할 때 유용합니다. 
  // 여기서는 myFcm이라는 이름으로 앱을 초기화합니다.
  Future<void> initializeSecondary() async {
    name = 'myFcm';
    FirebaseApp app =
        await Firebase.initializeApp(name: name, options: firebaseOptions);
    debugPrint('Initialized $app');
  }

  // 현재 초기화된 모든 Firebase 앱 목록을 확인합니다.
  // 현재는 하나이지만 여러 개를 사용할 경우 : FCM, Strorage, Ayth ...
  void apps() {
    // Firebase.apps는 현재 초기화된 모든 Firebase 앱 인스턴스 목록을 반환합니다. 
    // 이를 통해 앱 내에서 어떤 Firebase 프로젝트들이 활성화되어 있는지 확인할 수 있습니다.
    final List<FirebaseApp> apps = Firebase.apps;
    debugPrint('Currently initialized apps: $apps');
  }

  // 특정 Firebase 앱의 설정 정보를 확인합니다.
  void options() {
    // Firebase.app(name)를 사용해 특정 이름(myFcm)의 앱 인스턴스를 가져온 다음, 
    // .options 속성을 통해 해당 앱의 설정 정보를 확인할 수 있습니다.
    final FirebaseApp app = Firebase.app(name);
    final FirebaseOptions options = app.options;
    debugPrint('Current options for app $name: $options');
  }

  // 앱 인스턴스를 삭제하여 메모리를 정리하고, 더 이상 해당 인스턴스를 사용하지 않을 때 호출합니다.
  Future<void> delete() async {
    final FirebaseApp app = Firebase.app(name);
    await app.delete();
    debugPrint('App $name deleted');
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
              onPressed: initializeDefault,
              child: const Text('Initialize default app'),
            ),
            ElevatedButton(
              onPressed: initializeSecondary,
              child: const Text('Initialize secondary app'),
            ),
            ElevatedButton(
              onPressed: apps,
              child: const Text('Get apps'),
            ),
            ElevatedButton(
              onPressed: options,
              child: const Text('List options'),
            ),
          ],
        ),
      ),
    );
  }
}
// 이 코드는 실제 Firebase 서비스를 사용하는 것(예: Firestore 데이터베이스에 접근)과는 별개로, 
// Firebase 앱 인스턴스 자체를 어떻게 다루는지를 시연하는 예제입니다. 기본 앱과 보조 앱을 
// 초기화하고, 목록을 확인하며, 설정을 조회하는 과정을 통해 firebase_core 패키지의 핵심 
// 기능들을 이해하는 데 도움을 줍니다.