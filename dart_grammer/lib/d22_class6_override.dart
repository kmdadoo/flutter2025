class Unit {
  move() { print("이동1"); }
  attack() { print("공격1"); }
  heal() { print("치료1"); }
}

class Marine extends Unit {
  // 기능의 변경(재정의 오버라이딩)
  move() { print("마린 이동"); }
  // 기능의 추가
  attack() {
    //super를 통해 부모에 정의된 메서드를 호출함
    super.attack();
    print("마린 공격");
  }
  // 이노테이션으로 부모 함수 재정의, 오버라이딩하는 메서드명이 맞는지 체크
  // 만약 부모 클래스에 heal()이라는 메서드가 없는데 @override를 사용하면
  // 컴파일 에러가 발생하여 오타나 실수를 미리 잡아낼 수 있습니다.
  // 이는 코드의 안정성을 높이는 데 큰 도움이 된다.
  @override
  heal() {
    super.heal();
    print("마린 치료");
  }
}

void main()
{
  var unit = Marine();
  unit.move();
  unit.attack();
  unit.heal();
}