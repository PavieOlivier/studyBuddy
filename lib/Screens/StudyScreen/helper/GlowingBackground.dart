import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class GlowingBackground extends StatelessWidget {
  final Color glowColor;
  const GlowingBackground({
    Key key, @required this.glowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
                child: AvatarGlow(
        glowColor:glowColor,
        showTwoGlows: true,
        endRadius: SizeConfig.safeBlockHorizontal*51,
        child: SizedBox(),
      ),
    );
  }
}