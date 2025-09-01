import 'package:flutter/material.dart';

// 앱 화면 하단에 표시되는 **탭 바(Tab Bar)**를 정의합니다. 
// 넷플릭스와 같은 앱에서 자주 볼 수 있는 하단 내비게이션 바의 역할을 합니다.

// class Bottom extends StatelessWidget: StatelessWidget을 상속받아, 
// 이 위젯이 상태를 가지지 않고 단순히 UI만 그리는 역할을 한다는 것을 명시합니다.
class Bottom extends StatelessWidget {
  const Bottom({super.key});

  // 위젯의 UI를 실제로 구성하는 메서드
  @override
  Widget build(BuildContext context) {
    // 탭 바의 전체적인 영역을 감싸는 위젯
    return Container(
      color: Colors.black,  // 배경색을 검정색으로 설정
      child: SizedBox(  // TabBar의 크기를 고정
        height: 50, // 탭 바의 높이
        child: const TabBar(
          labelColor: Colors.white, // 아이콘과 텍스트 색상
          // 선택되지 않은 탭의 색상을 반투명한 흰색
          unselectedLabelColor: Colors.white60, 
          // 탭을 선택했을 때 하단에 나타나는 표시줄(indicator)을 투명하게 만들어 보이지 않게 합니다.
          indicatorColor: Colors.transparent,
          // 탭에 들어갈 위젯들을 리스트로 정의
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home, // 아이콘을 설정
                size: 18,
              ),
              child: Text(  // 텍스트를 설정
                '홈',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.search,
                size: 18,
              ),
              child: Text(
                '검색',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.save_alt,
                size: 18,
              ),
              child: Text(
                '저장한 목록',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.list,
                size: 18,
              ),
              child: Text(
                '더보기',
                style: TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}