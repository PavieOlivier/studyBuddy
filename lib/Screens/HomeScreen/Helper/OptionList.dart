import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'StudySessionListItem.dart';

///This widget contains the main menu of the application
///it shall be located below the introduction card widget
class OptionList extends StatefulWidget {
  const OptionList({
    Key key,
    @required this.onStartStudy,
    @required this.onReminder,
    @required this.onFiltering,
  }) : super(key: key);
  final Function onStartStudy;
  final Function onReminder;
  final Function onFiltering;
  @override
  _OptionListState createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  ScrollController scrollController;
  double scale = 0, finalDivider = 0;
  int tempDivider;

  @override
  void initState() {
    //
    super.initState();
    scrollController = ScrollController();
    tempDivider = (SizeConfig.safeBlockHorizontal * 8.8).toInt();
    print('The division is complete result is ' + tempDivider.toString());
    finalDivider = tempDivider.toDouble();
    scrollController.addListener(scroolControllerListener);
  }

  void scroolControllerListener() {
    scale = (scrollController.offset / finalDivider).abs();
    // print('The scale is' + scale.toString());
    setState(() {
      print('set state called');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
    width: SizeConfig.horizontalBloc * 95,
    height: SizeConfig.safeBlockVertical * 33,
    //color: Colors.red,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 7,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: WidgetAnimator(
                              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'bkg',
                    child: StudySessionListItem(
                      //backgroundColor: Color(0xffEEF3FA),
                      frameToAnimateTo: 219,
                      frameTIme: 2000,
                      useGif: false,
                      pathToImage: 'images/icons/study.png',
                      onTap: widget.onStartStudy,
                      title: 'Start Session',
                      height: SizeConfig.safeBlockVertical * (25.5 - scale),
                    ),
                  ),
                  Hero(
                    tag: 'reminderSc',
                                          child: StudySessionListItem(
                      useGif: false,
                      frameTIme: 2000,
                      // backgroundColor: Color(0xffEEF3FA),
                      frameToAnimateTo: 219,
                      pathToImage: 'images/icons/bell.png',
                      onTap: widget.onReminder,
                      title: 'Reminder',
                      height: SizeConfig.safeBlockVertical * 23,
                    ),
                  ),
                  Hero(
                    tag: 'filterSC',
                                          child: StudySessionListItem(
                      //  backgroundColor: Color(0xffFEFEFE),
                      frameToAnimateTo: 182,
                      frameTIme: 2000,
                      useGif: false,
                      pathToImage: 'images/icons/reminder.png',
                      onTap: widget.onFiltering,
                      title: 'Filtering Settings',
                      height: SizeConfig.safeBlockVertical * 23,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
        ),
      );
  }
}
