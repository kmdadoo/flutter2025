import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

/// Firebase Authentication을 사용하여 사용자 로그아웃 기능을 구현한 HomeScreen 위젯입니다. 
/// 이 화면은 로그인한 사용자의 이메일을 표시하고, 로그아웃 버튼을 제공하여 다시 로그인 페이지로 돌아갈 수 있도록 합니다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//  이메일 주소를 표시하고 로그아웃 기능을 수행
class _HomeScreenState extends State<HomeScreen> {
  // Firebase.instance.currentUser를 통해 현재 로그인된 사용자의 정보를 가져옵니다. 
  // 사용자가 로그인되어 있지 않다면 null이 됩니다.
  User? user = FirebaseAuth.instance.currentUser;
  // 로그인한 사용자의 이메일 주소를 저장할 변수
  String userEmail = "";

  @override
  Widget build(BuildContext context) {
    // user와 email이 null이 아님을 확신할 때 사용합니다.
    userEmail = user!.email!;

    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, 
                                 fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "[ $userEmail ]", // user 변수에서 가져온 이메일 주소를 화면에 보여줍니다. 
                style: const TextStyle(fontSize: 20, 
                                       fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize( // AppBar를 반환하기 위해 사용되는 위젯
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton( // 로그아웃 기능을 수행하는 버튼
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }

  // logout 함수
  Future<void> logout(BuildContext context) async {
    // Firebase Authentication의 signOut() 메서드를 호출하여 현재 사용자를 로그아웃시킵니다. 
    // 이 작업은 비동기적으로 수행됩니다.
    await FirebaseAuth.instance.signOut();
      // 로그아웃 작업이 완료된 후, 위젯이 여전히 화면에 마운트(존재)되어 있는지 확인합니다. 
      // 이 검사를 통해 비동기 작업이 끝난 후 위젯이 이미 제거되었을 때 context를 사용하려는 시도를 방지합니다.
      if (context.mounted) {
        // context.mounted가 true일 경우, LoginScreen으로 화면을 전환합니다. 
        // pushReplacement를 사용하여 HomeScreen을 위젯 트리에서 제거하므로,
        // 사용자가 로그아웃 후 뒤로 가기 버튼을 눌러도 이 화면으로 다시 돌아올 수 없습니다.
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
  }
}
