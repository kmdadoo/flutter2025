void main()
{
  // 메서드도 변수에 대입(참조값)이 가능.
  // Dart에서는 메서드를 객체로 취급하기 때문
  var myFunc = addTwoNum;

  // 변수를 이용하여 메서드 호출 : 메서드명의 리네임 같다.
  myFunc(1, 2);

  // 메서드 파라미터에 메서드를 사용
  // 함수를 다른 함수의 인수로 전달하는 것은 Dart에서 흔히 볼 수 있는 패턴
  something("2", "3", myFunc);
}

void addTwoNum(int a, int b) {
  print(a + b);
}

void something(var a, var b, var c) {
  int val1 = int.parse(a);
  int val2 = int.parse(b);

  // c는 메서드이므로...
  c(val1, val2);
}