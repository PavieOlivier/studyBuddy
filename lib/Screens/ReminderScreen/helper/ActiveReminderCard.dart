import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/Logic/reminderLogic.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class ActiveReminderCard extends StatefulWidget {
  final ReminderLogic reminder;
  final Function onLongPress;
  const ActiveReminderCard({
    Key key, @required this.reminder, @required this.onLongPress
  }) : super(key: key);

  @override
  _ActiveReminderCardState createState() => _ActiveReminderCardState();
}

class _ActiveReminderCardState extends State<ActiveReminderCard> {
  WidgetAnimatorController widgetAnimatorController;
  @override
  void initState() {
    
    super.initState();
    widgetAnimatorController = WidgetAnimatorController();
  }

  
  @override
  Widget build(BuildContext context) {
   
    return WidgetAnimator(
      animateFromTop: false,
      controller: widgetAnimatorController,
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onLongPress: widget.onLongPress,
                    child: Container(
        width: SizeConfig.safeBlockHorizontal * 80,
        height: SizeConfig.safeBlockVertical * 17,
        //color: Colors.pink,
        decoration: BoxDecoration(boxShadow: [
            BoxShadow(
      offset: Offset(1, 1.7),
      color: Colors.orange[100],
      blurRadius: 3,
      spreadRadius: 2.4)
        ], borderRadius: BorderRadius.circular(25)),
        child: Stack(
            children: <Widget>[
            Container(
      decoration: BoxDecoration(
        color: Color(0xffF7D360),
        borderRadius: BorderRadius.circular(20),
      ),
            ),
            Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
              left: SizeConfig.safeBlockVertical * 12,
              top: SizeConfig.safeBlockVertical * 1,
              bottom: SizeConfig.safeBlockVertical * 3.5),
        child: Transform.rotate(
            angle: 6.5,
            child: Transform.scale(
              scale: 0.85,
              child: Opacity(
                opacity: 0.4,
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 40,
                  decoration: BoxDecoration(
                      //color: Colors.yellow,
                      image: DecorationImage(
                          image: AssetImage('images/icons/rmdr.png'),
                          fit: BoxFit.contain)),
                ),
              ),
            ),
        ),
      ),
            ),
            Container(
      width: SizeConfig.safeBlockHorizontal * 80,
      height: SizeConfig.safeBlockVertical * 17,
      child: Padding(
        padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 4,
              top: SizeConfig.safeBlockVertical * 2),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  '${widget.reminder.title}, At',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  '${widget.reminder.time}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 11,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'At frequency: ${widget.reminder.frequency}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Mon',
                        style: TextStyle(
                            color: widget.reminder.daysToRemind.contains('Monday')?Colors.white:Colors.grey[50].withOpacity(0.5),
                            fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Tues',
                        style: TextStyle(
                            color: widget.reminder.daysToRemind.contains('Tuesday')?Colors.white:Colors.grey[50].withOpacity(0.5),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Wed',
                        style: TextStyle(
                            color: widget.reminder.daysToRemind.contains('Wednesday')?Colors.white:Colors.grey[50].withOpacity(0.43),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Thur',
                        style: TextStyle(
                            color: widget.reminder.daysToRemind.contains('Thursday')?Colors.white:Colors.grey[50].withOpacity(0.43),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Fri',
                        style: TextStyle(
                            color:widget.reminder.daysToRemind.contains('Friday')?Colors.white:Colors.grey[50].withOpacity(0.43),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Sat',
                        style: TextStyle(
                            color: widget.reminder.daysToRemind.contains('Saturday')?Colors.white:Colors.grey[50].withOpacity(0.43),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Sun',
                        style: TextStyle(
                            color: widget.reminder.daysToRemind.contains('Sunday')?Colors.white:Colors.grey[50].withOpacity(0.43),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
        ),
      ),
            ),
            Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right:SizeConfig.safeBlockHorizontal*4, ),
        child: GestureDetector(
            onTap: (){
              //TODO: Perform some Action When on Study now is pressed 
            },
            
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
                                child: Container(
                width: SizeConfig.safeBlockHorizontal*25,
                height: SizeConfig.safeBlockVertical*3.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Text('Study Now',style: TextStyle(
                    color: Color(0xffF7D360),
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.safeBlockHorizontal*4

                  ),)
                ),
              ),
            ),
        ),
      ),
            )
            ],
        ),
      ),
          ),
        ),
    );
  }
}
