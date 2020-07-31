import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      duration: Duration(milliseconds: 250),
      child: ClipPath(
        clipper: WaveClipperTwo(),
        child: Container(
          color: Colors.orange[300],
          width: SizeConfig.screenWidth,
         height: SizeConfig.safeBlockVertical * 17.3,
          child: SafeArea(
            top: true,
            bottom: false,
            left: false,
            right: false,
            child: Padding(
              padding:  EdgeInsets.only(bottom: 0),
              child: WidgetAnimator(
            duration: Duration(milliseconds: 300),
            child: Align(
              alignment: Alignment.topCenter,
                          child: Padding(
                            padding:  EdgeInsets.only(top: SizeConfig.safeBlockVertical*2.2),
                            child: Text(
                'Study Buddy',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.safeBlockHorizontal * 6),
              ),
                          ),
            ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class CustomAppBarPersisted extends StatelessWidget {
  const CustomAppBarPersisted({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: Colors.orange[300],
        width: SizeConfig.screenWidth,
        height: SizeConfig.safeBlockVertical * 17.3,
        child: SafeArea(
          top: true,
          bottom: false,
          left: false,
          right: false,
          child: Padding(
            padding:  EdgeInsets.only(bottom: 0),
            child: Align(
              alignment: Alignment.topCenter,
                          child: Padding(
                            padding:  EdgeInsets.only(top: SizeConfig.safeBlockVertical*2.2),
                            child: Text(
                'Study Buddy',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.safeBlockHorizontal * 6),
              ),
                          ),
            ),
          ),
        ),
      ),
    );
  }
}

