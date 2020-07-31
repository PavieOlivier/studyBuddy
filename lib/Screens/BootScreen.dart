import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:study_buddy/Screens/HomeScreen/HomeScreen.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';
import 'package:page_transition/page_transition.dart';

class BootScreen extends StatefulWidget {
  @override
  _BootScreenState createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen>
    with SingleTickerProviderStateMixin {
  GifController gifController;

  @override
  void initState() {
    super.initState();
    gifController = GifController(vsync: this);
    gifController.value = 55;
  }

  @override
  Widget build(BuildContext context) {
    
    SizeConfig.init(context);
    return Scaffold(
        backgroundColor: Color(0xffFEFEFD),
        body: Center(
          child: Container(
            width: SizeConfig.horizontalBloc * 100,
            height: SizeConfig.verticalBloc * 60,
            //color: Colors.amber,
            child: GifImage(
              controller: gifController,
              image: AssetImage('images/bootimage/boot.gif'),
              fit: BoxFit.contain,
              onFetchCompleted: () {
                Future.delayed(Duration(milliseconds: 400), () {
                  gifController
                      .animateTo(89, duration: Duration(milliseconds: 1400))
                      .then((onValue) {
                    gifController.value = 0;
                    gifController
                        .animateTo(54, duration: Duration(milliseconds: 1400))
                        .then((onFinal) {
                         Future.delayed(Duration(milliseconds: 400), (){
                            Navigator.pushAndRemoveUntil(context, PageTransition(
                            type: PageTransitionType.fade,
                            child: HomeScreen()
                          ), (Route<dynamic>route) => false);
                         });
                        });
                  });
                });
              },
            ),
          ),
        ));
  }
}
