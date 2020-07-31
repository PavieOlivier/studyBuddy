import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:page_transition/page_transition.dart';

import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/Logic/Logic.dart' as logic;
import 'package:study_buddy/Screens/ReminderScreen/ReminderScreen.dart';

import 'package:study_buddy/Screens/StudyScreen/StudyingScreen.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

import 'Helper/CustomAppBar.dart';
import 'Helper/FilteredContentCard.dart';
import 'Helper/IntroCard.dart';
import 'Helper/OptionList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double opacityValue = 1;
  bool isInitialBoot = true;
  bool isMessageFiltered;
  @override
  void initState() {
    super.initState();
    isMessageFiltered = false;
    persistAppBar();
  }

  void persistAppBar() {
    Future.delayed(Duration(milliseconds: 330), () {
      isInitialBoot = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Remove this after putting the main screen to
    SizeConfig.init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            isInitialBoot ? CustomAppBar() : SizedBox(),
            Container(
              //color: Colors.black,
              height: SizeConfig.screenHeight,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: SizeConfig.safeBlockVertical * 15,
                      ),
                      IntroCard(),
                      ContentHeader(title: 'Study session',),

                      ///TODO you need to come back to this
                      ///to maybe add timeline studies
                      OptionList(
                        onStartStudy: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 350),
                                type: PageTransitionType.fade,
                                child: StudyingScreen()),
                          );
                          Future.delayed(Duration(milliseconds: 500), () {
                            checkMessageFilter();
                          });
                        },
                        onFiltering: () {
                          EdgeAlert.show(context,
                              title: 'Cannot open',
                              description:
                                  'The filtering page is not availiable yet',
                              gravity: EdgeAlert.BOTTOM,
                              backgroundColor: Colors.orange[300]);
                        },
                        onReminder: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 350),
                                type: PageTransitionType.fade,
                                child: ReminderScreen()),
                          );

                          print('navigation bar now');
                        },
                      ),
                      ContentHeader(title: 'Filtered Content',),
                      isMessageFiltered
                          ? SizedBox()
                          : Container(
                              //  color: Colors.red,
                              child: WidgetAnimator(
                                animateFromTop: false,
                                child: Center(
                                  child: Text(
                                    'No messages filtered yet\nplease start a study session',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                      //we are printing the list in reverse
                      for (int i = logic.filteredMessage.length - 1;
                          i > -1;
                          i--)
                        (WidgetAnimator(
                            child: FilteredContentCard(
                          senderName: logic.filteredName[i],
                          senderMessage: logic.filteredMessage[i],
                          time: logic.messageTime[i],
                        ))),
                    ],
                  ),
                ),
              ),
            ),
            isInitialBoot ? SizedBox() : CustomAppBarPersisted(),
          ],
        ),
      ),
    );
  }

  ///Use this to check if the message list is filtered or not
  void checkMessageFilter() {
    if (logic.filteredMessage.isEmpty == true) {
      if (mounted)
        setState(() {
          isMessageFiltered = false;
        });
    } else {
      if (mounted)
        setState(() {
          isMessageFiltered = true;
        });
    }
  }
}

class ContentHeader extends StatelessWidget {
  final String title;
  const ContentHeader({
    Key key, @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: WidgetAnimator(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Container(
            //color: Colors.pink,
            width: SizeConfig.safeBlockHorizontal * 93,
            height: SizeConfig.safeBlockVertical * 4.5,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.orange[300],
                  fontSize: SizeConfig.safeBlockHorizontal * 7,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
