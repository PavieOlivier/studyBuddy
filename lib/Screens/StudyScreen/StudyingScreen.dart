import 'dart:async';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/Fork/flutter_dnd.dart';
import 'package:study_buddy/Logic/Logic.dart' as logic;
import 'package:study_buddy/Logic/aiNotificationLogic.dart'
    as AiNotificationListenerServeice;
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

import 'helper/GlowingBackground.dart';
import 'helper/StudyScreenBackground.dart';
import 'helper/StudyScreenBottomCard.dart';
import 'helper/StudyScreenOvalShape.dart';

class StudyingScreen extends StatefulWidget {
  @override
  _StudyingScreenState createState() => _StudyingScreenState();
}

class _StudyingScreenState extends State<StudyingScreen>
    with TickerProviderStateMixin {
  int durationOfOpacity = 250;
  Color transitionColor = Colors.green[300];
  double opacityValue = 0;
  WidgetAnimatorController bottomWidgetAnimatorController,
      circularWidgetAnimatorController;
  bool isInitialTimer = true;
  TimeController timeController;
  AnimationController tweenColorAnimationController;
  Animation<Color> mainBackgroundColorAnimation, secondBackgroundColorAnimation;
  Animation<Color> gradiant1ColorAnimation,
      timerTextColorAnimation,
      gradiant2ColorAnimation;
  bool isStudying = false;
  GifController gifController;
  @override
  void initState() {
    super.initState();

    bottomWidgetAnimatorController = WidgetAnimatorController();
    circularWidgetAnimatorController = WidgetAnimatorController();
    timeController = TimeController();
    gifController = GifController(vsync: this);
    tweenColorAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    mainBackgroundColorAnimation =
        ColorTween(begin: Colors.green[300], end: Colors.orange[300])
            .animate(tweenColorAnimationController)
              ..addListener(() {
                if (mounted) {
                  setState(() {});
                }
              });
    secondBackgroundColorAnimation =
        ColorTween(begin: Colors.green[100], end: Colors.orange[100])
            .animate(tweenColorAnimationController);
    gradiant1ColorAnimation =
        ColorTween(begin: Colors.green[100], end: Colors.orange[100])
            .animate(tweenColorAnimationController);

    gradiant2ColorAnimation =
        ColorTween(begin: Colors.green[200], end: Colors.orange[200])
            .animate(tweenColorAnimationController);
    timerTextColorAnimation =
        ColorTween(begin: Colors.green, end: Colors.orangeAccent)
            .animate(tweenColorAnimationController);
    Future.delayed(Duration(milliseconds: 600), () {
      opacityValue = 1;
      setState(() {});
    });
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    print('Starting Listening services');
    AiNotificationListenerServeice.startListening();
  }

  @override
  void dispose() {
    super.dispose();
    tweenColorAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Romove this once the app is good and done
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        EdgeAlert.show(context,
            title: 'Action blocked',
            description: 'To return to the previous screen please press Finish',
            gravity: EdgeAlert.BOTTOM,
            backgroundColor: gradiant1ColorAnimation.value);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Hero(
              tag: 'bkg',
              child: Container(
                color: transitionColor,
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
              ),
            ),
            AnimatedOpacity(
              opacity: opacityValue,
              duration: Duration(milliseconds: durationOfOpacity),
              child: StudyScreenBackground(
                backgroundColor: mainBackgroundColorAnimation.value,
                secondBackground: secondBackgroundColorAnimation.value,
              ),
            ),
            isStudying
                ? GlowingBackground(
                    glowColor: mainBackgroundColorAnimation.value,
                  )
                : SizedBox(),
            StudyScreenOvalShape(
              widgetAnimatorController: circularWidgetAnimatorController,
              timeController: timeController,
              timerTextColor: timerTextColorAnimation.value,
              gradiantColor: [
                gradiant1ColorAnimation.value,
                gradiant2ColorAnimation.value
              ],
              gifController: gifController,
            ),
            StudyScreenBottomCard(
              widgetAnimatorController: bottomWidgetAnimatorController,
              pauseIcon: isStudying ? Icons.pause : Icons.play_arrow,
              pauseTitle: isStudying ? 'Pause' : 'Start',
              butonIconAndTextColor: gradiant2ColorAnimation.value,
              circularShapeShadowColor: gradiant1ColorAnimation.value,
              onStopTapped: () async {
                //TODO: Do some stufs before returning on the previous oage
                await tweenColorAnimationController.reverse();
                await gifController.animateTo(0,
                    duration: Duration(milliseconds: 1500));
                circularWidgetAnimatorController.reverseAnimation();
                bottomWidgetAnimatorController.reverseAnimation();
                //we don't listen to the notifications anymore
                AiNotificationListenerServeice.stopListening();
                setState(() {
                  transitionColor = Colors.white;
                  durationOfOpacity = 400;
                  opacityValue = 0;
                });
                if (await FlutterDnd.isNotificationPolicyAccessGranted) {
                  await FlutterDnd.setInterruptionFilter(
                      FlutterDnd.INTERRUPTION_FILTER_ALL);
                  // Turn on DND - All notifications are suppressed.
                } else {
                  FlutterDnd.gotoPolicySettings();
                }

                Future.delayed(Duration(milliseconds: 600), () {
                  Navigator.of(context).pop();
                });
              },
              onPauseTapped: () async {
                if (isStudying == true) {
                  await tweenColorAnimationController
                      .reverse()
                      .then((onValue) async {
                    print('about to pause');

                    gifController.animateTo(0,
                        duration: Duration(milliseconds: 1500));

                    print('Pausing');
                    setState(() {
                      isStudying = false;
                      AiNotificationListenerServeice.isStudying = false;
                      timeController.pause();
                    });
                    if (await FlutterDnd.isNotificationPolicyAccessGranted) {
                      await FlutterDnd.setInterruptionFilter(
                          FlutterDnd.INTERRUPTION_FILTER_ALL);
                      // Turn on DND - All notifications are suppressed.
                    } else {
                      FlutterDnd.gotoPolicySettings();
                    }
                  });
                } else {
                 
 
  
                  await tweenColorAnimationController.forward().then((onValue) {
                    print('about to start');
                    logic.clearAllList();
                    //;
                    gifController
                        .animateTo(11, duration: Duration(milliseconds: 1500))
                        .then((onValue) async {
                          EdgeAlert.show( context , title: 'About to Study ?',description: 'Please put you phone on ringing mode and place it face down, we will handle the rest :) ', duration: 6 , backgroundColor: Colors.orange[300] , icon: Icons.notifications );
                      //we supress all notifications from appearing
                      if (await FlutterDnd.isNotificationPolicyAccessGranted) {
                        await FlutterDnd.setInterruptionFilter(
                            FlutterDnd.INTERRUPTION_FILTER_NONE);
                        // Turn on DND - All notifications are suppressed.
                      } else {
                        FlutterDnd.gotoPolicySettings();
                      }
                      setState(() {
                        isStudying = true;
                        AiNotificationListenerServeice.isStudying = true;
                        if (isInitialTimer == true) {
                          isInitialTimer = false;
                          timeController.startTiming();
                        } else {
                          timeController.resume();
                        }
                        //TODO: add platform chanel here
                      });
                    });
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
