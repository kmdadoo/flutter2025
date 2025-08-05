class Marine
{
  // 앞에서 했던 방식. 이것을 간단하게 사용한 것이 아래방법
  // late int health;
  // late int attack;
  //
  // Marine(int health, int attack)
  // {
  //   this.health = health;
  //   this.attack =attack;
  // }

  // final로 선언된 변수는 한 번 값이 할당되면 변경할 수 없습니다.
  final int health;
  final int attack;

  // 상수 생성자 : with final 변수
  // 자바로 보면 static 선언 한것과 비슷
  // 컴파일 시점에 값이 결정되는 상수 객체를 만들 때 사용
  // const 생성자를 사용하려면 클래스의 모든 필드가 final이어야 합니다.
  const Marine(this.health, this.attack);
  /*
    하나의 객체로 여러번 사용하고 싶다면 const 생성자를 이용하여
    객체를 생성해야 한다. 플러터의 모든 객체에 다양하게 사용되고 있다.
   */
}

void main()
{
  Marine unit1 = Marine(10, 1);
  Marine unit2 = Marine(10, 1);     // 새로 만들어진 것임. 변수명이 다름
  Marine unit3 = const Marine(10, 1);
  Marine unit4 = const Marine(10, 1);     // 같은것을 사용. 메모리 절약
  // new 키워드를 사용하더라도 일반 생성자는 매번 새로운 객체를 생성
  Marine unit5 = new Marine(10, 1);
  Marine unit6 = new Marine(10, 1);

  /*
    identical(객체1, 객체2)
        : 인자로 주어진 두개의 객체의 주소값을 비교하여 동일하면 true를
        반환하는 메서드
   */

  print( identical(unit1, unit2) );     // false
  print( identical(unit1, unit3) );     // false
  print("=======================");

  print( identical(unit2, unit3) );     // false
  // const 생성자로 동일한 인자를 사용해 만들어졌기 때문에,
  // Dart가 동일한 객체를 재활용합니다. 따라서 메모리 주소가 같습니다.
  print( identical(unit3, unit4) );     // true <---
  print("=======================");

  print( identical(unit1, unit5) );     // false
  print( identical(unit3, unit5) );     // false
  print( identical(unit5, unit6) );     // false
}
// 리다이렉팅 생성자
// 팩토리 생성자
// 다트가 아니고 플러터를 배울 것이므로 생략
