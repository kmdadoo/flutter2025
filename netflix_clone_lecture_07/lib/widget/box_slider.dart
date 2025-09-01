import 'package:flutter/material.dart';
import 'package:netflixex/model/model_movie.dart';
import 'package:netflixex/screen/detail_screen.dart';

/// BoxSlider 위젯과 makeBoxImages 함수를 정의하며, 넷플릭스 앱과 같은 
/// 서비스에서 흔히 볼 수 있는 가로 스크롤 형태의 영화 포스터 목록을 만드는 데 사용됩니다.


class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  const BoxSlider({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('지금 뜨는 콘텐츠'),
          Container(
            color: const Color.fromARGB(255, 164, 241, 39),
            height: 120,
            child: ListView(
              // ListView의 스크롤 방향을 가로로 설정
              scrollDirection: Axis.horizontal,
              children: makeBoxImages(context, movies),
            ),
          )
        ],
      ),
    );
  }
}

// 박스형 이미지 리스트 생성: movies 리스트를 순회하며 각 영화에 대한 이미지 위젯을 만듭니다.
List<Widget> makeBoxImages(BuildContext context, List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(InkWell(
      // 사용자가 영화 포스터를 탭하면 DetailScreen이라는 상세 페이지가 아래에서 위로 스르륵 올라오면서 표시되는 기능을 구현
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(
                movie: movies[i],
              );
            }));
      },
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset('assets/images/${movies[i].poster}'),
        ),
      ),
    ));
  }
  return results;
}
//  이 코드는 ListView의 가로 스크롤 기능과 **Image.asset**을 결합하여, 
// 넷플릭스 앱의 '지금 뜨는 콘텐츠' 섹션과 유사한 UI 컴포넌트를 구현하고 있습니다.