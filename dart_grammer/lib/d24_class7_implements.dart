//2개의 추상클래스 또는 인터페이스 선언
// Dart에서는 abstract 클래스뿐만 아니라 일반 클래스도 implements 키워드를 통해
// 인터페이스처럼 사용할 수 있습니다.
// 이 예제에서는 명시적으로 abstract를 사용하여 추상적인 역할을 강조하고 있습니다.
abstract class Greet {
  greet();
}
abstract class Talk {
  talk();
}

// Dart는 단일 상속만 지원. 추상클래스로 사용.
class Morning extends Greet //, Talk
{
  greet() { print("인사"); }
}

// Dart는 다중 구현을 implements 키워드를 통해 여러 클래스(인터페이스)의 추상 메서드를 동시에 구현할 수 있습니다.
class Evening implements Greet, Talk
{
  // 의무적으로 구현
  greet() { print("인사"); }
  talk() { print("대화"); }
}

void main()
{
  Morning m = Morning();
  m.greet();

  Evening e = Evening();
  e.greet();
  e.talk();
}