import 'dart:math';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:multiple_select/multiple_select.dart';
import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/Logic/reminderLogic.dart';
import 'package:study_buddy/Screens/HomeScreen/Helper/CustomAppBar.dart';
import 'package:study_buddy/Screens/ReminderScreen/helper/ReminderScreenHeader.dart';
import 'package:study_buddy/Screens/ReminderScreen/helper/ReminderScreenNavigationBarAndBody.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';
import 'package:study_buddy/unreleasedPackage/mabiala_fab.dart';

import 'helper/ActiveReminderCard.dart';
import 'helper/NavigationBarItem.dart';
import 'helper/ReminderEmptyPlaceHolder.dart';
import 'helper/SetupAReminder.dart';
import 'package:study_buddy/Logic/Logic.dart' as logic;

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  AdvFabController controller;
  ScrollPhysics pageScrollPhysics;
  double opacityValue;
  bool isActiveReminderEmpty;
  bool isMissedReminderEmpty;
  bool showFAB;
  bool useShadowOnFAb;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('trying to change the color');

    opacityValue = 1;
    controller = AdvFabController();
    pageScrollPhysics = BouncingScrollPhysics();
    useShadowOnFAb = false;
    isActiveReminderEmpty = Hive.box('reminderBox').isEmpty ? true : false;
    isMissedReminderEmpty = true;
    showFAB = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
      statusBarColor: Color(0xffF7D360),
  ),
          child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        floatingActionButton: showFAB
            ? WidgetAnimator(
                animateFromTop: false,
                duration: Duration(milliseconds: 600),
                child: AdvFab(
                  animationDuration: Duration(milliseconds: 350),
                  useElevation: useShadowOnFAb,
                  showLogs: false,
                  floatingActionButtonExpendedWidth: 93,
                  controller: controller,
                  onFloatingActionButtonTapped: () {
                    controller.setExpandedWidgetConfiguration(
                        withChild: SetupAReminder(
                          onClose: () {
                            controller.collapseFAB();
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                useShadowOnFAb = false;
                                pageScrollPhysics =
                                    BouncingScrollPhysics();
                                opacityValue = 1;
                              });
                            });
                          },
                          onConfirm: (
                            isRepeated,
                            notificationTitle,
                            atTime,
                          ) {
                            if(notificationTitle.isEmpty || notificationTitle.length <4)
                            {
                              EdgeAlert.show(context , title: 'Error', description: (notificationTitle.isEmpty)?  'Title cannot be empty':'Title is too short',icon: Icons.warning , backgroundColor: Color(0xffF7D360));
                              return;
                            }
                            if(logic.selectedDays.isEmpty)
                            {
                              EdgeAlert.show(context , title: 'Error', description: 'select at least one day',icon: Icons.warning , backgroundColor: Color(0xffF7D360));
                              return;
                            }
                            if (isRepeated == true || isRepeated == false ) {
                              List<int> idsList = [];
                              logic.selectedDays.forEach((day) {
                                int id = 1 + Random().nextInt(200);
                                idsList.add(id);
                                logic.setRemainderRepeat(
                                    day: day,
                                    atTime: atTime,
                                    description: notificationTitle,
                                    id: id);
                              });
                              List<String> tempsDays = logic.selectedDays;
                              logic.addReminderToDataBase(
                                  atTime: atTime,
                                  reminderIds: idsList,
                                  frequency: isRepeated? 'Repeat':'Once',
                                  days: tempsDays,
                                  title: notificationTitle);
                            } else {

                              ///TODO: here I don want to integrate it..
                              ///mostly the reminder will not be repeated anymore
                            }
                            logic.selectedDays.clear();
                            setState(() {
                              isActiveReminderEmpty = false;
                            });
                            controller.collapseFAB();
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                useShadowOnFAb = false;
                                pageScrollPhysics =
                                    BouncingScrollPhysics();
                                opacityValue = 1;
                              });
                            });
                          },
                        ),
                        heightToExpandTo: 70,
                        expendedBackgroundColor: Colors.white);

                    if (controller.isCollapsed == true) {
                      controller.expandFAB();
                      setState(() {
                        useShadowOnFAb = true;
                        pageScrollPhysics = NeverScrollableScrollPhysics();
                        opacityValue = 0;
                      });
                    } else {
                      controller.collapseFAB();
                      print(
                          'There must be an error, this portion of the code shall be dead');
                    }
                  },
                  collapsedColor: Color(0xffF7D360),
                  floatingActionButtonIcon: Icons.add,
                  floatingActionButtonIconColor: Colors.white,
                ),
              )
            : null,
        body: WillPopScope(
          onWillPop: () async{
           if(controller.isCollapsed == true)
           {
             return true;
           }
           else
           {
             controller.collapseFAB();
             Future.delayed(Duration(milliseconds: 500),(){
               setState(() {
                 opacityValue = 1;
                 pageScrollPhysics = BouncingScrollPhysics();
               });
               return true;
             });
           }
           
          },
                  child: Container(
            color: Colors.white,
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: SafeArea(
              top: true,
              bottom: false,
              left: false,
              right: false,
              child: Column(
                children: <Widget>[ 
                  Expanded(flex:1, child: ReminderScreenHeader()),
                  Expanded(
                    flex: 10,
                    child: WidgetAnimator(
                      duration: Duration(milliseconds: 550),
                      child: ReminderScreenNavigationBarAndBody(
                        pageScrollPhysics: pageScrollPhysics,
                        onPageUpdated: (index) {
                          if (index == 0) {
                            // we are on the active side
                            setState(() {
                              showFAB = true;
                            });
                          } else {
                            //we are on the inactive side
                            setState(() {
                              showFAB = false;
                            });
                          }
                        },
                        activeReminderPage: isActiveReminderEmpty
                            ? AnimatedOpacity(
                                opacity: opacityValue,
                                duration: Duration(milliseconds: 250),
                                child: ReminderEmptyPlaceHolder(
                                  text:
                                      'Oops!\nIt seams like Tomy can’t find a reminder\nPress the + icon to add one',
                                ),
                              )
                            : AnimatedOpacity(
                                opacity: opacityValue,
                                duration: Duration(milliseconds: 250),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: Hive.box('reminderBox').length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, int index) {
                                    final ReminderLogic xReminder =
                                        Hive.box('reminderBox').getAt(index)
                                            as ReminderLogic;
                                    Hive.box('reminderBox').watch().listen((event) {
                                      if (mounted) setState(() {});
                                    });
                                    return ActiveReminderCard(
                                      reminder: xReminder,
                                      onLongPress: () async {
                                        
                                        await Hive.box('reminderBox').deleteAt(index);

                                        xReminder.reminderIds.forEach((reminderId) async {
                                          await AndroidFlutterLocalNotificationsPlugin().cancel(reminderId);
                                         });
                                        if (Hive.box('reminderBox').isEmpty) {
                                          setState(() {
                                            isActiveReminderEmpty = true;
                                          });
                                        } else {
                                          setState(() {
                                            isActiveReminderEmpty = false;
                                          });
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                        missedReminderPage: isMissedReminderEmpty
                            ? ReminderEmptyPlaceHolder(
                                text:
                                    'Good!\nIt seams like Tomy can’t find a missed reminder\nKeep up the good work!',
                              )
                            : SizedBox(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
