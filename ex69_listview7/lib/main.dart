import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//  flutter_slidable 패키지를 사용하여 목록 항목을 옆으로 밀어(슬라이드) 액션 버튼을 표시하는 기능을 구현합니다. 
// 이 예제는 다양한 슬라이드 동작과 추가적인 기능을 보여줍니다.
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // AppState 위젯으로 MyHomePage를 감싸서 앱 전체에서 슬라이드 방향을 쉽게 접근할 수 있도록 합니다. 
      // 기본 방향은 Axis.horizontal (수평)입니다.
      home: const AppState(
        direction: Axis.horizontal,
        child: MyHomePage(title : 'Ex69 ListView #7(Slidable)'),
      ),
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
  bool alive = true;

  @override
  Widget build(BuildContext context) {
    final direction = AppState.of(context)!.direction;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        // SlidableAutoCloseBehavior 위젯이 사용됩니다. 
        // 이 위젯은 여러 슬라이드 항목 중 하나를 열면 다른 항목이 자동으로 닫히도록 해줍니다.
        child: SlidableAutoCloseBehavior(
          child: ListView(
            // scrollDirection은 AppState에서 가져온 direction에 따라 목록이 수평으로 스크롤될지 수직으로 스크롤될지 결정됩니다.
            scrollDirection: flipAxis(direction),
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                //  각 목록 항목을 감싸서 슬라이드 기능을 제공하는 핵심 위젯
                child: Slidable(  // Slidable은 ActionPane 내부에 SlideAction 위젯을 사용하여 개별 버튼을 정의
                  key: const ValueKey(1),
                  groupTag: '0',
                  direction: direction,
                  // startActionPane: 아이템을 오른쪽으로 밀었을 때(LTR 기준) 나타나는 액션 버튼 그룹입니다.
                  // ActionPane: 슬라이드 시 나타나는 액션 버튼 그룹입니다.
                  startActionPane: const ActionPane(
                    openThreshold: 0.1,
                    closeThreshold: 0.4,
                    // 다양한 동작 (Motion): BehindMotion, StretchMotion, ScrollMotion, DrawerMotion을 
                    // 사용하여 슬라이드 애니메이션을 다르게 연출합니다.
                    motion: StretchMotion(),
                    children: [
                      SlideAction(color: Colors.green, icon: Icons.share),
                      SlideAction(color: Colors.amber, icon: Icons.delete),
                    ],
                  ),
                  // endActionPane: 아이템을 왼쪽으로 밀었을 때(LTR 기준) 나타나는 액션 버튼 그룹입니다.
                  endActionPane: const ActionPane(
                    // BehindMotion(): 항목이 밀려나면서 그 뒤에 액션 버튼이 나타나는 가장 기본적인 동작입니다.
                    motion: BehindMotion(),
                    children: [
                      SlideAction(
                          color: Colors.red, icon: Icons.delete_forever),
                      SlideAction(
                          color: Colors.blue, icon: Icons.alarm, flex: 2),
                    ],
                  ),
                  child: const Tile(color: Colors.grey, text: 'hello 1'),
                ),
              ),
              Slidable(
                key: const ValueKey(2),
                groupTag: '0',
                direction: direction,
                startActionPane: const ActionPane(
                  // StretchMotion(): 항목과 액션 버튼이 함께 늘어나면서 나타납니다.
                  motion: StretchMotion(),
                  children: [
                    SlideAction(color: Colors.green, icon: Icons.share),
                    SlideAction(color: Colors.amber, icon: Icons.delete),
                  ],
                ),
                endActionPane: const ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlideAction(color: Colors.red, icon: Icons.delete_forever),
                    SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 3),
                  ],
                ),
                child: const Tile(color: Colors.pink, text: 'hello 2'),
              ),
              Slidable(
                key: const ValueKey(3),
                direction: direction,
                startActionPane: const ActionPane(
                  // ScrollMotion(): 액션 버튼이 항목과 함께 스크롤되면서 나타납니다.
                  motion: ScrollMotion(),
                  children: [
                    SlideAction(color: Colors.green, icon: Icons.share),
                    SlideAction(color: Colors.amber, icon: Icons.delete),
                  ],
                ),
                endActionPane: const ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlideAction(color: Colors.red, icon: Icons.delete_forever),
                    SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                  ],
                ),
                child: const Tile(color: Colors.yellow, text: 'hello 3'),
              ),
              if (alive)
                Slidable(
                  key: const ValueKey(4),
                  direction: direction,
                  startActionPane: ActionPane( // 오른쪽으로 밀었을 때
                    // DrawerMotion(): 서랍이 열리듯 액션 버튼이 나타납니다. 
                    // 이 동작은 DismissiblePane과 함께 사용되어 항목을 완전히 사라지게 할 수 있습니다.
                    motion: const DrawerMotion(),
                    //  목록 항목을 완전히 슬라이드하여 제거하는 기능입니다. 제거 전 확인 대화상자도 표시합니다.
                    dismissible: DismissiblePane(
                      // onDismissed: 항목이 완전히 사라졌을 때 alive = false로 상태를 변경하여 화면에서 제거합니다
                      onDismissed: () {
                        setState(() {
                          alive = false;
                        });
                      },
                      closeOnCancel: true,
                      // confirmDismiss: 항목을 제거하기 전에 AlertDialog를 띄워 사용자에게 한 번 더 확인을 요청합니다. 
                      // 사용자가 'Yes'를 누르면 true를 반환하여 제거를 진행하고, 'No'를 누르면 false를 반환하여 취소합니다.
                      confirmDismiss: () async {
                        return await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Are you sure?'),
                                  content:
                                      const Text('Are you sure to dismiss?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                      },
                    ),
                    children: const [
                      SlideAction(color: Colors.green, icon: Icons.share),
                      SlideAction(color: Colors.amber, icon: Icons.delete),
                    ],
                  ),
                  endActionPane: const ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlideAction(
                          color: Colors.red, icon: Icons.delete_forever),
                      SlideAction(
                          color: Colors.blue, icon: Icons.alarm, flex: 2),
                    ],
                  ),
                  child: const Tile(color: Colors.lime, text: 'hello 4'),
                ),
              Slidable(
                key: const ValueKey(5),
                direction: direction,
                startActionPane: const ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.green, icon: Icons.share),
                    SlideAction(color: Colors.amber, icon: Icons.delete),
                  ],
                ),
                endActionPane: const ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.red, icon: Icons.delete_forever),
                    SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                  ],
                ),
                child: const Tile(color: Colors.grey, text: 'hello'),
              ),
              Slidable(
                key: const ValueKey(6),
                direction: direction,
                startActionPane: const ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.green, icon: Icons.share),
                    SlideAction(color: Colors.amber, icon: Icons.delete),
                  ],
                ),
                endActionPane: const ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.red, icon: Icons.delete_forever),
                    SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                  ],
                ),
                child: const Tile(color: Colors.grey, text: 'hello'),
              ),
              Slidable(
                key: const ValueKey(7),
                direction: direction,
                startActionPane: const ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.green, icon: Icons.share),
                    SlideAction(color: Colors.amber, icon: Icons.delete),
                  ],
                ),
                endActionPane: const ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.red, icon: Icons.delete_forever),
                    SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                  ],
                ),
                child: const Tile(color: Colors.grey, text: 'hello'),
              ),
              Slidable(
                key: const ValueKey(8),
                direction: direction,
                startActionPane: const ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.green, icon: Icons.share),
                    SlideAction(color: Colors.amber, icon: Icons.delete),
                  ],
                ),
                endActionPane: const ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.red, icon: Icons.delete_forever),
                    SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                  ],
                ),
                child: const Tile(color: Colors.grey, text: 'hello'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// SlideAction: 재사용성을 위해 SlidableAction 위젯을 래핑한 커스텀 위젯입니다. 
// 버튼의 색상, 아이콘, 유연성(flex)을 설정할 수 있습니다.
class SlideAction extends StatelessWidget {
  const SlideAction({
    super.key,
    required this.color,
    required this.icon,
    this.flex = 1,
  });

  final Color color;
  final IconData icon;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      flex: flex,
      backgroundColor: color,
      foregroundColor: Colors.white,
      onPressed: (_) {
        debugPrint('$icon');
      },
      icon: icon,
      label: 'hello',
    );
  }
}

// Tile: 목록에 표시되는 개별 항목 위젯입니다. GestureDetector를 사용하여 탭, 롱프레스 이벤트를 처리합니다. 
// 롱프레스 시 Slidable.of(context)!.openEndActionPane()을 호출하여 자동으로 슬라이드 패널을 엽니다.
class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    final direction = AppState.of(context)!.direction;
    return ActionTypeListener(
      child: GestureDetector(
        onTap: () {
          debugPrint(text);
        },
        onLongPress: () => Slidable.of(context)!.openEndActionPane(),
        child: Container(
          color: color,
          height: direction == Axis.horizontal ? 100 : double.infinity,
          width: direction == Axis.horizontal ? double.infinity : 100,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}

// ActionTypeListener: 슬라이드 패널의 열림/닫힘 상태를 감지하는 리스너를 구현한 위젯입니다. 
// 디버그 콘솔에 현재 상태를 출력합니다.
class ActionTypeListener extends StatefulWidget {
  const ActionTypeListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ActionTypeListener> createState() => _ActionTypeListenerState();
}

class _ActionTypeListenerState extends State<ActionTypeListener> {
  ValueNotifier<ActionPaneType>? _actionPaneTypeValueNotifier;

  @override
  void initState() {
    super.initState();
    _actionPaneTypeValueNotifier = Slidable.of(context)?.actionPaneType;
    _actionPaneTypeValueNotifier?.addListener(_onActionPaneTypeChanged);
  }

  @override
  void dispose() {
    _actionPaneTypeValueNotifier?.removeListener(_onActionPaneTypeChanged);
    super.dispose();
  }

  void _onActionPaneTypeChanged() {
    debugPrint('Value is ${_actionPaneTypeValueNotifier?.value}');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// AppState: InheritedWidget으로, 앱의 전역적인 상태(여기서는 슬라이드 방향)를 자식 위젯들에게 효율적으로 전달합니다. 
// of(context) 메서드를 통해 어디서든 이 상태에 접근할 수 있습니다.
class AppState extends InheritedWidget {
  const AppState({
    super.key,
    required this.direction,
    required super.child,
  });

  final Axis direction;

  @override
  bool updateShouldNotify(covariant AppState oldWidget) {
    return direction != oldWidget.direction;
  }

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }
}