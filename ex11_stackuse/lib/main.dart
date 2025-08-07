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
      home: const MyHomePage(title: 'Ex11 Stackuse'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getStack1(),
            const SizedBox(height: 10,),
            getStack2(),
            const SizedBox(height: 10,),
            getStack3(),
            const SizedBox(height: 10,),
            getStack4(),
          ],
        ),
      ),
    );
  }

  // 가장 기본적인 Stack 사용법
  Widget getStack1(){
    return Stack(
      // fit: StackFit.expand,
      // alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: 120,
          height: 120,
          color: Colors.red,
        ),
        Container(    // 크기만 지정하였을 때는 좌측 상단 시작 지점 같음. alignment 주석처리했을때
          width: 60,
          height: 60,
          color: Colors.blue,
        ),
      ],
    );
  }

  // Positioned 위젯을 사용하여 자식의 위치를 정확하게 제어하는 방법을 보여줍니다.
  Widget getStack2(){
    return Stack(
      // fit: StackFit.expand,
      // alignment: AlignmentDirectional.bottomCenter,  
      children: [
        Container(
          width: 120,
          height: 120,
          color: Colors.red,
        ),
        Positioned(   // 시작위치를 바꿀때 사용
          top: 30,
          left: 30,
          child: Container(
            width: 60,
            height: 60,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  // Positioned 위젯의 크기 설정이 자식 위젯의 크기보다 우선하는 것을 보여줍니다.
  Widget getStack3(){
    return Stack(
      // fit: StackFit.expand,
      // alignment: AlignmentDirectional.bottomCenter,  
      children: [
        Container(
          width: 120,
          height: 120,
          color: Colors.red,
        ),
        Positioned(   // 시작위치를 바꿀때 사용
          top: 30,
          left: 30,
          // 아래의 container의 크기가 무시된다. 위 부모보다 큰 크기는 짤린다.
          width: 120,
          height: 120,
          child: Container(
            width: 60,
            height: 60,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  // Stack의 clipBehavior 속성을 사용하여 자식 위젯이 부모의 경계를 벗어나는 경우를 제어하는 방법을 보여줍니다.
  Widget getStack4(){
    return Stack(
      // 자식 위젯이 부모의 경계를 벗어나도 잘리지 않고 온전히 표시
      clipBehavior: Clip.none, // 기본은 hardEdge
      // fit: StackFit.expand,
      // alignment: AlignmentDirectional.bottomCenter,  
      children: [
        Container(
          width: 120,
          height: 120,
          color: Colors.red,
        ),
        Positioned(   // 시작위치를 바꿀때 사용
          top: 30,
          left: 30,
          width: 120,
          height: 120,
          // 아래의 container의 크기가 무시된다. 위 부모보다 큰 크기는 짤린다.
          // clipBehavior로 전체를 다 표현 할 수 있다.
          child: Container(
            width: 60,
            height: 60,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
