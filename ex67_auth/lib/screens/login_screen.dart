import 'package:auth/screens/home_screen.dart';
import 'package:auth/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Flutter와 Firebase Authentication을 연동하여 사용자의 이메일과 비밀번호 로그인 기능을 구현한 예제입니다. 
/// 로그인 폼, 유효성 검사, Firebase를 통한 인증, 그리고 로그인 성공/실패 시의 UI 피드백을 모두 포함하고 있습니다.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// 로그인 화면의 상태를 관리
class _LoginScreenState extends State<LoginScreen> {
  // GlobalKey<FormState> _formKey: 폼(Form)의 상태를 관리하는 데 사용됩니다. 
  // 이를 통해 한 번에 여러 텍스트 필드의 유효성을 검사할 수 있습니다.
  final _formKey = GlobalKey<FormState>();

  // TextEditingController: 사용자가 입력한 이메일과 비밀번호를 가져오는 컨트롤러입니다.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase Authentication 인스턴스입니다. 
  // 이 객체를 통해 사용자의 로그인, 회원가입, 로그아웃 등의 인증 관련 작업을 수행합니다.
  final _auth = FirebaseAuth.instance;

  @override
  // 여러 TextFormField를 감싸서 유효성 검사를 쉽게 할 수 있도록 돕습니다. 
  // key: _formKey로 폼의 상태를 _formKey에 연결합니다.
  Widget build(BuildContext context) {
    // emailField: 이메일 주소를 입력받는 필드입니다. 
    // validator 속성을 통해 입력값이 비어 있거나 올바른 이메일 형식이 아닐 경우 오류 메시지를 표시합니다.
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // passwordField: 비밀번호를 입력받는 필드입니다. 
    // obscureText: true를 사용해 입력 내용을 가려줍니다. 
    // validator를 통해 비밀번호가 최소 6자 이상인지 확인합니다.
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //  로그인 버튼입니다. 사용자가 이 버튼을 누르면 signIn 함수가 호출됩니다.
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    emailField,
                    const SizedBox(height: 25),
                    passwordField,
                    const SizedBox(height: 35),
                    loginButton,
                    const SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // GestureDetector를 사용하여 "SignUp" 텍스트에 탭 이벤트를 추가했습니다. 
                          // 탭 시 RegistrationScreen으로 이동하여 회원가입을 할 수 있습니다.
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()));
                            },
                            child: const Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 사용자가 로그인 버튼을 눌렀을 때 실행되는 핵심 로직
  void signIn(String email, String password) async {
    // 폼에 있는 모든 TextFormField의 validator를 실행하여 입력값의 유효성을 검사합니다. 
    // 모든 필드가 유효하면 다음 코드가 실행됩니다.
    if (_formKey.currentState!.validate()) {
      try{
        // _auth.signInWithEmailAndPassword(...): Firebase Auth의 핵심 메서드입니다. 
        // 사용자가 입력한 이메일과 비밀번호로 로그인 인증을 시도합니다.
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        if (!mounted) return;

        // 로그인이 성공하면 실행되는 부분입니다. SnackBar를 통해 "Login Successful" 메시지를 보여주고, 
        // Navigator.pushReplacement를 사용해 HomeScreen으로 이동합니다. 
        // pushReplacement는 현재 화면을 새로운 화면으로 교체하여 뒤로 가기 버튼을 눌러도 로그인 화면으로 돌아가지 않도록 합니다.
        // 비동기 작업 후, 위젯이 여전히 화면에 있는지 확인
        showSnackBar("Login Successful", const Duration(milliseconds: 1000));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } on FirebaseAuthException catch (e){ // 로그인 실패(예: 잘못된 이메일, 비밀번호 등) 시 실행
        if (!mounted) return;
        showSnackBar(e.message ?? '로그인 실패', const Duration(milliseconds: 3000));
      }
    }
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
