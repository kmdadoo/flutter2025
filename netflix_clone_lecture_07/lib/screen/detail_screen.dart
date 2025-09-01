import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:netflixex/model/model_movie.dart';

/// 사용자가 선택한 영화의 상세 정보 화면을 보여주는 역할을 합니다. 
/// 넷플릭스 앱의 상세 페이지와 유사한 UI를 구현하고 있습니다.

class DetailScreen extends StatefulWidget {
  // 영화 데이터를 저장하는 변수
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;
  // initState() 메서드: 위젯이 처음 생성될 때 실행됩니다. 
  // 부모 위젯에서 받은 영화 데이터의 like 상태를 like 변수에 초기값으로 설정합니다.
  @override
  void initState() {
    super.initState();
    like = widget.movie.like;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 145, 196, 16),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(  // 여러 위젯을 겹쳐서 배치
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      // DecorationImage로 영화 포스터 이미지를 배경으로 넣습니다
                      image: DecorationImage(
                        image: AssetImage('assets/images/${widget.movie.poster}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // **ClipRect**와 BackdropFilter: 이 두 위젯을 함께 사용해 배경 이미지에 블러 효과를 적용합니다. 
                    // sigmaX와 sigmaY는 블러의 강도를 조절합니다.
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          alignment: Alignment.center,
                          // 반투명한 검은색(Colors.black.withValues(alpha: 0.1)) 오버레이를 씌워 이미지를 더 어둡게 만듭니다.
                          color: Colors.black.withValues(alpha: 0.1),
                          child: Container(
                            color: const Color.fromARGB(255, 219, 134, 5),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                  height: 300,
                                  // 중앙에 원본 영화 포스터를 다시 표시
                                  child: Image.asset(
                                      'assets/images/${widget.movie.poster}'),
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  // 영화의 제목과 간단한 정보를 표시
                                  child: Text(
                                    '99% 일치 2019 15+ 시즌 1개',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    widget.movie.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  // 빨간색 '재생' 버튼을 만듭니다. WidgetStateProperty.all을 사용하여 버튼의 배경색을 설정합니다.
                                  child: TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        Colors.red,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.play_arrow),
                                        Text('재생'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(widget.movie.toString()),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '출연: 현빈, 손예진, 서지혜\n제작자: 이정효, 박지은',
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Stack 안에서 AppBar의 위치를 지정
                  Positioned(
                    //  투명하고 그림자가 없는 앱바를 만들어 배경 이미지와 자연스럽게 어우러지게 합니다.
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.black26,
                child: Row( // 하단 버튼
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            // 영화의 like 상태에 따라 '체크'(check) 아이콘 또는 '추가'(add) 아이콘을 조건부로 표시합니다.
                            like ? Icon(Icons.check) : Icon(Icons.add),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              '내가 찜한 콘텐츠',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white60,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        color: const Color.fromARGB(255, 19, 147, 70),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.thumb_up),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              '평가',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.white60),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        color: const Color.fromARGB(255, 80, 47, 191),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.send),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              '공유',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.white60),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/**
이 코드는 Stack을 활용한 복합적인 레이아웃과 BackdropFilter를 이용한 블러 효과, 
그리고 StatefulWidget의 상태 관리를 통해 넷플릭스 스타일의 동적이고 시각적으로 
풍부한 영화 상세 페이지를 구현하고 있습니다.
 */