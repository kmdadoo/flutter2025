class Unit  // 중요
{
  int? health;    // 초기화가 안될수 도 있다는 뜻
  int? move;

  // 초기화 리스트를 사용 health = 10과 move = 1은 생성자 본문이 실행되기 전에 인스턴스 변수를 초기화합니다.
  // 이 방식은 변수를 간결하게 초기화할 때 유용합니다.
  Unit.init() : health = 10, move = 1 {     // init말고 다른 것 써도 됨,
    // 생성자의 구현부가 실행하기 전에 인스턴스 변수를 초기화할 수 있다.
  }

  // 생성자 선언. 옵션(들어올 수 있고 안들어 올수도 있음(null일수 있음))
  Unit({int? health}) : move = 2 {
    // 전달된 겂이 null이면 0으로 초기화 된다.
    this.health = health ?? 0;
  }
}

// Marine 클래스는 Unit 클래스를 상속
class Marine extends Unit
{
  late int attack;      // 자식에서 추가한 멤버 변수
  // 초기화 리스를 통해 1로 초기화하고, 나머지는 부모 생성자를 호출한다.
  Marine({int? health}) : attack = 1, super(health: health) {
  }
}

void main() {
  // 생성자의 초기화 리스트 사용하기
  Unit unit1 = Unit.init();
  print('unit1.health : ${unit1.health}');
  print('unit1.move : ${unit1.move}');
  print("===========================");

  // Marine unit2 = Marine();  // 인자가 null이므로 0이 나옴.
  Marine unit2 = Marine(health: 20);
  print('unit2.health : ${unit2.health}');
  print('unit2.move : ${unit2.move}');
  print('unit2.attack : ${unit2.attack}');
}