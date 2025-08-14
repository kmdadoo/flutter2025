import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  final String data;
  const Page2({super.key, required this.data});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late String _data = '';

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }
  @override
  Widget build(BuildContext context) {
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
                backgroundColor: Colors.purple.shade100,
              ),
              onPressed: () {
                // 현재 페이지를 내비게이터 스택에서 제거
                Navigator.pop(context, '2페이지에서 보냄 (Pop)'); // 이전 페이지(Page1)로 전달되는 데이터
              },
              child: const Text('2페이지 제거', style: TextStyle(fontSize: 24)),
            ),
            // _data 변수의 값을 화면에 출력합니다. 이 데이터는 Page1에서 Page2로 전달한 값입니다.
            Text(_data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}