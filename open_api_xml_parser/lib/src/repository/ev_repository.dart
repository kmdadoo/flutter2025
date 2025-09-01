import 'package:open_api_xml_parser/src/model/ev.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

/// 외부 API에서 전기차(EV) 충전소 데이터를 가져오는 역할을 합니다. 공공데이터포털의 API를 사용하며, 
/// XML 형식으로 받은 데이터를 JSON으로 변환한 후, 앱에서 사용할 수 있는 Ev 객체 목록으로 가공합니다.

class EvRepository {
  // 공공 데이터의 일반키 api key
  // apiKey: 공공데이터포털에서 발급받은 API 인증키를 저장하는 변수입니다. 이 키를 통해 API 호출 권한을 얻습니다.
  var apiKey =
      "U6dtTv%2B6W4r%2BqLjWbncBkVoiOL1TA4hTKDZtxir6tda3Vi2quu1uUI88mxp%2FiR9d1%2FIlaKFni6TEZY3TjckddQ%3D%3D";

  // loadEvs() async: 데이터를 비동기적으로 가져오는 메서드입니다.
  Future<List<Ev>?> loadEvs() async {
    // addr: 검색할 지역 주소입니다. 여기서는 "서울특별시 마포구"로 설정되어 있습니다.
    var addr = "서울특별시 마포구";
    // baseUrl: API 요청을 보낼 URL입니다. addr와 apiKey를 포함하여 완전한 형태의 URL을 만듭니다.
    String baseUrl =
        "http://openapi.kepco.co.kr/service/EvInfoServiceV2/getEvSearchList?addr=$addr&pageNo=1&numOfRows=10&ServiceKey=$apiKey";
    // http.get(...): http 패키지를 사용하여 GET 요청을 보냅니다. await 키워드를 사용해 응답이 올 때까지 기다립니다.
    final response = await http.get(Uri.parse(baseUrl));
    
    // 정상적으로 데이터를 불러왔다면
    // response.statusCode == 200: HTTP 요청이 성공했는지 확인합니다. 200은 성공적인 응답을 의미합니다.
    if (response.statusCode == 200) {
      // 데이터 가져오기
      // convert.utf8.decode(response.bodyBytes): 응답으로 받은 바이트 데이터를 UTF-8 인코딩을 사용하여 문자열로 디코딩합니다.
      final body = convert.utf8.decode(response.bodyBytes);

      // xml => json으로 변환
      // Xml2Json()..parse(body): xml2json 패키지를 사용하여 XML 문자열을 JSON으로 파싱합니다. 
      // ..은 **연쇄 호출(cascade notation)**로, Xml2Json() 객체를 생성한 후 parse 메서드를 바로 호출합니다.
      final xml = Xml2Json()..parse(body);
      // xml.toParker(): 파싱된 XML을 특정 형식(Parker)의 JSON 문자열로 변환합니다.
      final json = xml.toParker(); 

      // 필요한 데이터 찾기
      // convert.json.decode(json): JSON 문자열을 Dart에서 사용할 수 있는 Map 객체로 디코딩합니다.
      Map<String, dynamic> jsonResult = convert.json.decode(json);
      // jsonResult['response']['body']['items']: API 응답의 계층 구조를 따라가며 실제 데이터가 담긴 부분을 찾아냅니다.
      final jsonEv = jsonResult['response']['body']['items'];

      // 필요한 데이터 그룹이 있다면 
      // if (jsonEv['item'] != null): items 안에 item이라는 키가 있는지 확인합니다. 
      // 이는 데이터가 하나라도 존재하는지 확인하는 중요한 예외 처리입니다.
      if (jsonEv['item'] != null) {
        // map을 통해 데이터를 전달하기 위해 객체인 List로 만든다.
        List<dynamic> list = jsonEv['item']; 

        // map을 통해 Ev형태로 item을  => Ev.fromJson으로 전달
        // list.map<Ev>((item) => Ev.fromJson(item)).toList(): List의 각 항목을 순회하며 Ev.fromJson 팩토리 생성자를 호출합니다. 
        // Ev.fromJson은 JSON 맵을 Ev 객체로 변환하는 역할을 합니다. toList()를 통해 최종적으로 Ev 객체들의 리스트를 만들어 반환합니다.
        return list.map<Ev>((item) => Ev.fromJson(item)).toList();
      }
    }
    // return null: 만약 HTTP 요청이 실패하거나 데이터가 없을 경우, null을 반환합니다.
    return null;
  }
}
/**
  이 코드는 웹 서버와 통신하여 데이터를 가져오고, 복잡한 XML 데이터를 Dart 
  객체로 변환하는 데이터 저장소(repository) 역할을 충실히 수행하고 있습니다.
 */