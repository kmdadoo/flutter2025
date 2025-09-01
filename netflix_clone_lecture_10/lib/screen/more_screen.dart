import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

/// 앱의 **더보기 화면(프로필, 링크, 설정 등)**을 구현합니다. 
/// 사용자의 프로필 정보와 링크, 그리고 '프로필 수정' 버튼을 표시하는 페이지입니다.

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 216, 21, 105),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 50),
              // 동그란 프로필 이미지를 만듭니다.               
              child: CircleAvatar(
                radius: 100,
                // backgroundImage 속성에 로컬 이미지 파일 경로를 지정합니다.
                backgroundImage: AssetImage('assets/images/bbongflix_logo.png'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                '검은거부기',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ),
            // 너비 140, 높이 5인 빨간색 사각형을 만들어 구분선 역할
            Container(
              padding: EdgeInsets.all(15),
              width: 140,
              height: 5,
              color: Colors.red,
            ),
            Container(
              padding: EdgeInsets.all(10),
              // Linkify: 텍스트 내의 URL을 자동으로 인식하고 링크로 만들어줍니다.
              child: Linkify(
                // onOpen: 링크를 탭했을 때 실행되는 콜백 함수입니다.
                onOpen: (link) async {
                  // Uri.parse(link.url): link.url 문자열을 Uri 객체로 변환하여 canLaunchUrl과 launchUrl에 전달합니다.
                  if (await canLaunchUrl(Uri.parse(link.url))) {
                    await launchUrl(Uri.parse(link.url));
                  }
                },  // MainFest 등록 하기 ex56 참조
                text: "https://github.com/kmdadoo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                linkStyle: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              // 아이콘과 텍스트를 함께 포함하는 버튼
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  '프로필 수정하기',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}