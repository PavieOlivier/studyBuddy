import 'package:flutter/material.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class StudyScreenBackground extends StatelessWidget {
  final Color backgroundColor;
  final Color secondBackground;
  const StudyScreenBackground({
    Key key,
    @required this.backgroundColor, @required this.secondBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.horizontalBloc * 100,
      height: SizeConfig.verticalBloc * 100,
      color: Colors.orange,
      child: WaveWidget(
        config: CustomConfig(
          durations: [35000, 19440, 10800, 6000],
          heightPercentages: [0.10, 0.13, 0.15, 0.10],
          blur: MaskFilter.blur(BlurStyle.solid, 10),
          colors: [
            secondBackground,
            Colors.white60,
            Colors.white54,
            Colors.white24,
          ],
        ),
        waveFrequency: 1.7,
        waveAmplitude: 20,
        wavePhase: 3,
        backgroundColor: backgroundColor,
        size: Size(
          double.infinity,
          double.infinity,
        ),
      ),
    );
  }
}
