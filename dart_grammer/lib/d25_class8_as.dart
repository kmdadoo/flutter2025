// // 다운 캐스팅 이해를 돕기 위해
// class Point
// {
//   int? x;
//   int? y;
// }
//
// class PointDetail extends Point
// {
//   int? z;
// }
//
// void main()
// {
//   PointDetail p1 = PointDetail();
//   p1.x = 4; // setter
//   p1.y = 5;
//   p1.z = 6;

//   // 자식 클래스(PointDetail)를 부모클래스(Point)로 타입 캐스팅하는 것을
//   // 업캐스팅(up-casting)이라 합니다.
//   // 부모타입으로 캐스팅해서 막 사용하다가 자식객체를 다시 받아야 할 때
//   Point p2 = p1; // 업캐스팅
//   // ...
//
//   // 다시 point detail의 z값에 접근하거나 사용해야 할 때.
//   if(p2 is PointDetail)     // is 로 판단해서 한번 확인했기 때문에 as 생략가능
//   {
//       PointDetail p3 = p2 as PointDetail;   // 다운 캐스팅
         //다운캐스팅을 통해 p2를 다시 PointDetail 타입으로 변환하여 p3.z에 접근할 수 있게 됩니다
//       print(p3.z);
//       print("oo");
//   }else
//   {
//     print("ㄴㄴ");
//   }
// }

// 부모클래스 정의
class Unit {
  var health = 10;
}

// 자식클래스 정의(Unit을 상속)
class Marine extends Unit {
  var name = '마린';
}
class Medic extends Unit {
  var name = '메딕';
}

void main()
{
  // 객체 생성
  Marine marine = Marine();
  Medic medic = Medic();

  // marine을 Unit을 형변환 하는 것.
  Unit unit1 = marine as Unit; //객체의 형변환을 위해 as(상속받았을때만 가능)를 사용한다.
  Unit unit2 = medic; //현재 버전에서는 as없이도 형변환(업캐스팅)이 가능하다.

  // is는 특정타입이 맞다면, 즉 상속관계가 있으면 true를 반환한다.
  // 원래 클래스를 확인 하는 것.
  // true일 경우, Dart 컴파일러는 if 블록 내에서 unit1 변수가 Marine 타입임을 자동으로 추론합니다.
  // 따라서 다운캐스팅 (unit1 as Marine)을 명시적으로 하지 않아도 unit1.name과 같이 Marine 클래스에만 있는 멤버에 접근할 수 있게 됩니다.
  if (unit1 is Marine) { // is 체크 없이 print(unit1.name);을 단독으로 사용하면 컴파일 에러가 발생
    print('마린입니다.');
    print(unit1.name);  // 자바와는 다름. 자바는 이렇게 참조가 안됨.
  }
  else {
    print('마린이 아닙니다.');
  }

  /*
    자바에서는 부모타입의 참조변수로 자식쪽 멤버변수에 접근 할 수 없다.
    하지만 다트에서는 가능하다. 마치 변수까지 오버라이딩 되는 듯한 느낌
    이라 생각하면 된다.
  */
  // print(unit1.name); // => 단독적으로는 해당문장은 사용할 수 없다.
  /*
    이 문장을 of문 블럭 외부로 옮기면 에러가 발생한다.
    is를 통해 부모타입을 자식타입으로 변환히 가능한지 확인한 후
    접근을 허용하게 된다.
  */

  //as없이 대입해도 정상적으로 출력된다.
  if(unit2 is Medic){
    print("메딕입니다.");
  }
  else{
    print('메딕이 아닙니다.');
  }
}