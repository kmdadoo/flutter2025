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
      home: const MyHomePage(title: 'Ex12 Text Field #1'),
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
  String _myText = '홍길동';
  // TextField 위젯을 제어하는 데 사용되는 변수
  final ctlMyText1 = TextEditingController();

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _myText,
              style: const TextStyle(
                fontSize: 30.0,
              ),
            ),
            
            // 택스트 필드에 가로사이즈는 SizedBox를 통해 설정
            SizedBox(  
              width: 280,
              // 사용자가 텍스트를 입력할 수 있는 위젯
              child: TextField(  
                // controller 속성에 ctlMyText1을 할당하여, 이 TextEditingController를 
                // 통해 TextField의 내용을 읽고 쓸 수 있게 됩니다.
                controller: ctlMyText1,
              ),
            ),
            ElevatedButton(
                child: const Text('Text 입력버튼',
                    style: TextStyle(fontSize: 24)),
                onPressed: () {
                  // 입력한 텍스트로 상태를 변경하면서 렌더링을 다시한다.
                  setState(() {
                    /*
                      TextField의 값을 불러오고 싶으땐, TextField.value가 아니고
                      ctlMyText1.text로 접근하면 됩니다.
                      _myText 변수에 ctlMyText1.text의 값을 할당 TextEditingController의 
                      text 속성을 통해 TextField에 입력된 텍스트를 가져올 수 있습니다.
                     */
					          _myText = ctlMyText1.text;
                  });
                }),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        // 플로팅 버튼을 통해 초기상태로 변경한다.
        onPressed: () {
          setState(() {
            _myText = '홍길동';
          });
        },
        child: const Icon(Icons.access_time_filled),
      ),
    );
  }
}
