import 'package:flutter/material.dart';

class AnimatedListHelper {


  static final AnimatedListHelper _singleton = AnimatedListHelper._internal();

  factory AnimatedListHelper() {
    return _singleton;
  }

  AnimatedListHelper._internal();

  void animateAdd(GlobalKey<AnimatedListState> key) {
    key.currentState?.insertItem(0);
  }

  void animateRemove(GlobalKey<AnimatedListState> key, int index) {
    key.currentState!.removeItem(
      index,
      (context, animation) =>
          RemoveCardAnimation(animation: animation, icon: Icons.label),
    );
  }

}

class RemoveCardAnimation extends StatelessWidget {
  final Animation<double> animation;
  final IconData icon;
  const RemoveCardAnimation({Key? key, required this.animation, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: animation,
        child: Card(
          child:
              ListTile(leading: Icon(icon), trailing: const Icon(Icons.close)),
        ));
  }
}