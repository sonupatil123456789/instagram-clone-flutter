// import 'package:flutter/material.dart';
// import 'package:instagram_clone/utils/theams/color_pallet.dart';
// import 'package:like_button/like_button.dart';

// class LikeHeart extends StatefulWidget {
//   Function onPress;

//   LikeHeart({super.key, required this. onPress});

//   @override
//   State<LikeHeart> createState() => _LikeHeartState();
// }

// class _LikeHeartState extends State<LikeHeart> {

//   @override
//   Widget build(BuildContext context) {
//     return LikeButton(
//           circleColor:CircleColor(start: primaryShade500, end:  primaryShade700,),
//           bubblesColor: BubblesColor(
//             dotPrimaryColor: primaryShade500,
//             dotSecondaryColor: primaryShade700,
//           ),
//           likeBuilder: (bool isLiked) {
//             widget.onPress(isLiked);
//             return Icon(
//               Icons.favorite,
//               color: isLiked ? primaryShade500 : grey1,
//               size: 22,
//             );
//           },
//           likeCountAnimationType: LikeCountAnimationType.part,
//         );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:instagram_clone/utils/resources/Image_resources.dart';
// import 'package:instagram_clone/utils/theams/color_pallet.dart';

// class LikeHeart extends StatefulWidget {
//     Function onPress;

//   LikeHeart({super.key, required this. onPress});

//   @override
//   State<LikeHeart> createState() => _LikeHeartState();
// }

// class _LikeHeartState extends State<LikeHeart> {
//   bool _isLiked = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isLiked = !_isLiked;
//         });
//         widget.onPress(_isLiked);
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//         child: Transform.scale(
//           scale: _isLiked ? 1.2 : 1.0,
// child: Image.asset(
//   _isLiked ? ImageResources.likeFilled : ImageResources.like,
//   width: 18,
//   height: 18,
//   color: _isLiked ? errorColor : grey1,
//   colorBlendMode: BlendMode.srcIn,
// ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class DoubleTapLikeButton extends StatefulWidget {
  final Duration animationDuration;
  final VoidCallback onDoubleTap;

  const DoubleTapLikeButton({
    super.key,
    this.animationDuration = const Duration(milliseconds: 400),
    required this.onDoubleTap,
  });

  @override
  _DoubleTapLikeButtonState createState() => _DoubleTapLikeButtonState();
}

class _DoubleTapLikeButtonState extends State<DoubleTapLikeButton>
    with TickerProviderStateMixin , ScreenUtils{
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  void _startAnimation() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animationController.addListener(() {
      setState(() {});
    });
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_animationController);
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        _startAnimation();
        _opacityAnimation =Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
        Future.delayed(const Duration(milliseconds: 1500), () {
        _opacityAnimation =Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
          setState(() {});
        });
        widget.onDoubleTap();
      },
      child: Stack(
        children: [
          AnimatedOpacity(
            // opacity: 1.0,
            opacity: _opacityAnimation.value,
            duration: widget.animationDuration,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child:  Icon(
                Icons.favorite,
                color: primaryShade500,
                size: super.screenHeightPercentage(context, 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
