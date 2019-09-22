import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:studymate/widgets/MultiOptionButton/AnimationToPlay.dart';

class MultiOptionButton extends StatefulWidget {
  _MultiOptionButton createState() => _MultiOptionButton();
}

class _MultiOptionButton extends State<MultiOptionButton> {
  bool isOpen = false;
  static const double animationWidth = 245.0;
  static const double animationHeight = 211.0;
  final FlareControls animationControls = FlareControls();

  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  // Add our lastPlayed member
  AnimationToPlay _lastPlayedAnimation;

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Activate:
        return 'activate';
      case AnimationToPlay.Deactivate:
        return 'deactivate';
      case AnimationToPlay.CameraTapped:
        return 'camera_tapped';
      case AnimationToPlay.PulseTapped:
        return 'pulse_tapped';
      case AnimationToPlay.ImageTapped:
        return 'image_tapped';
        break;
      default:
        return 'deactivate';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    var isTappedAnimation = _getAnimationName(animation).contains("_tapped");
    // We don't want to play the tapped animation if the last played one was deactivate
    if (isTappedAnimation &&
        _lastPlayedAnimation == AnimationToPlay.Deactivate) {
      return;
    }

    animationControls.play(_getAnimationName(animation));

    // remember our last played animation
    _lastPlayedAnimation = animation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: animationWidth,
        height: animationHeight,
        child: GestureDetector(
          onTapUp: (tapInfo) {
            var localTouchPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(tapInfo.globalPosition);

            var topHalfTouched = localTouchPosition.dy < animationHeight / 2;

            var leftSideTouched = localTouchPosition.dx < animationWidth / 3;

            var rightSideTouched =
                localTouchPosition.dx > (animationWidth / 3) * 2;

            var middleTouched = !leftSideTouched && !rightSideTouched;

            if (leftSideTouched && topHalfTouched) {
              _setAnimationToPlay(AnimationToPlay.CameraTapped);
            } else if (middleTouched && topHalfTouched) {
              _setAnimationToPlay(AnimationToPlay.PulseTapped);
            } else if (rightSideTouched && topHalfTouched) {
              _setAnimationToPlay(AnimationToPlay.ImageTapped);
            } else {
              if (isOpen) {
                _setAnimationToPlay(AnimationToPlay.Deactivate);
              } else {
                _setAnimationToPlay(AnimationToPlay.Activate);
              }
              isOpen = !isOpen;
            }
          },
          child: FlareActor(
            'assets/animations/MultiOptionButton.flr',
            animation: _getAnimationName(_animationToPlay),
            controller: animationControls,
          ),
        ));
  }
}
