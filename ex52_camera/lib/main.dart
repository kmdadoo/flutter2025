import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Ex52_Camera'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isReady = false;
  bool _isTakingPhoto = false;
  
  // 카메라를 초기화
  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  // 사용 가능한 카메라 목록을 가져와 첫 번째 카메라를 사용하도록 CameraController를 설정
  Future<void> _initCamera() async {
    try{
      _cameras = await availableCameras();
      if (_cameras!.isEmpty) {
          debugPrint("No cameras found.");
          // Handle case where no cameras are available, e.g., show an error message.
          return;
      }
      _controller = CameraController(_cameras!.first, ResolutionPreset.high);
      await _controller!.initialize();
      setState(() => _isReady = true);  //  _isReady 상태를 true로 바꿔 화면을 다시 그립니다
    } on CameraException catch (e) {
      debugPrint("카메라 초기화 오류 : $e");
      // Handle camera initialization errors.
    } 
  }

  // 사용자가 카메라 버튼을 눌렀을 때 실행
  Future<void> _takeAndSavePhoto() async {
    if (!_isReady || _isTakingPhoto) return;

    // _isTakingPhoto 상태를 true로 설정해 사용자가 여러 번 버튼을 
    // 누르지 못하도록 막고, 화면에 로딩 표시를 보여줍니다.
    setState(() {
      _isTakingPhoto = true;
    }); 

    try{
      // 1. 사진 촬영
      final XFile file = await _controller!.takePicture(); // 사진을 찍고 XFile 객체로 받습니다.

      // 2. 앱 내부 디렉토리에 복사
      // 앱 내부 저장소 경로를 가져온 다음
      final dir = await getApplicationDocumentsDirectory();
      // 타임스탬프를 포함한 고유한 파일명으로 사진을 복사
      final savedFile = File('${dir.path}/photo_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await File(file.path).copy(savedFile.path);

      // 3. 공유 → 사용자가 갤러리 앱 선택 가능
      if (mounted) {
        // 시스템의 공유 시트를 띄웁니다. 이를 통해 사용자는 사진을 갤러리에 
        // 저장하거나 다른 앱으로 보낼 수 있습니다.
        await SharePlus.instance.share( 
          ShareParams(
          files: [XFile(savedFile.path)],
          text: '갤러리에 저장하세요',
          )
        );
      }
    }on CameraException catch (e) {
      debugPrint("Error taking photo: $e");
    }
    // 모든 작업이 끝난 후, finally 블록에서 _isTakingPhoto 상태를 다시 
    // false로 설정하여 버튼을 활성화하고 로딩 표시를 숨깁니다. 
    finally {
      setState(() {
        _isTakingPhoto = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // _isReady 상태에 따라 **카메라 미리보기(CameraPreview)**를 보여주거나 
        // 카메라 초기화 중임을 알리는 **원형 로딩 표시(CircularProgressIndicator)**를 보여줍니다.
        child: _isReady
            ? CameraPreview(_controller!)
            : const CircularProgressIndicator(),
      ),
      // FloatingActionButton은 _isReady 상태일 때만 활성화되며, 
      // _isTakingPhoto 상태에 따라 카메라 아이콘 또는 로딩 표시를 보여줍니다.
      floatingActionButton: FloatingActionButton(
        onPressed: _isReady ? _takeAndSavePhoto : null,
        child: _isTakingPhoto
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Icon(Icons.camera_alt),
      ),
    );
  }

  // dispose() 함수는 위젯이 화면에서 사라질 때 호출되며, _controller.dispose()를 
  // 통해 카메라 리소스를 해제합니다. 이는 메모리 누수를 방지하는 매우 중요한 단계입니다.
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}