import 'package:flutter/material.dart';
import 'package:storage/imageupload/image_retrive.dart';
import 'package:storage/imageupload/image_upload.dart';

/// 버튼을 눌러 이미지를 Firebase Storage에 올리거나, 이미 올라간 이미지를 보여주는 
/// 다른 화면으로 이동할 수 있도록 만들었습니다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Firebase Storage Use"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push( // ImageUpload 화면으로 이동
                    context,
                    // 사용자가 기기에서 이미지를 선택하고 Firebase Storage에 업로드하는 기능을 담당합니다.
                    MaterialPageRoute(  // 새로운 화면을 생성
                      builder: (context) => const ImageUpload(),
                    ),
                  );
                },
                child: const Text("Upload Image"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push( // ImageRetrive 화면으로 이동
                    context,
                    //  이미지를 가져와서 사용자에게 보여주는 기능
                    MaterialPageRoute(
                      builder: (context) => const ImageRetrive(),
                    ),
                  );
                },
                child: const Text("Show Uploads"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
