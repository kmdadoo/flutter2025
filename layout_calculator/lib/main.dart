import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: '실습 : 계산기'),
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
  // LCD에 출력할 문자열과 계산을 위한 문자열
  String _displayText = "0", _tempText = "0";
  // 연산자를 저장하는 변수
  String _operText = "";
  // 계산할 숫자와 연산자를 순서대로 저장하는 리스트
  final List<String> _equationList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // 화면 상단에 검은색 배경
            Expanded(
              child: Row(
                // 텍스트가 화면의 오른쪽 아래에 정렬
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      color: Colors.grey[600],
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _displayText, // 변수에 저장된 문자열이 여기에 표시
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 계산기 화면
            // 0번째 행
            Row(  // 버튼들을 가로로 배열했습니다. 각 행마다 4개의 버튼
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded( // 각 버튼이 가로 공간을 균등하게 차지하도록 합니다.
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1, // 버튼이 정사각형 모양(1 / 1)을 유지. 여기서는 원
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(4, 2, 2, 2),
                      child: ElevatedButton(  //  각각의 계산기 버튼
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                        ),
                        child: const Text(
                          "C",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('clear');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                        ),
                        child: const Text(
                          "+/-",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                         
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                        ),
                        child: const Text(
                          "%",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 4, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text(
                          "/",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('/');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 1번째 행
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(4, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "7",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('7');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "8",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('8');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "9",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('9');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 4, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        // 곱셈, 곱하기
                        child: const Text(
                          "*",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('*');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 2번째 행
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(4, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "4",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('4');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "5",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('5');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "6",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('6');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 4, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        // 뺄셈, 빼기
                        child: const Text(
                          "-",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('-');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 3번째 행
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(4, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "1",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('1');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "2",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('2');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "3",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('3');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 4, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        // 덧셈, 더하기
                        child: const Text(
                          "+",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('+');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 4번째 행
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 2 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(4, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          "0",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('0');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text(
                          ".",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _inputNum('.');
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(    // 자식 위젯을 특정한 비율로 만드는 클래스
                    aspectRatio: 1 / 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 2, 4, 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text(
                          "=",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _calculate();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _realCal(){ 
    double prev = 0;
    double current = 0;
    String mode = "";


    //곱셈이나 나눗셈의 경우 먼저 연산한다.// 실제 계산 하는 메서드
    for (int i = 0; i < _equationList.length; i++) {
      //원소를 하나씩 확인
      String s = _equationList[i];
      //print(s);
      if (s == "+") {
        mode = "";
      } else if (s == "-") {
        mode = "";
      } else if (s == "*") {
        mode = "mul";
      } else if (s == "/") {
        mode = "div";
      } else {
        if (mode == "mul" || mode == "div" && s != "+" && s != "-" && s != "*" && s != "/"){
          //List에는 [숫자1, 연산자, 숫자2] 와 같은 형태로 저장되어 있다.
          double one = double.parse(_equationList[i-2]);//숫자1
          double two = double.parse(_equationList[i]);//숫자2
          double result = 0.0;


          //연산한 결과를 숫자2 다음에 삽입한다.
          if (mode == "mul"){
            result = one * two;
          } else if (mode == "div") {
            result = one / two;
          }
          //print(result.toString());
          _equationList.insert(i+1, result.toString());


          //숫자1부터 차례대로 3개의 원소를 삭제한다.
          for (int j = 0; j < 3; j++) {
            _equationList.removeAt(i - 2);
          }
          
          //연산결과를 입력한 인덱스로 이동한다.
          i -= 2;
        }
      }
    }


    for (String s in _equationList) {
      if (s == "+") {
        mode = "add";
      } else if (s == "-") {
        mode = "sub";
      }  else {
        current = double.parse(s);
        if (mode == "add") {
          prev += current;
        } else if (mode == "sub") {
          prev -= current;
        } else {
          prev = current;
        }
      }
      //prev = Math.round(prev * 100000) / 100000.0;
    }


    //print(prev);
    return prev.toString();
  }

  void _calculate(){
    //마지막에 누른 키가 연산자가 아닐때만 추가
    if(_operText == ""){
      //이퀄을 누르면 제일 마지막에 입력한 수를 리스트에 추가해야한다.    
      _equationList.add(_tempText);     
    }
    else{
      //print(_equationList.length);
      //만약 마지막에 연산자를 눌렀다면 마지막 원소 제거
      _equationList.removeAt(_equationList.length-1);
    }
  
    //print("_displayText : $_displayText");
    //print("_equationList : $_equationList");
    //print("계산결과 : ${_realCal()}");


    //초기화
    String result = _realCal();
    //print(result);
    _equationList.clear();
    _tempText = "0";
    _operText = "";


    setState(() {
      _displayText = result;
      }
    );
  }

  void _inputNum(String num){
   //print("click=$num");
    setState(() {
      //clear를 누르면 무조건 0으로 초기화한다.
      if(num == 'clear'){
        _displayText = "0";
        _tempText = "0";
        _equationList.clear();
        return;
      }   
      //만약 첫 입력이라면 0을 지운후 숫자를 입력한다.
      if(_tempText == '0') {
        _tempText = '';
        _tempText += num;


        _displayText = '';
        _displayText += num;
      }
      else{
        if(num == '+' || num == '-' || num == '*' || num == '/'){         
          if(_operText == ''){
            //연산자인 경우 List에 삽입
            _equationList.add(_tempText);
            _tempText = "";
            _equationList.add(num);
            _displayText += num;
          } 
          else{           
            //List에 반영(마지막의 연산자를 지우고 새것으로 교체)
            _equationList.removeAt(_equationList.length-1);
            _equationList.add(num);
            //print(_equationList);


            //연산자를 중복해서 입력한다면 마지막만 교체
            _displayText = _displayText.substring(0, _displayText.length-1)+num;
          }
         _operText = num;//연산자 변경하기
        }
        else{
         //숫자인 경우 문자열 연결
         _tempText += num;
         _operText = "";//연산자 지우기
         //LCD는 계속 연결되야 함
         _displayText += num;
        }                 
      }     
    });
  }
}
