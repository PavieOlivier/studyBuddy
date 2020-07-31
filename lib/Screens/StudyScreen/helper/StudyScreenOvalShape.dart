import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter_timer/flutter_timer.dart';
import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class TimeController {
  Function pause;
  Function resume;
  Function startTiming;
}

class StudyScreenOvalShape extends StatefulWidget {
  const StudyScreenOvalShape({
    Key key,
    @required this.gifController,
    @required this.timeController,
    @required this.gradiantColor,
    @required this.timerTextColor,
    @required this.widgetAnimatorController,
  }) : super(key: key);

  ///The controller of the gif image
  final GifController gifController;
  final TimeController timeController;
  final List<Color> gradiantColor;
  final Color timerTextColor;
  final WidgetAnimatorController widgetAnimatorController;

  @override
  _StudyScreenOvalShapeState createState() => _StudyScreenOvalShapeState();
}

class _StudyScreenOvalShapeState extends State<StudyScreenOvalShape> {
  bool isInitialStartTime = true;
  bool isTimerRunning = false;
  DateTime timeAtPause;
  DateTime initialTime ;
  DateTime temporaryTime;

  void pauseTimer() {
    temporaryTime = timeAtPause;
    if (mounted) {
      isTimerRunning = false;
    }
  }

  void startTimer() {
    if (mounted) {
      setState(() {
        initialTime = DateTime.now();
        isTimerRunning = true;
      });
    }
  }

  void resumeTimer() {
    initialTime = temporaryTime;
    if (mounted) {
      setState(() {
        isTimerRunning = true;
      });
    }
    Future.delayed(Duration(milliseconds: 600),(){
      if (mounted) {
        temporaryTime = timeAtPause;
        initialTime = temporaryTime;
      setState(() {
        isTimerRunning = false;
      });
    }
    });
    Future.delayed(Duration(milliseconds: 700),(){
      //initialTime = temporaryTime;
      if (mounted) {
      setState(() {
        isTimerRunning = true;
      });
    }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.timeController != null) {
      widget.timeController.pause = pauseTimer;
      widget.timeController.resume = resumeTimer;
      widget.timeController.startTiming = startTimer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: WidgetAnimator(
         duration: Duration(milliseconds:600),
        controller: widget.widgetAnimatorController,
        child: Container(
          width: SizeConfig.horizontalBloc * 70,
          height: SizeConfig.safeBlockVertical * 35,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: widget.gradiantColor),
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: SizeConfig.horizontalBloc * 70,
                  height: SizeConfig.safeBlockVertical * 27,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: widget.timerTextColor,
                            blurRadius: 2,
                            offset: Offset(0, 2.3))
                      ]),
                  child: SizedBox(),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TikTikTimer(
                    initialDate: initialTime,
                    running: isTimerRunning,
                    height: SizeConfig.safeBlockVertical * 12,
                    width: SizeConfig.safeBlockHorizontal * 40,
                    backgroundColor: Colors.white,
                    timerTextStyle: TextStyle(
                        color: widget.timerTextColor,
                        fontSize: SizeConfig.safeBlockHorizontal * 8),
                    borderRadius: 100,
                    isRaised: false,
                    tracetime: (time) {
                      timeAtPause = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          time.currentHour,
                          time.currentMinutes,
                          time.currentSeconds);
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Container(
                      width: SizeConfig.safeBlockHorizontal * 25,
                      height: SizeConfig.safeBlockVertical * 14,
                      //color: Colors.green,
                      child: GifImage(
                        controller: widget.gifController,
                        image: AssetImage('images/icons/study.gif'),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
