import 'd19_class3_private2.dart';
// 접근 제한자(Access Modifier)
class Unit
{
  // 변수명 그냥 쓰면 public, _로 시작하면 private (암묵적)
  //  Dart의 private는 파일(라이브러리) 단위로 작동합니다.
  //  즉, 같은 파일 내에서는 _name에 자유롭게 접근할 수 있습니다.
  late String _name;
  late int age;

  // 생성자 간단하게 사용하기
  // 어차피 연결할 것... 파라미터 부분에서...
  Unit (this._name, this.age);
}

void main()
{
  // Unit 클래스는 같은 라이브러리 이므로 private멤버도 접근 가능하다.
  var unit1 = Unit("마린", 25);
  print(unit1._name);  // private 이지만 에러 없이 출력됨(Java에서는 에러)
  print(unit1.age);

  // Unit2 클래스의 경우 외부에서 정의되었으므로 private멤버는 접근할 수 없다.
  var unit2 = Unit2("메딕", 20);
  // print(unit2._name);   // private 적용됨 다른 파일 이므로 에러남
  print(unit2.age);
}
/*
    dart 에서는 하나의 파일이 하나의 library이다.
    그래서 private 으로 할 경우 해당 파일 에만 or 해당 라이브러리에만 접금이
    가능. 외부 파일에서는 접근이 불가능하다.
 */
