void main()
{
  // *** Nullable & Non-Nullable ***
  int num1 = 5;     // null값을 허용하지 않는 변수로 선언. Non-Nullable 변수
  int? num2 = 2;    // null값을 허용하는 변수. 값이 없으면 null. Nullable 변수

  // num1 = null;   // 에러 발생 : Non-Nullable
  num2 = null;      // ok : Nullable

  // String str1 = null;   // error : Non-Nullable
  String? str2 = null;     // ok : Nullable

  print("1 ==========================");

  // *** Null Safety(널 안전성) 규칙 *** null 일때 안전하게 사용하기 위해

  // Non-Nullable 변수는 선언만 하고 초기값을 할당하지 않으면 에러가 발생합니다.
  // 사용 전에 반드시 값이 할당되어야 합니다. a1 은 Non-Nullable. null 로 자동 초기화 할수 없다.
  // int a1;   print(a1); //에러발생
  //Nullable 변수는 선언만 해도 자동으로 null로 초기화됩니다. 에러 없음.
  int? a2;  print(a2);

  // var 타입에서의 Null Safety
  // int 타입으로 유추. Non-Nullable 변수임으로 null 대입 불가능
  // null을 직접 대입하거나 초기값 없이 선언하면 Dart는 타입을 dynamic(모든 타입을 허용하는 동적 타입)으로 추론합니다.
  // dynamic 타입은 Nullable과 Non-Nullable의 경계를 허물기 때문에 주의해서 사용해야 합니다.
  var a3 = 10;
  var a4 = null;    // dynamic 으로 유추
  var a5;           // dynamic 으로 유추
  // var 타입 뒤에는 ? 를 추가할 수 없다.
  // var? a6 = null;   //error

  print("2 =============================");

  // *** Null Safety Operator ***

  int num3 = 5;
  int? num4;

  // ! : null check operator — runtime error throw
  // 변수 뒤에 ! 을 추가 하면 이 변수 값이 null 인 경우 runtime error 발생

  num4 = 10;        // 이 줄이 없으면 다음 줄 에러
  num3 = num4;      // 컴파일 전 체크

  //  개발자가 num4가 절대 null이 아닐 것을 확신할 때 사용
  // 약 실행 시 num4가 실제로 null이면 런타임 에러(Null check operator used on a null value)가 발생합니다.
  num3 = num4!;     // 실행 시 체크 , 이는 컴파일러에게 "이 값은 null이 아니니 걱정 마"라고 알려주는 역할을 한다.
  print(num4);

  // ?. ?[ ] ?.. — null aware operator
  // String name;     // <-- 값이 대입되지 않고 사용되면 null일 수 있다.
  String? name;

  // ?.은 객체가 null이 아닐 때만 뒤에 오는 메서드나 속성을 실행하라는 의미
  // 만약 name이 null이면 name?.toLowerCase() 전체는 null이 됩니다.
  // 이 연산자가 없으면 null인 상태에서 .toLowerCase()를 호출하려다 런타임 에러가 발생
  name = name?.toLowerCase();


  // Null 일 때
  // ?? 연산자는 좌항의 값이 null이면 우항의 값을 반환하고, null이 아니면 좌항의 값을 반환합니다.
  // n42는 정수가 아니므로 정수로 변환시 에러발생됨. 따라서 val2는 -1로
  // 초기화 된다.
  int val2 = int.tryParse('n42') ?? -1;
  print('val2 = $val2');

  String? name1;
  // name1='sssss';   // 이값이 없으면 런타임 에러가 난다.
  // String text = name1;

  // 그럼 저렇게 에러가 떴을 때는 어떻게 해야하나, 하면 변수 뒤에 '!'을
  // 붙여주면 됩니다. 그려면 플러터는 '아 저 변수는 사용되는 시점에서
  // null값이 절대 아니구나'하고 에러를 없애줍니다.
  // 하지만 코드에 name1='sssss';가 없으면 name1은 실제로는 null이며,
  // 이 코드를 실행하면 런타임 에러가 발생하게 됩니다. 이는 ! 연산자의 위험성을 보여줍니다
  String text = name1!;
  print(text);

}