void main()
{
  // Dart는 배열이 없다. 리스트 컬렉션으로 사용한다.
  // List : 데이터 순서가 있고 중복 허용
  /*
      List컬렉션 생성시 <>안에 사용하는 타입을 통해 현재 생성된
      컬렉션에 저장할 데이터의 타입을 지정한다.
  */
  // 문자열(String)을 저장할 수 있는 리스트 컬렉션
  List<String> list1 = ['a', 'b', 'c', 'a'];
  // 정수를 저장할 수 있는 리스트 컬랙션
  List<int> list2 = [1, 2, 3, 1];

  // (타입이  정해지지 않는 리스트)를 통해서도 리스트를 생성할 수 있다.
  var list3 = ['a', 'b', 'c', 'a'];
  // add()를 통해 데이터를 마지막 부분에 추가한다.
  list3.add('d');
  print(list3);

  // remove()를 통해 데이터를 앞부분부터 삭제한다.
  list3.remove('a');    // 앞의 a가 삭제됨
  print(list3);

  // 인덱스는 항상 0부터 시작한다.
  list3.removeAt(2);    // 인덱스에 위치한 값 삭제됨  0, 1, 2 번째인 a
  print(list3);

  // 인덱스로 개별 값 접근(일반 for문 형태)
  for (int i=0; i<list3.length; i++)
  {
    print('list3[${i}] -> ${list3[i]}');
  }

  // 개선된 for 문으로 리스트에 저장된 원소의 개수만큼 자동으로 반복한다.
  for (var each in list3)
  {
    print(each);
  }

  // 스프레드 연산자 (...) : 복사, 삽입 하는 연산자.
  // 다른 컬렉션 안에 컬렉션 삽입 할때, 2개의 배열을 연결할 때 사용한다.
  var list4 = [ ...list2, 5, 6, 7];
  print(list4);
}