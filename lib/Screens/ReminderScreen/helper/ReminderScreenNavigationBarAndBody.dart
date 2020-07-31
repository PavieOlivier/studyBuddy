import 'package:flutter/material.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';
import 'package:study_buddy/unreleasedPackage/mabiala_fab.dart';

import 'NavigationBarItem.dart';

class ReminderScreenNavigationBarAndBody extends StatefulWidget {
  const ReminderScreenNavigationBarAndBody({
    Key key,
    @required this.activeReminderPage,
    @required this.missedReminderPage,
    @required this.onPageUpdated,
    @required this.pageScrollPhysics,
   
  }) : super(key: key);
  final Widget activeReminderPage;
  final Widget missedReminderPage;
  final Function (int) onPageUpdated;
  final ScrollPhysics pageScrollPhysics;

  @override
  _ReminderScreenNavigationBarAndBodyState createState() =>
      _ReminderScreenNavigationBarAndBodyState();
}

class _ReminderScreenNavigationBarAndBodyState
    extends State<ReminderScreenNavigationBarAndBody> {
  bool isActiveTab = true;
  PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //color: Colors.amber,
        height: SizeConfig.safeBlockVertical * 89,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //TODO: work on the page controller as well as the the action to be taken care of
                //when I will have to work on handling the gesture
                NavigationBarItem(
                  onTap: () {
                    // isActiveTab = true;
                    // pageController.animateToPage(0,
                    //     duration: Duration(milliseconds: 350),
                    //     curve: Curves.linear);
                    // setState(() {});
                  },
                  title: 'Active',
                  textColor:
                      isActiveTab ? Color(0xffF7D360) : Colors.grey[300],
                  textDecoration: isActiveTab
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
                NavigationBarItem(
                  onTap: () {
                    // isActiveTab = false;
                    // pageController.animateToPage(1,
                    //     duration: Duration(milliseconds: 350),
                    //     curve: Curves.linear);
                    // setState(() {});
                  },
                  title: 'Missed',
                  textColor:
                      isActiveTab ? Colors.grey[300] : Color(0xffF7D360),
                  textDecoration: isActiveTab
                      ? TextDecoration.none
                      : TextDecoration.underline,
                ),
              ],
            ),
            Container(
              color: Colors.white,
              height: SizeConfig.safeBlockVertical * 84,
              child: PageView(
                
                onPageChanged: (index) {
                  widget.onPageUpdated(index);
                  setState(() {
                    if (index == 0) {
                      isActiveTab = true;
                    } else {
                      isActiveTab = false;
                    }
                  });
                },
                controller: pageController,
                physics: widget.pageScrollPhysics,
                children: <Widget>[
                  widget.activeReminderPage,
                  widget.missedReminderPage,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
