import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflixex/model/model_movie.dart';
import 'package:netflixex/screen/detail_screen.dart';

/// CarouselImage 위젯과 makeIndicator 함수를 정의합니다. 
/// 이 위젯은 넷플릭스 홈 화면의 상단에 있는 **이미지 캐러셀(슬라이더)**을 구현하며, 
/// 사용자가 탭을 넘길 때마다 UI가 변경되는 동적인 기능을 포함합니다.

// class CarouselImage extends StatefulWidget: 이 위젯은 사용자의 스와이프에 따라 
// 상태(_currentPage, _currentKeyword)가 변하므로 **StatefulWidget**으로 정의되었습니다.
class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key, required this.movies});
  
  final List<Movie> movies;

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List<Movie>? movies;
  List<Widget>? images;
  List<String>? keywords;
  List<bool>? likes;
  int _currentPage = 0;
  late String _currentKeyword;

  @override
  void initState() {  // 위젯이 처음 생성될 때 한 번 호출
    super.initState();
    // movies = widget.movies: 부모 위젯에서 전달받은 movies 데이터를 클래스 변수에 저장합니다.
    movies = widget.movies;
    // images = movies?.map(...): movies 리스트의 각 항목을 순회하며 Image.asset 위젯으로 변환하여 images 리스트에 저장합니다.
    images = movies?.map((m) => Image.asset('assets/images/${m.poster}')).toList();
    // keywords와 likes도 마찬가지로 movies 데이터에서 추출하여 리스트에 저장합니다.
    keywords = movies?.map((m) => m.keyword).toList();
    likes = movies?.map((m) => m.like).toList();
    _currentKeyword = keywords![0];
  }

  @override
  Widget build(BuildContext context) {  // 화면을 그리는 메서드
    return Container(
      color: Colors.black,
      // 위젯들을 세로로 정렬합니다. CarouselSlider, 키워드 텍스트, 버튼 Row, 인디케이터 Row를 차례로 배치합니다.
      child: Column(  
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider(
            // items: images: 슬라이드할 이미지 위젯 리스트를 제공합니다.
            items: images,
            // options: CarouselOptions: 캐러셀의 동작을 설정합니다. 
            // onPageChanged는 페이지가 바뀔 때마다 실행되는 콜백 함수입니다.
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                // setState(() { ... }): onPageChanged 내부에서 setState를 호출하여 
                // _currentPage와 _currentKeyword를 업데이트합니다. 
                // 이로 인해 화면이 자동으로 다시 그려지면서 새로운 키워드가 표시됩니다.
                setState(() {
                  _currentPage = index;
                  _currentKeyword = keywords![_currentPage];
                });
              }, 
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 163, 157, 157),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly: 자식 위젯들을 균등한 간격으로 배치합니다.
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  color: const Color.fromARGB(255, 242, 118, 118),
                  child: Column(
                    children: <Widget>[
                      // likes![_currentPage]의 값(true/false)에 따라 '체크'(Icons.check) 아이콘과 
                      // '추가'(Icons.add) 아이콘을 조건부로 표시합니다.
                      likes![_currentPage]
                          ? IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {},
                            )
                          : IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {},
                            ),
                      Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
                // 흰색 배경에 재생 아이콘과 '재생' 텍스트가 있는 TextButton입니다.
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.white
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text(
                          '재생',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                // '정보' 버튼: 정보 아이콘과 '정보' 텍스트를 표시합니다.
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.info),
                        // etailScreen이라는 새로운 화면을 아래에서 위로 띄우는 애니메이션과 함께 표시하는 기능을 구현합니다.
                        onPressed: () {
                          // MaterialPageRoute: Flutter에서 머티리얼 디자인 기반의 화면 전환 효과를 제공하는 클래스입니다.
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                            // fullscreenDialog: true 속성은 새로운 화면이 아래에서 위로 올라오도록 화면 전환 애니메이션을 설정합니다. 
                            // 이는 모달(Modal) 창처럼 동작하며, 주로 정보를 자세히 보여주거나 특정 작업을 수행할 때 사용됩니다.
                            fullscreenDialog: true,
                            builder: (BuildContext context) {
                              // DetailScreen 위젯을 반환
                              // DetailScreen: 영화의 상세 정보를 보여주는 화면 위젯입니다. 
                              // 현재 캐러셀에서 보고 있는 영화 데이터(movies![_currentPage])를 이 위젯에 전달합니다.
                              return DetailScreen(
                                movie: movies![_currentPage],
                              );
                            }));
                        },
                      ),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 77, 77, 227),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center: 인디케이터들을 가운데로 정렬합니다.
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes!, _currentPage),
            ),
          )
        ],
      ),
    );
  }
}
// 현재 페이지 하이라이트: _currentPage와 현재 반복문의 인덱스(i)가 같으면, 
// 원의 색상을 불투명한 흰색(0.9)으로 만들어 현재 페이지임을 강조하고, 
// 그렇지 않으면 반투명한 흰색(0.4)으로 만듭니다.
List<Widget> makeIndicator(List list, int currentPage) {
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentPage == i
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    ));
  }

  return results;
}
/**
 코드는 **StatefulWidget**과 **CarouselSlider**를 활용하여 사용자의 상호작용에 반응하는 동적인 UI를 구현합니다. 
 이미지, 텍스트, 아이콘 버튼, 페이지 인디케이터가 하나의 캐러셀 컴포넌트로 통합되어 넷플릭스 앱의 상단 홈 화면을 효과적으로 재현하고 있습니다.
 */