import 'package:flutter/material.dart';

class NoInternetOverlayContainer extends StatefulWidget {
  NoInternetOverlayContainer({Key? key}) : super(key: key);

  @override
  State<NoInternetOverlayContainer> createState() =>
      NoInternetOverlayContainerState();
}

class NoInternetOverlayContainerState extends State<NoInternetOverlayContainer>
    with TickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500))
        ..forward();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SlideTransition(
        position: Tween<Offset>(begin: Offset(0.0, 0.5), end: Offset(0.0, 0.0))
            .animate(
          CurvedAnimation(
              parent: animationController, curve: Curves.easeInOutCirc),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Text(
              "No internet",
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(color: Colors.black45),
          ),
        ),
      ),
    );
  }
}
