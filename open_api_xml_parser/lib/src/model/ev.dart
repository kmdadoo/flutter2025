// 전기차 충전소 하나의 정보를 담는 데이터 모델
// JSON 형태의 데이터를 이 클래스의 객체로 변환해주는 factory 생성자를 포함하고 있습니다.

class Ev {
  // 클래스 변수: addr, chargeTp, cpNm 등 전기차 충전소에 대한 다양한 정보를 저장할 수 있는 변수들이 정의되어 있습니다. 
  // 각 변수 옆에 주석으로 어떤 정보를 담고 있는지 설명이 되어 있어 가독성이 좋습니다. 
  // 모든 변수가 String? 타입으로 선언되어 있어 null 값을 허용합니다.
  String? addr; // 충전소 주소
  String? chargeTp; // 충전기 타입
  String? cpNm; // 충전기 명칭
  String? cpStat; // 충전기 상태 코드
  String? cpTp; // 충전 방식
  String? csNm; // 충전소 명칭
  String? lat; // 위도
  String? longi; // 경도

  // 생성자: Ev 클래스의 객체를 생성할 때 사용됩니다. 
  // this.addr, ...와 같이 중괄호 {} 안에 변수들이 있어, **이름 있는 매개변수(named parameters)**로 객체를 생성할 수 있습니다.
  Ev({
    this.addr,
    this.chargeTp,
    this.cpNm,
    this.cpStat,
    this.cpTp,
    this.csNm,
    this.lat,
    this.longi,
  });

  // 팩토리 생성자: 이 메서드는 새로운 Ev 객체를 생성하는 것이 아니라, 이미 존재하는 객체를 반환하거나, 
  // 복잡한 로직을 거쳐 객체를 생성할 때 사용됩니다. 여기서는 JSON 맵을 인자로 받아 Ev 객체로 변환하는 역할을 합니다.
  factory Ev.fromJson(Map<String, dynamic> json) {
    // 충전기 타입
    if (json["chargeTp"] == "1") {
      json["chargeTp"] = "충전기 타입 : 완속";
    } else if (json["chargeTp"] == "2") {
      json["chargeTp"] = "충전기 타입 : 급속";
    }

    // 충전기 상태 코드
    if (json["cpStat"] == "1") {
      json["cpStat"] = "충전기 상태 : 충전 가능";
    } else if (json["cpStat"] == "2") {
      json["cpStat"] = "충전기 상태 : 충전중";
    } else if (json["cpStat"] == "3") {
      json["cpStat"] = "충전기 상태 : 고장/정검";
    } else if (json["cpStat"] == "4") {
      json["cpStat"] = "충전기 상태 : 통신장애";
    } else if (json["cpStat"] == "5") {
      json["cpStat"] = "충전기 상태 : 통신미연결";
    }

    // 충전 방식
    if (json["cpTp"] == "1") {
      json["cpTp"] = "충전 방식 : B타입(5핀)";
    } else if (json["cpTp"] == "2") {
      json["cpTp"] = "충전 방식 : C타입(5핀)";
    } else if (json["cpTp"] == "3") {
      json["cpTp"] = "충전 방식 : BC타입(5핀)";
    } else if (json["cpTp"] == "4") {
      json["cpTp"] = "충전 방식 : BC타입(7핀)";  // 7핀
    } else if (json["cpTp"] == "5") {
      json["cpTp"] = "충전 방식 : DC차데모";
    } else if (json["cpTp"] == "6") {
      json["cpTp"] = "충전 방식 : AC3상";
    } else if (json["cpTp"] == "7") {
      json["cpTp"] = "충전 방식 : DC콤보";
    } else if (json["cpTp"] == "8") {
      json["cpTp"] = "충전 방식 : DC차데모+DC콤보";
    } else if (json["cpTp"] == "9") {
      json["cpTp"] = "충전 방식 : DC차데모+AC3상";
    } else if (json["cpTp"] == "10") {
      json["cpTp"] = "충전 방식 : DC차데모+DC콤보+AC3상";
    }

    //as String을 사용해 각 값이 String 타입임을 명시적으로 변환(캐스팅)하고 있습니다.
    return Ev(
      addr: json["addr"] as String,
      chargeTp: json["chargeTp"] as String,
      cpNm: json["cpNm"] as String,
      cpStat: json["cpStat"] as String,
      cpTp: json["cpTp"] as String,
      csNm: json["csNm"] as String,
      lat: json["lat"] as String,
      longi: json["longi"] as String,
    );
  }
}
/**
이 코드는 전기차 충전소 데이터를 담는 모델 클래스로, JSON 데이터를 받아서 사람이 
이해하기 쉬운 형태로 데이터를 전처리한 후, 최종 Ev 객체를 생성하여 반환하는 중요한 역할을 수행합니다.
 */