import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/screens/home_screen.dart';

/// Firebase Authentication을 연동하여 이메일과 비밀번호로 회원가입하는 기능을 구현한 RegistrationScreen 위젯입니다. 
/// 사용자는 이 화면에서 회원가입에 필요한 정보를 입력하고, 유효성 검사를 거쳐 계정을 생성할 수 있습니다.
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

// 회원가입 화면의 상태를 관리
class _RegistrationScreenState extends State<RegistrationScreen> {
  // _auth: Firebase Authentication 인스턴스입니다.
  final _auth = FirebaseAuth.instance;

  // _formKey: 폼(Form)의 상태를 관리하는 키입니다.
  final _formKey = GlobalKey<FormState>();
  // TextEditingController: 이메일, 비밀번호, 비밀번호 확인 필드의 입력값을 제어하는 컨트롤러입니다.
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  // 입력 필드들을 감싸 유효성 검사를 쉽게 만듭니다.
  Widget build(BuildContext context) {
    // emailField: 이메일 주소를 입력받으며, 입력값이 유효한 이메일 형식인지 정규식(RegExp)을 이용해 검사합니다.
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
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
          emailEditingController.text = value!;
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

    // passwordField: 비밀번호를 입력받으며, 최소 6자 이상인지 검사합니다.
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
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
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // confirmPasswordField: 비밀번호 확인 필드입니다. 
    // validator에서 passwordEditingController.text와 일치하는지 확인하여 비밀번호 일치 여부를 검사합니다.
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // signUpButton: 사용자가 누르면 signUp 함수를 호출하여 회원가입을 시도합니다.
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // Navigator.of(context).pop()은 스택의 최상단 위젯을 제거하여 이전 화면으로 돌아가는 역할을 합니다.
            Navigator.of(context).pop();
          },
        ),
      ),
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
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 20),
                    signUpButton,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 회원가입 함수
  void signUp(String email, String password) async {
    // if (_formKey.currentState!.validate()): 모든 입력 필드의 유효성 검사를 실행합니다. 
    // 모두 통과하면 다음 코드가 실행됩니다.
    if (_formKey.currentState!.validate()) {  // 폼 유효성 검사
      try{
        // _auth.createUserWithEmailAndPassword(...): Firebase Authentication의 메서드를 사용하여 
        // 이메일과 비밀번호로 새로운 사용자를 생성합니다.
        await _auth.createUserWithEmailAndPassword(email: email, password: password); // Firebase에 새 사용자 생성
        // 회원가입이 성공하면 postDetailsToFirestore() 함수를 호출합니다.
        if (mounted) {
          postDetailsToFirestore();
        }
      }on FirebaseAuthException catch (e) {
        // Firebase 인증 예외 처리 (e.g., 이미 사용 중인 이메일, 유효하지 않은 비밀번호 등)
        // 회원가입 실패 시(예: 이미 사용 중인 이메일, 유효하지 않은 비밀번호 등) 
        // Firebase에서 반환하는 오류 메시지를 SnackBar로 사용자에게 보여줍니다.
        /**
         if (mounted)를 사용하면 비동기 작업이 완료된 시점에 위젯이 여전히 화면에 존재하는지 확인할 수 있습니다. 
         위젯이 이미 제거되었다면 (mounted가 false), postDetailsToFirestore()나 showSnackBar()와 같이 BuildContext를 
         사용하는 코드가 실행되지 않아 오류를 방지할 수 있습니다. 
         이 부분은 Flutter 앱의 안정성을 높이는 데 매우 중요합니다.
         */
        if (mounted) {
          showSnackBar(e.message ?? '회원가입 실패', const Duration(seconds: 3));
        } 
      } catch (e) {
        // 다른 일반 예외 처리
        if (mounted) {
          showSnackBar('알 수 없는 오류가 발생했습니다: $e', const Duration(seconds: 3));
        }
      }
    }
  }

  // 회원가입 완료 후 처리 함수
  postDetailsToFirestore() async {
    // User? user = _auth.currentUser;: 회원가입이 완료되면 현재 로그인된(즉, 방금 생성된) 사용자의 정보를 가져옵니다.
    User? user = _auth.currentUser;
    debugPrint(user!.email);
    debugPrint(user.uid);
    // userModel.email = user!.email;
    // userModel.uid = user.uid;

    showSnackBar("Account created successfully :)",
        const Duration(milliseconds: 1000));

    // 회원가입이 성공적으로 완료되면 HomeScreen으로 화면을 전환합니다.
    // pushAndRemoveUntil은 현재 화면 스택의 모든 화면을 제거하고 새로운 화면을 푸시합니다. 
    // (route) => false는 모든 이전 라우트(화면)를 제거하라는 의미입니다. 
    // 따라서 사용자는 회원가입 후 뒤로 가기 버튼을 눌러도 이 화면으로 돌아올 수 없습니다.
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
