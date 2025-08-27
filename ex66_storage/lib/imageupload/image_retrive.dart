import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 저장된 이미지의 URL을 불러와 화면에 표시하는 Flutter 예제입니다. 
/// 이 위젯은 Firebase Storage에 이미지를 업로드한 후, 그 이미지의 URL을 이용해 화면에 다시 띄우는 역할을 합니다.
class ImageRetrive extends StatefulWidget {
  const ImageRetrive({super.key});

  @override
  State<ImageRetrive> createState() => _ImageRetriveState();
}

//  위젯의 상태를 관리
class _ImageRetriveState extends State<ImageRetrive> {
  // shared_preferences 패키지를 사용해 기기에 저장된 데이터를 관리하는 객체입니다.
  late SharedPreferences prefs;
  // 화면에 표시할 이미지의 URL을 저장하는 변수입니다. 초기값은 빈 문자열로 설정되어 있습니다.
  String imgUrl = "";

  @override
  // 위젯이 처음 생성될 때, getSharedPreferences 함수를 호출하여 필요한 데이터를 불러옵니다.
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  // 비동기 함수로, SharedPreferences.getInstance()를 호출해 기기 저장소에 접근합니다.
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    // 데이터 로딩이 완료된 후, setState를 호출하여 위젯의 상태를 업데이트합니다. 
    // 이로 인해 화면이 새로고침되면서 imgUrl 변수에 저장된 이미지 URL이 화면에 반영됩니다.
    setState(() {
      // 저장소에서 "imageUrl"이라는 키로 저장된 문자열 값을 가져옵니다. 
      // 만약 해당 키가 없으면 ?? "" 연산자를 통해 빈 문자열("")을 imgUrl에 할당하여 오류를 방지합니다.
      imgUrl = (prefs.getString("imageUrl") ?? "");
    });
    debugPrint("get url : $imgUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Upload Image"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // 네트워크 URL을 통해 이미지를 로드하여 화면에 보여줍니다. 
          // imgUrl 변수가 초기에는 빈 문자열이지만, getSharedPreferences 함수가 완료된 후에는 
          // 저장된 이미지 URL로 업데이트되면서 이미지를 자동으로 불러옵니다.
          Image.network(
            imgUrl,
            height: 400,
            fit: BoxFit.contain,
          ),
        ]),
      ),
    );
  }
}
// shared_preferences를 사용하여 데이터를 저장하고 로드하는 방법과 
// Image.network 위젯을 사용하여 원격 이미지를 표시하는 방법을 효과적으로 보여주는 예제입니다.