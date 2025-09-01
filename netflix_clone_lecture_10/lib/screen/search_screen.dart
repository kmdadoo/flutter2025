import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflixex/model/model_movie.dart';
import 'package:netflixex/screen/detail_screen.dart';

///  Firebase Firestore와 연동된 검색 화면을 구현합니다. 
/// 사용자가 검색창에 텍스트를 입력하면 Firestore에 저장된 영화 데이터에서 해당 텍스트를 포함하는 
/// 영화를 찾아 격자(Grid) 형태로 보여주는 기능을 수행합니다.

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // _filter: TextField의 내용을 제어하는 컨트롤러입니다.
  final TextEditingController _filter = TextEditingController();
  // focusNode: TextField의 포커스 상태(선택되었는지 여부)를 추적하는 객체입니다.
  FocusNode focusNode = FocusNode();
  // 사용자가 입력한 검색어
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    // 텍스트 필드의 내용이 변경될 때마다 _searchText를 업데이트하고 화면을 다시 그립니다.
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  // 위젯이 제거될 때 리스너와 포커스 노드가 해제되도록 했습니다. 
  // 이는 메모리 누수를 방지하는 중요한 단계입니다.
  @override
  void dispose() {
    _filter.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildBody(BuildContext context) {
    // 검색어가 비어있을 경우, 모든 영화 데이터를 가져옵니다.
    if (_searchText.isEmpty) {
      return const Center(child: Text("검색어를 입력해 주세요."));
    }

    // Firebase Firestore 쿼리를 사용하여 검색어가 포함된 영화만 필터링합니다.
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('movie')
          // **where('title', isGreaterThanOrEqualTo: _searchText)**를 사용하여 Firestore에서 직접 필터링된 데이터만 가져옵니다. 
          // 이는 데이터베이스의 부하를 줄이고 앱의 성능을 크게 향상시킵니다.
          .where('title', isGreaterThanOrEqualTo: _searchText)
          // '${_searchText}z'를 사용한 것은 Firebase의 제한적인 문자열 검색 기능을 보완하기 위한 방법입니다.
          .where('title', isLessThan: '${_searchText}z')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // CircularProgressIndicator를 사용하여 로딩 중임을 더 명확하게 시각적으로 보여줍니다.
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("검색 결과가 없습니다."));
        }

        return _buildList(context, snapshot.data!.docs);
      },
    );
  }


  //  _buildList에서 Expanded를 반환하도록 변경했습니다. 이는 Column 내에서 Expanded 위젯의 올바른 사용법에 맞습니다.
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Expanded(
      // GridView.count: 검색 결과를 포스터 이미지로 보여주는 격자형 레이아웃을 만듭니다. 
      child: GridView.count(
        // 한 행에 3개의 이미지를 표시하라는 의미
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        padding: EdgeInsets.all(3),
        children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    // Movie.fromSnapshot(data): Firestore 문서를 Movie 객체로 변환합니다.
    final movie = Movie.fromSnapshot(data);
    return InkWell( // 이미지를 탭할 수 있게 하여 상호작용을 가능하게 합니다.
      // Movie 객체의 포스터 URL을 사용하여 이미지를 불러와 표시
      child: Image.network(movie.poster),
      onTap: () {
        // Navigator.of(context).push(...): 포스터를 탭하면 DetailScreen으로 이동하여 해당 영화의 상세 정보를 보여줍니다.
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
        Padding(
          padding: EdgeInsets.all(30),
        ),
        Container(
          color: Colors.black,
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: TextField(                  
                  focusNode: focusNode,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  autofocus: true,
                  controller: _filter,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white12,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white60,
                      size: 20,
                    ),
                    // suffixIcon과 '취소' 버튼의 가시성 로직을 더 명확하게 수정했습니다. 
                    // 검색어가 있고 포커스가 있을 때만 아이콘을 보여주거나 '취소' 버튼을 렌더링하도록 했습니다.
                    suffixIcon: focusNode.hasFocus && _searchText.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.cancel, size: 20),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = "";
                                  focusNode.unfocus();
                                });
                              },
                            )
                          : null, // 포커스가 없거나 검색어가 비어있으면 아이콘을 제거합니다.
                    hintText: '검색',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              // focusNode.hasFocus를 사용하여 포커스 여부에 따라 취소 버튼의 가시성을 제어합니다.
              focusNode.hasFocus
                  ? Expanded(
                      child: TextButton(
                        child: Text('취소', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          setState(() {
                            _filter.clear();
                            _searchText = "";
                            focusNode.unfocus();
                          });
                        },
                      ),
                    )
                    //  불필요한 위젯을 렌더링하지 않도록 최적화했습니다.
                  : const SizedBox.shrink(), // 위젯을 렌더링하지 않습니다.
            ],
          ),
        ),
        // 검색 결과 영역을 담당하는 위젯을 호출
        _buildBody(context)
      ],
    );
  }
}