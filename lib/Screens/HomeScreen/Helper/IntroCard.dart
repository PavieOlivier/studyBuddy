import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

///This is the card that is positionned on top of the screen
///bellow the custom app bar
class IntroCard extends StatelessWidget {
  const IntroCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.orange[300],
      width: SizeConfig.horizontalBloc * 99,
      height: SizeConfig.safeBlockVertical * 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          WidgetAnimator(
            child: AvatarGlow(
              glowColor: Colors.orange[300],
              endRadius: 65.0, //required
              child: Material(
                //required
                color: Colors.white,
                elevation: 0.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('images/k.jpg'),
                  radius: SizeConfig.safeBlockHorizontal * 10,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WidgetAnimator(
                duration: Duration(milliseconds: 330),
                child: Text(
                  'Welcome back',
                  style: TextStyle(
                      color: Colors.orange[400],
                      fontSize: SizeConfig.safeBlockHorizontal * 8,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 0.2,
              ),
              WidgetAnimator(
                duration: Duration(milliseconds: 330),
                animateFromTop: false,
                child: Text(
                  'Dear Student',
                  style: TextStyle(
                      color: Colors.orange[400],
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.safeBlockHorizontal * 7),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
