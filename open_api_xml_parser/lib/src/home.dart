import 'package:flutter/material.dart';
import 'package:open_api_xml_parser/src/ui/list.dart';

// Flutter 앱의 Home 위젯을 정의합니다. 아주 간단한 구조로, 화면 전체를 차지하는 
// Scaffold 위젯 안에 **ListWidget**이라는 다른 위젯을 넣는 역할을 합니다.
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWidget(),
    );
  }
}
// 코드는 앱의 홈 화면을 **Scaffold**라는 기본적인 레이아웃으로 만들고, 
// 그 화면의 주요 내용으로 **ListWidget**이라는 목록 형태의 UI를 표시하는 간단한 구조를 보여줍니다.