import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflixex/model/model_movie.dart';
import 'package:netflixex/screen/detail_screen.dart';

/// Firebase Firestore와 연동된 '내가 찜한 콘텐츠' 화면을 구현합니다. 
/// 넷플릭스처럼 사용자가 '찜하기'를 누른 영화들만 모아서 보여주는 페이지입니다.

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  Widget _buildBody(BuildContext context) {
    // StreamBuilder<QuerySnapshot>: Firebase Firestore에서 실시간으로 데이터를 가져오는 위젯입니다.
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
        //movie 컬렉션에 접근합니다.
        .collection('movie')
        // Firestore 쿼리를 사용하여 like 필드가 true인 문서만 필터링합니다. 
        // 이는 앱에서 모든 데이터를 가져와 필터링하는 것보다 훨씬 효율적입니다.
        .where('like', isEqualTo: true)
        // 필터링된 문서 목록의 변경사항을 실시간으로 스트림으로 전달받습니다.
        .snapshots(),
      builder: (context, snapshot) {
        // if (!snapshot.hasData): 데이터 로딩 중일 때 LinearProgressIndicator (로딩 바)를 표시합니다.
        if (!snapshot.hasData) return LinearProgressIndicator();
        // 데이터가 성공적으로 도착하면 _buildList 메서드를 호출하여 UI를 그립니다.
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Expanded(  // 남은 공간을 모두 차지하도록 만듭니다.
      child: GridView.count(  // 격자형 레이아웃을 만드는 위젯
        // 가로 방향으로 3개의 항목
        crossAxisCount: 3,
        // 자식 위젯(포스터 이미지)의 가로세로 비율을 1:1.5로 설정합니다.
        childAspectRatio: 1 / 1.5,
        padding: EdgeInsets.all(3),
        children:
          //  Firestore에서 가져온 DocumentSnapshot 목록을 _buildListItem 위젯 목록으로 변환합니다.
          snapshot.map((data) => _buildListItem(context, data)).toList()),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    // Firestore 문서 데이터를 앱에서 사용하기 쉬운 Movie 객체로 변환합니다.
    final movie = Movie.fromSnapshot(data);
    return InkWell( // 이미지 포스터를 탭 가능하게 만들어줍니다.
      // Movie 객체의 포스터 URL을 사용해 이미지를 불러와 표시합니다.
      child: Image.network(movie.poster),
      onTap: () { // 포스터를 탭하면 DetailScreen으로 이동
        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movie);
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20, 27, 20, 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/bbongflix_logo.png',
                fit: BoxFit.contain,
                height: 25,
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  '내가 찜한 콘텐츠',
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
        // Expanded 위젯을 포함하는 _buildBody 메서드를 호출하여 나머지 공간에 찜한 영화 목록을 표시합니다.
        _buildBody(context)
      ],
    );
  }
}