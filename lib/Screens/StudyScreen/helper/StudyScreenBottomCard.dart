import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

import 'BottomIcons.dart';

class StudyScreenBottomCard extends StatefulWidget {
  final Function onPauseTapped;
  final Function onStopTapped;
  final String pauseTitle;
  final IconData pauseIcon;
  final Color butonIconAndTextColor;
  final Color circularShapeShadowColor;
  final WidgetAnimatorController widgetAnimatorController;
  const StudyScreenBottomCard({
    Key key,
    @required this.onPauseTapped,
    @required this.onStopTapped,
    @required this.pauseTitle,
    @required this.pauseIcon,
    @required this.butonIconAndTextColor,
    @required this.circularShapeShadowColor,
    @required this.widgetAnimatorController,
  }) : super(key: key);

  @override
  _StudyScreenBottomCardState createState() => _StudyScreenBottomCardState();
}

class _StudyScreenBottomCardState extends State<StudyScreenBottomCard> {
  int duration = 600;
  @override
  void initState() {
    super.initState();
    changeDuration();
    motivationList.shuffle();
  }

  void changeDuration() {
    Future.delayed(Duration(milliseconds: 1200), () {
      setState(() {
        duration = 300;
        print('Duration changed to 300');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: SizeConfig.safeBlockVertical * 4,
      child: Container(
        height: SizeConfig.safeBlockVertical * 30,
        //color: Colors.pink,
        child: WidgetAnimator(
          duration: Duration(milliseconds: duration),
          controller: widget.widgetAnimatorController,
          animateFromTop: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: SizeConfig.horizontalBloc * 90,
                height: SizeConfig.safeBlockVertical * 15,
                //color: Colors.white,
                child: Center(
                    child: FadeAnimatedTextKit(
                      totalRepeatCount: 100,
                  duration: Duration(seconds: 8),
                  text: motivationList,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45),
                )),
              ),
              Container(
                width: SizeConfig.horizontalBloc * 70,
                height: SizeConfig.safeBlockVertical * 8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                          color: widget.circularShapeShadowColor,
                          offset: Offset(0, 2.2),
                          blurRadius: 3,
                          spreadRadius: 1.5)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    BottomIcons(
                      color: widget.butonIconAndTextColor,
                      onTap: widget.onPauseTapped,
                      title: widget.pauseTitle,
                      icon: widget.pauseIcon,
                    ),
                    BottomIcons(
                      color: widget.butonIconAndTextColor,
                      onTap: widget.onStopTapped,
                      title: 'Finish',
                      icon: Icons.stop,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<String> motivationList = [
  'Failure will never overtake me if my determination to succeed is strong enough',
  'Push yourself, because no one else is going to do it for you',
  'Great things never come from comfort zones',
  'The harder you work for something, the greater you’ll feel when you achieve it',
  'Don’t stop when you’re tired. Stop when you’re done',
  'It’s going to be hard, but hard does not mean impossible',
  'The key to success is to focus on goals, not obstacles',
  'When we strive to become better than we are, everything around us becomes better too',
  'Do the hard jobs first. The easy jobs will take care of themselves',
];
