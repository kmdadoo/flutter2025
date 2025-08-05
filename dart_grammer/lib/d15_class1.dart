class Unit
{
  // late는 변수가 선언될 때는 null이 될 수 있지만,
  // 사용되기 전에는 반드시 초기화될 것이라고 컴파일러에게 알려주는 키워드이다.
  late String name;
  late int age;

  /*
    생성자를 아래에서 선언하였으므로 디폴트생성자는 추가되지 않는다.
    만약 생성자를 임의로 선언하지 않았다면 디폴트생성자는 추가된다.
   */

  // 디폴트 생성자를 자동으로 생성하지 않습니다
  // Unit (){} // 디폴트 생성자. 클래스이름과 같은면 생성자.

  //  매개변수 있는 생성자
  Unit (String name, int age)   // 자바로치면 오버로딩 한것.
  {
    this.name = name;
    this.age = age;
  }
}

void main()
{
  // 디폴트 생성자가 없어서 에러 발생
  // var unit1 = new Unit();

  // 자바와 같은 방식 - Dart에서 권장하지 않음
  var unit2 = new Unit("마린", 20);

  // 보통은 new가 옵션이라 생략.  Dart에서는 이 방식을 권장
  var unit3 = Unit("메딕", 25);

  // late로 선언하는 경우 객체생성시 반드시 null이 아닌 값으로 초기화 해야함.
  // var unit4 = Unit("파이어벳", null);

  print('unit2= ${unit2.name}, ${unit2.age}');
  print('unit2= ${unit3.name}, ${unit3.age}');
}