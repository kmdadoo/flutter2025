void main()
{
  // 산술 연산자
  int num1 = 5;
  int num2 = 2;

  print('더하기 ${num1 + num2}');
  print('빼기   ${num1 - num2}');
  print('곱하기 ${num1 * num2}');
  // 형변환후 연산 2.5 결과가 소수점으로 나옴, 자바의 CPU계산기와 다름. 사용자 편의를 위해
  // 파이썬에도 3.0이후에는 이렇게 나옴.
  print('나누기 ${num1 / num2}');
  print('몫 ${num1 ~/ num2}');     // 몫. 자바와 같은 방법
  print('나머지 ${num1 % num2}');    // 나머지
}