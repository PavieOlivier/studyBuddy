import 'package:flutter/material.dart';
import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class ReminderScreenHeader extends StatelessWidget {
  const ReminderScreenHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              //color: Colors.red,
              width: SizeConfig.safeBlockHorizontal * 20,
             // height: SizeConfig.safeBlockVertical * 12,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Hero(
                    tag: 'reminderSc',
                    child: Image.asset('images/icons/bell.png')),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: WidgetAnimator(
              animateFromTop: true,
              child: Container(
                //color: Colors.green,
                width: SizeConfig.safeBlockHorizontal * 70,
              //  height: SizeConfig.safeBlockVertical * 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      //height: SizeConfig.safeBlockVertical*6,
                      //color: Colors.yellow,
                      child: Text(
                        'Reminders',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 8,
                          decoration: TextDecoration.none,
                          color: Color(0xffF7D360),
                          fontWeight: FontWeight.w600
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      //height: SizeConfig.safeBlockVertical*6,
                      //color: Colors.pink,
                      child: Text(
                        'Set all your reminders here or take a look at current ones',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                          decoration: TextDecoration.none,
                          color: Color(0xffF7D360),
                          fontWeight: FontWeight.w600
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
