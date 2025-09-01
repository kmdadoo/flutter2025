// flippable_box: ^1.0.6 에서 가져옴. 야믈에 넣어야 할 것을 직접 만든 것임.
// 버전 업 안된 것들을 이렇게 가져와서 사용 가능.
import 'dart:math';
import 'package:flutter/material.dart';

class FlippableBox extends StatelessWidget {
  final double clipRadius;
  final double duration;
  final Curve curve;
  final bool flipVt;
  // final BoxDecoration bg;
  final Container front;
  final Container back;

  final bool isFlipped;

  const FlippableBox(
      {super.key, // null 체크
      this.isFlipped = false,
      required this.front,
      required this.back,
      // required this.bg,
      this.clipRadius = 0, // 초기값을 0으로...
      this.duration = 1,
      this.curve = Curves.easeOut,
      this.flipVt = false});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder( // 애니메이션의 핵심을 담당
      duration: Duration(milliseconds: (duration * 1000).round()),
      curve: Curves.easeOut,
      // ween: Tween은 시작 값(0.0)과 끝 값(180.0)을 정의합니다. 
      // isFlipped가 true면 0.0에서 180.0으로, false면 180.0에서 0.0으로 보간(interpolate)됩니다.
      tween: Tween(begin: 0.0, end: isFlipped ? 180.0 : 0.0),
      // builder: Tween의 보간된 값(value, 0.0 ~ 180.0)을 받아서 UI를 그립니다.
      builder: (context, double value, child) {
        // value 실수로 선언
        // value >= 90 ? back : front: 회전 각도가 90도 이상이면 뒷면(back)을, 그렇지 않으면 앞면(front)을 
        // 보여주도록 선택합니다. 이는 카드가 회전하는 중간에 앞면과 뒷면이 매끄럽게 전환되도록 합니다.
        var content = value >= 90 ? back : front;
        // 두 개의 Rotation3d 위젯이 중첩되어 사용
        // 외부 Rotation3d: 카드의 전체적인 뒤집기 애니메이션을 담당합니다. 
        // flipVt 값에 따라 Y축(rotationY) 또는 X축(rotationX)으로 회전합니다.
        return Rotation3d(
          rotationY: !flipVt ? value : 0,
          rotationX: flipVt ? value : 0,
          // 내부 Rotation3d: 카드가 180도 회전한 후에도 내용이 정방향으로 보이도록 뒤집어주는 역할을 합니다. 
          // 예를 들어, Y축으로 회전할 경우 value > 90일 때 추가로 180도 회전시켜 뒷면이 똑바로 보이게 합니다.
          child: Rotation3d(
            rotationY: !flipVt ? (value > 90 ? 180 : 0) : 0,
            rotationX: flipVt ? (value > 90 ? 180 : 0) : 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(clipRadius),
              child: AnimatedBackground(
                // decoration: bg,
                child: content,
              ),
            ),
          ),
        );
      },
    );
  }
}

class Rotation3d extends StatelessWidget {
  //Degrees to rads constant
  static const double degrees2Radians = pi / 180;

  final Widget child;
  final double rotationX;
  final double rotationY;
  final double rotationZ;

  const Rotation3d(
      {super.key, // null 체크
      required this.child,
      this.rotationY = 0,
      this.rotationZ = 0,
      this.rotationX = 0}); // x도 초기값을줌.

  @override
  Widget build(BuildContext context) {
    // Transform: Flutter의 변환 위젯으로, 자식 위젯에 회전, 크기 조절, 이동 등의 변환 효과를 적용합니다
    return Transform(
        alignment: FractionalOffset.center,
        // Matrix4.identity()..setEntry(3, 2, 0.001): 3D 효과를 주기 위한 원근감(perspective)을 설정합니다. 
        // setEntry(3, 2, 0.001)는 z축을 기준으로 원근감을 추가하여 위젯이 멀어지는 듯한 느낌을 줍니다.
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          // rotateX, rotateY, rotateZ: 라디안 단위로 변환된 회전 각도에 따라 x, y, z축으로 회전 효과를 적용합니다. 
          // degrees2Radians 상수는 도(degree)를 라디안(radian)으로 변환하는 역할을 합니다.
          ..rotateX(rotationX * degrees2Radians)
          ..rotateY(rotationY * degrees2Radians)
          ..rotateZ(rotationZ * degrees2Radians),
        child: child);
  }
}

class AnimatedBackground extends StatelessWidget {
  final Container child;
  // final BoxDecoration decoration;

  const AnimatedBackground({
    super.key,
    required this.child,
    // required this.decoration
  });

  @override
  Widget build(BuildContext context) {
    // AnimatedContainer: duration과 curve 속성을 통해 크기나 배경색 등의 변화에 애니메이션을 자동으로 적용하는 위젯입니다. 
    // 현재 코드에서는 child.constraints!.maxWidth를 사용해 부모 위젯의 크기를 동적으로 가져오고 있습니다.
    return AnimatedContainer(
        width: child.constraints!.maxWidth, // null일수 있으므로 ! 으로 체크
        height: child.constraints!.maxHeight,
        // decoration: decoration,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: child);
  }
}
// TweenAnimationBuilder와 Transform을 결합하여 복잡한 3D 애니메이션을 구현하는 고급 예시입니다. 
// 특히, 90도를 기준으로 앞면과 뒷면 위젯을 교체하는 로직은 뒤집기 애니메이션의 핵심 기법 중 하나입니다.
