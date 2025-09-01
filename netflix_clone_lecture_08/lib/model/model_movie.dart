import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;
  // Firestore 데이터베이스에 있는 특정 문서의 위치를 가리키는 포인터 역할
  final DocumentReference reference; // 추가

  // fromMap 생성자 수정: reference 속성을 필수로 받도록 변경되었습니다. 
  // 이제 이 생성자를 호출할 때는 영화 데이터뿐만 아니라 그 데이터가 저장된 Firestore 문서의 참조도 함께 넘겨줘야 합니다.
  Movie.fromMap(Map<String, dynamic> map, {required this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];
  
  // romSnapshot 생성자 추가: 이 생성자는 Firestore에서 데이터를 읽어올 때 사용하는 DocumentSnapshot 객체를 인자로 받습니다. 
  // 스냅샷은 문서 데이터와 그 문서의 참조(snapshot.reference)를 모두 포함하고 있기 때문에, 
  // 이 생성자는 스냅샷에서 두 정보를 모두 추출하여 fromMap 생성자에게 넘겨줍니다.
  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "Movie<$title:$keyword>";
}