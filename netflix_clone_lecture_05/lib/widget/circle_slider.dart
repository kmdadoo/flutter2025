import 'package:flutter/material.dart';
import 'package:netflixex/model/model_movie.dart';

///  **CircleSlider**라는 이름의 Flutter 위젯과 makeCircleImages 함수를 정의합니다. 
/// 이 위젯은 넷플릭스 앱에서 흔히 볼 수 있는 동그란 형태의 미리보기 이미지 슬라이더를 만듭니다.


class CircleSlider extends StatelessWidget {
  final List<Movie> movies;
  const CircleSlider({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    return Container(
      // 전체 위젯의 외부 여백을 설정
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('미리보기'), // 슬라이더의 제목을 표시
          // ListView의 배경색과 높이를 지정합니다. 
          // 여기서는 배경색을 녹색으로 지정해 개발 중인 영역임을 쉽게 알아볼 수 있게 했습니다.
          Container(
            color: const Color.fromARGB(255, 29, 249, 69),
            height: 120,
            child: ListView(
              // ListView의 스크롤 방향을 가로로 설정
              scrollDirection: Axis.horizontal,
              // makeCircleImages 함수를 호출하여 반환된 위젯 리스트를 자식으로 가집니다.
              children: makeCircleImages(context, movies),
            ),
          ),
        ],
      ),
    );
  }
}

// 원형 이미지 리스트 생성: movies 리스트를 순회하며 각 영화에 대한 원형 이미지 위젯을 만듭니다.
List<Widget> makeCircleImages(BuildContext context, List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(
      InkWell(
        onTap: () {},
        child: Container(
          // 각 원형 이미지의 오른쪽 여백을 줍니다.
          padding: EdgeInsets.only(right: 10),
          child: Align(
            // CircleAvatar를 컨테이너의 왼쪽 중앙에 정렬
            alignment: Alignment.centerLeft,
            child: CircleAvatar(  // 원형 이미지 위젯
              // AssetImage(...): 영화 데이터의 poster 이름을 사용하여 로컬 assets 폴더에서 이미지를 불러옵니다.
              backgroundImage: AssetImage('assets/images/${movies[i].poster}'),
              radius: 48, // 원의 반지름을 설정
            ),
          ),
        ),
      ),
    );
  }
  return results;
}
// 이 코드는 ListView의 가로 스크롤 기능과 CircleAvatar의 원형 이미지 표현 
// 기능을 결합하여, 넷플릭스 앱의 '미리보기'와 유사한 UI 컴포넌트를 구현하고 있습니다.