void main()
{
  // Set : 데이터 순서가 없고 중복 허용하지 않음

  /*
    List는 배열과 같아서 인덱스가 있고, 중복이 허용된다
    SEt은 집합과 같아서 데이터의 순서가 없고 중복이 허용되지 않는다.
   */

  // Set<String> set1 = {'c', 'b', 'a', 'a'};
  // 초기값 에러. 버전따라 가름(VS 모드), 편집 프로그램에 따라 다름.
  // 안드로이드스투디오, VS코드 다름.

  // <String> 으로 저장
  Set<String> set1 = {'c', 'b', 'a'}; // 중괄호
  print(set1);

  set1.add('a');  // 중복된 데이터이므로 추가되지 않는다.
  set1.add('d');
  print(set1);

  set1.remove('c'); //데이터 삭제
  print(set1);

  // *** 값 존재 유무 체크가 목적 ***
  var bCheck = set1.contains('b');  // constains는 존재하는 경우 true를 반환
  if (bCheck) {
    print("b는 존재하는 값입니다.");
  }

  // 인덱스 개별 값 접근(일반 for문) 단 List와 같은 방법이 아님에 유의할 것.
  for (int i=0; i<set1.length; i++)
  {
    print('set1[${i}] -> ${set1.elementAt(i)}');
  }

  for (dynamic each in set1)
  {
    print(each);
  }

  // 스프레드 연산자 (...). 컬렉션에 다른 컬렉션 데이터를 삽입할 때 사용
  var set2 = {...set1, 'x', 'y', 'z'};
  print(set2);
}