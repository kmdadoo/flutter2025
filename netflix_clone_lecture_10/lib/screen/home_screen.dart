import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflixex/model/model_movie.dart';
import 'package:netflixex/widget/box_slider.dart';
import 'package:netflixex/widget/carousel_slider.dart';
import 'package:netflixex/widget/circle_slider.dart';

// Flutter 앱의 **HomeScreen**과 TopBar 위젯을 정의합니다. 
// 넷플릭스와 같은 앱의 홈 화면 상단에 위치하는 내비게이션 바를 만드는 데 사용됩니다.

// 상태를 가질 수 있는 **StatefulWidget**입니다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;

  // initState(): 위젯이 처음 생성될 때 한 번 호출되는 메서드입니다. 
  // 현재는 특별한 로직이 없지만, 초기 데이터를 불러오거나 리스너를 설정하는 등의 작업을 이 곳에 추가할 수 있습니다.
  @override
  void initState() {
    super.initState();
    // firestore.collection('movie').snapshots()를 통해 streamData라는 데이터 스트림을 초기화합니다. 
    // 이 스트림은 movie 컬렉션의 데이터가 변경될 때마다 새로운 데이터를 전달합니다.
    streamData = firestore.collection('movie').snapshots();
  }

  // _fetchData() 메서드는 StreamBuilder 위젯을 사용하여 streamData에서 오는 데이터를 기다립니다.
  Widget _fetchData(BuildContext context) {
    debugPrint('dd');
    return StreamBuilder<QuerySnapshot>(
      stream: streamData,
      builder: (context, snapshot) {
        // snapshot.hasData가 false이면 LinearProgressIndicator()를 반환하여 로딩 중임을 표시합니다.
        if (!snapshot.hasData) return LinearProgressIndicator();
        // 데이터를 가져온 후: snapshot.data!.docs를 _buildBody() 메서드에 전달하여 실제 UI를 그립니다.
        return _buildBody(context, snapshot.data!.docs);
      },
    );
  }

  // _buildBody() 메서드는 Firestore에서 가져온 DocumentSnapshot 목록을 Movie 객체 목록으로 변환합니다. 
  // 이 Movie 객체들을 사용하여 ListView 내에 다음과 같은 UI 컴포넌트들을 만듭니다.
  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            // 영화 포스터를 슬라이드 쇼 형태로 보여줍니다.
            CarouselImage(movies: movies),
            // 캐러셀 이미지 위에 상단바를 겹쳐서 배치
            TopBar(),
          ],
        ),
        CircleSlider(movies: movies),
        BoxSlider(movies: movies),
      ],
    );
  }

  // 화면을 그리는 메서드입니다. TopBar() 위젯을 반환하여 홈 화면에 상단바를 표시합니다.
  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

// 상태가 변하지 않는 위젯이므로 **StatelessWidget**으로 정의되었습니다.
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {  // 상단바의 UI를 구성
    // 상단바 전체의 배경과 여백을 설정하는 위젯
    return Container(
      // 왼쪽, 위, 오른쪽, 아래 순서로 각각 20, 7, 20, 7의 여백을 줍니다.
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row( // 가로로 나란히 배치하는 위젯
        // Row의 자식 위젯들을 가장 왼쪽과 오른쪽 끝에 배치하고, 나머지 공간을 균등하게 분배합니다. 
        // 이 덕분에 로고와 메뉴들이 양쪽으로 정렬됩니다.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(  // 로컬에 저장된 이미지를 불러와 표시
            'assets/images/bbongflix_logo.png',
            // 이미지의 비율을 유지하며 주어진 공간에 맞춥니다
            fit: BoxFit.contain,
            height: 25, //  이미지의 높이
          ),
          Container(
            // 각 텍스트 오른쪽에 약간의 여백
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14), // 글자 크기
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
/**
이 코드는 Row 위젯을 활용하여 넷플릭스 스타일의 로고와 메뉴가 포함된 앱 상단바를 구현하고 있습니다. 
StatefulWidget과 StatelessWidget을 적절히 사용하여 UI와 상태 관리 로직을 분리하는 구조를 보여줍니다.
 */