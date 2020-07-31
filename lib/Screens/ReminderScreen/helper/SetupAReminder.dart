import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:study_buddy/Screens/ReminderScreen/helper/DayOfTheWeekItem.dart';
import 'package:study_buddy/Screens/ReminderScreen/helper/FrequencyUnit.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';



class SetupAReminder extends StatefulWidget {
  final Function onClose;
  final Function(bool isRepeated, String notificationTitle, DateTime atTime)
      onConfirm;
  const SetupAReminder({
    @required this.onClose,
    @required this.onConfirm,
    Key key,
  }) : super(key: key);

  @override
  _SetupAReminderState createState() => _SetupAReminderState();
}

class _SetupAReminderState extends State<SetupAReminder> {
  bool isFrequencyRepeat;
  FocusNode topLayerFocussNode;
  DateTime requestedTime;
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    requestedTime = DateTime.now();
    isFrequencyRepeat = false;
    topLayerFocussNode = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (topLayerFocussNode.hasFocus == true) {
          print('why unfocuss');
          topLayerFocussNode.unfocus();
        }
      },
      child: Container(
        //color: Color(0xffF7D360),
        width: SizeConfig.screenWidth,
        height: SizeConfig.safeBlockVertical * 70,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: textEditingController,
                    focusNode: topLayerFocussNode,
                    style: TextStyle(
                      color: Color(0xffF7D360),
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF7D360)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF7D360)),
                        ),
                        alignLabelWithHint: true,
                        hintMaxLines: 1,
                        hintText: 'Enter the title here',
                        hintStyle: TextStyle(
                            color: Color(0xffF7D360).withOpacity(0.4),
                            fontSize: SizeConfig.safeBlockHorizontal * 5,
                            fontWeight: FontWeight.w600)),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    'When ?',
                    style: TextStyle(
                        color: Color(0xffF7D360),
                        fontSize: SizeConfig.safeBlockHorizontal * 6,
                        fontWeight: FontWeight.w500),
                  )),
              Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        DayOfTheWeekItem(
                          dayName: 'Monday',
                        ),
                        DayOfTheWeekItem(
                          dayName: 'Tuesday',
                        ),
                        DayOfTheWeekItem(
                          dayName: 'Wednesday',
                        ),
                        DayOfTheWeekItem(
                          dayName: 'Thursday',
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        DayOfTheWeekItem(
                          dayName: 'Friday',
                        ),
                        DayOfTheWeekItem(
                          dayName: 'Saturday',
                        ),
                        DayOfTheWeekItem(
                          dayName: 'Sunday',
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    'At ?',
                    style: TextStyle(
                        color: Color(0xffF7D360),
                        fontSize: SizeConfig.safeBlockHorizontal * 6,
                        fontWeight: FontWeight.w500),
                  )),
              Expanded(
                flex: 9,
                child: TimePickerSpinner(
                  is24HourMode: false,
                  normalTextStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.6,
                      color: Colors.black38),
                  highlightedTextStyle: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 9,
                    color: Colors.orange[300],
                  ),
                  spacing: SizeConfig.safeBlockHorizontal * 2,
                  itemHeight: SizeConfig.safeBlockVertical * 7,
                  itemWidth: SizeConfig.safeBlockHorizontal * 17,
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    
                    //TODO: add the time to the manager to create the reminder
                    requestedTime = time;
                  },
                  
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Frequency :',
                        style: TextStyle(
                            color: Color(0xffF7D360),
                            fontSize: SizeConfig.safeBlockHorizontal * 6,
                            fontWeight: FontWeight.w500),
                      ),
                      FrequencyUnit(
                        onTap: () {
                          setState(() {
                            isFrequencyRepeat = false;

                            ///TODO: add the proper frequency to the freqency unit
                          });
                        },
                        text: 'Once',
                        backGroundColor: isFrequencyRepeat
                            ? Colors.grey[100]
                            : Color(0xffF7D360),
                        textColor:
                            isFrequencyRepeat ? Colors.grey[500] : Colors.white,
                      ),
                      FrequencyUnit(
                        onTap: () {
                          setState(() {
                            isFrequencyRepeat = true;
                          });
                        },
                        text: 'Repeat',
                        backGroundColor: isFrequencyRepeat
                            ? Color(0xffF7D360)
                            : Colors.grey[100],
                        textColor:
                            isFrequencyRepeat ? Colors.white : Colors.grey[500],
                      ),
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Transform.rotate(
                          angle: 7.12,
                          child: IconButton(
                              color: Colors.red,
                              iconSize: SizeConfig.safeBlockHorizontal * 10,
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                ///TODO: Cancel everything then close the button
                                widget.onClose();
                              })),
                      IconButton(
                          iconSize: SizeConfig.safeBlockHorizontal * 10,
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.greenAccent[400],
                          ),
                          onPressed: () {
                            //TODO: finalise all the confuguration then close the button
                            widget.onConfirm(
                              isFrequencyRepeat,
                              textEditingController.text,
                              requestedTime,
                              
                            );
                            print('reminder');
                            
                          }),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }



}

