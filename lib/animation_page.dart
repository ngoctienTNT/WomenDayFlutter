import 'dart:math';
import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool selected = false;
  double dx = 0;
  double dy = 0;
  double move = 1;
  double maxMove = 20;
  bool isBack = true;
  double angle = 0;
  String line1 = "Love";
  String line2 = "Chúc em 8/3 xinh đẹp như ảnh trên mạng";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onPanUpdate: (value) {
        setState(() {
          if (value.delta.dx < 0) {
            if (dx > -maxMove) dx -= move;
          }
          if (value.delta.dx > 0) {
            if (dx < maxMove) dx += move;
          }
          if (value.delta.dy < 0) {
            if (dy > -maxMove) dy -= move;
          }
          if (value.delta.dy > 0) {
            if (dy < maxMove) dy += move;
          }
        });
      },
      onTap: () {
        setState(() {
          selected = !selected;
          if (selected) {
            line1 = "My Love";
            line2 = "Chúc em 8/3 vui vẻ và mãi xinh đẹp";
          } else {
            line1 = "Love";
            line2 = "Chúc em 8/3 xinh đẹp như ảnh trên mạng";
          }
          angle = (angle + pi) % (2 * pi);
        });
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.7,
                  image: AssetImage("assets/background/back1.jpg"))),
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(children: [
              boxAniPos(height / 6, 0, dx, dy, 3, context,
                  "assets/images1/img1.png", "assets/images2/img1.png"),
              boxAniPos(0, width / 3, dx, dy, 2, context,
                  "assets/images1/img2.jpg", "assets/images2/img2.jpg"),
              boxAniPos(height * 2 / 6, width / 5, dx, dy, 3.5, context,
                  "assets/images1/img3.jpg", "assets/images2/img3.jpg"),
              boxAniPos(height * 2 / 5, width * 4 / 6, dx, dy, 2, context,
                  "assets/images1/img4.jpg", "assets/images2/img4.jpg"),
              boxAniPos(height / 20, width * 5 / 8, dx, dy, 2.5, context,
                  "assets/images1/img5.jpg", "assets/images2/img5.jpg"),
              boxAniPos(height / 5, width * 10 / 11, dx, dy, 2, context,
                  "assets/images1/img6.jpg", "assets/images2/img6.jpg"),
              boxAniPos(height * 5 / 7, width * 7 / 8, dx, dy, 3, context,
                  "assets/images1/img7.jpg", "assets/images2/img7.jpg"),
              boxAniPos(height * 6 / 8, width * 3 / 5, dx, dy, 2.5, context,
                  "assets/images1/img8.jpg", "assets/images2/img8.jpg"),
              boxAniPos(height * 7 / 10, width / 3, dx, dy, 3.5, context,
                  "assets/images1/img9.jpg", "assets/images2/img9.jpg"),
              boxAniPos(height * 4 / 5, 0, dx, dy, 2.5, context,
                  "assets/images1/img10.png", "assets/images2/img10.png"),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Text(
                        line1,
                        key: ValueKey<String>(line1),
                        style: const TextStyle(color: Colors.red, fontSize: 60),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Text(
                        line2,
                        key: ValueKey<String>(line2),
                        style:
                            const TextStyle(color: Colors.green, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  AnimatedPositioned boxAniPos(double top, double left, double dx, double dy,
      double mul, BuildContext context, String image1, String image2) {
    return AnimatedPositioned(
        width: 125.0,
        height: 125.0,
        left: left + dx * mul,
        top: top + dy * mul,
        duration: const Duration(seconds: 2),
        curve: Curves.fastLinearToSlowEaseIn,
        child: flipCard(image1, image2));
  }

  TweenAnimationBuilder flipCard(String image1, String image2) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: angle),
        duration: const Duration(seconds: 1),
        builder: (context, val, __) {
          double value = double.parse(val.toString());
          if (value >= (pi / 2)) {
            isBack = false;
          } else {
            isBack = true;
          }
          return (Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(value),
            child: SizedBox(
              width: 309,
              height: 474,
              child: isBack
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(image1),
                        ),
                      ),
                    )
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(image2),
                          ),
                        ),
                      ),
                    ),
            ),
          ));
        });
  }
}
