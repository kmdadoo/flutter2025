class Unit {
  var health = 10;
}

class Marine extends Unit {
  var attack = 1;
}

void main()
{
  // 성속을 받아서 두변수 다 사용 가능
  var unit = Marine();
  print("체력:${unit.health}");
  print("공격력:${unit.attack}");
}