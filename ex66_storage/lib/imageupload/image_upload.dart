import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 이미지를 업로드하는 기능을 구현한 ImageUpload 위젯
class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

// 위젯의 상태를 관리
class _ImageUploadState extends State<ImageUpload> {
  // 사용자가 갤러리에서 선택한 이미지를 저장하는 변수입니다. 
  // File 타입은 파일 시스템의 경로를 나타내며, ?는 이미지가 선택되지 않았을 때는 null이 될 수 있음을 의미합니다.
  File? _image;
  // image_picker 패키지의 인스턴스를 생성합니다. 
  // 이 객체를 통해 갤러리나 카메라에 접근하여 이미지를 선택할 수 있습니다.
  final imagePicker = ImagePicker();
  String? downloadURL;

  // shared_preferences 패키지를 사용해 간단한 데이터를 기기에 저장합니다. 
  // 여기서는 업로드된 이미지의 다운로드 URL을 저장하는 데 사용됩니다.
  late SharedPreferences prefs;

  @override
  // 위젯의 초기 상태를 설정하며, getSharedPreferences()를 호출하여 SharedPreferences 객체를 가져옵니다.
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  // SharedPreferences.getInstance()를 호출하여 비동기적으로 SharedPreferences 인스턴스를 얻습니다. 
  // prefs.clear()는 이전의 저장된 데이터를 모두 지우는 역할을 합니다.
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future imagePickerMethod() async {
    // imagePicker.pickImage(source: ImageSource.gallery)를 호출하여 사용자가 갤러리에서 이미지를 선택하도록 합니다.
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    // _image 변수에 선택된 파일 객체를 할당합니다. 
    // 이로 인해 화면이 다시 그려지고 선택된 이미지가 화면에 표시됩니다.
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        // showSnackBar()를 호출하여 사용자에게 알립니다.
        showSnackBar("No File selected", const Duration(microseconds: 400));
      }
    });
  }

  Future uploadImage(File image) async {
    // 현재 시간을 기반으로 고유한 이미지 ID를 생성합니다. 
    // 이는 Firebase Storage에서 파일 이름이 중복되지 않도록 하기 위함입니다.
    final imgId = DateTime.now().microsecondsSinceEpoch.toString();

    // Firebase Storage의 images 폴더 내에 post_<고유ID>라는 파일 이름으로 
    // 이미지를 저장할 **참조(Reference)**를 만듭니다.
    Reference reference =
        FirebaseStorage.instance.ref().child('/images').child("post_$imgId");

    // putFile() 메서드를 사용해 선택된 이미지를 Firebase Storage에 업로드합니다.
    await reference.putFile(image);
    // 업로드가 완료되면 해당 이미지에 접근할 수 있는 공개 URL을 가져옵니다.
    downloadURL = await reference.getDownloadURL();

    //조회할 때 사용하기 위해 저장
    // 가져온 다운로드 URL을 shared_preferences에 저장합니다. 
    // 이 URL은 앱의 다른 화면(예: ImageRetrive 화면)에서 이미지를 불러오는 데 사용될 수 있습니다.
    prefs.setString("imageUrl", downloadURL!);

    debugPrint("File Uploaded : $downloadURL");
    showSnackBar("File Uploaded", const Duration(microseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Upload Image"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  const Text("Upload Image"),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.indigoAccent),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              // 삼항 연산자를 사용하여 _image가 null인 경우("No image selected")와 이미지가 
                              // 있는 경우(선택된 이미지 표시)를 분기하여 화면에 보여줍니다.
                              child: _image == null
                                  ? const Center(
                                      child: Text("No image selected"))
                                  : Image.file(_image!)),
                            ElevatedButton(
                              onPressed: () {
                                // imagePickerMethod()를 호출하여 갤러리를 엽니다.
                                imagePickerMethod();
                              },
                              child: const Text("Select Image"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_image != null) {
                                  // uploadImage()**를 호출하여 선택된 이미지를 Firebase Storage에 업로드합니다
                                  uploadImage(_image!);
                                } else {
                                  showSnackBar("Slect Image fiest",
                                      const Duration(microseconds: 400));
                                }
                              },
                              child: const Text("Show Uploads"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
