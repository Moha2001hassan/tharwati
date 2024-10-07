import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../data/datasources/services/global_timer_service.dart';
import '../../../data/datasources/user_firebase.dart';
import '../../../data/hive/hive_user_service.dart';
import '../../../data/models/user.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'home_rounded_container.dart';

class GlobalTimer extends StatefulWidget {
  const GlobalTimer({super.key});

  @override
  State<GlobalTimer> createState() => _GlobalTimerState();
}

class _GlobalTimerState extends State<GlobalTimer> {
  final GlobalTimerService _timerService = GlobalTimerService();

  double _elapsedPercentage = 0.0;
  Timer? _internalTimer;
  int _remainingTime = GlobalTimerService.totalDurationInSeconds;
  bool _isTimerRunning = false;

  double? _dailyIncome;
  int? _diamondsNumber;
  double? _dollarsNumber;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _loadTimer();
  }

  @override
  void dispose() {
    _internalTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    final String? uid = await getUserId();
    final MyUser? user = await getUserData(uid!);
    setState(() {
      _dailyIncome = user?.dailyIncome ?? 0.0001;

      _diamondsNumber = user?.diamondsNumber ?? 0;
      _dollarsNumber = user?.dollarsNumber ?? 0.0;
    });
  }

  Future<void> _loadTimer() async {
    try {
      final DateTime networkTime = await NTP.now();
      final int currentTime = networkTime.millisecondsSinceEpoch;

      final int? startTime = await _timerService.loadStartTime();
      final int duration = await _timerService.loadDuration();
      final String? timerStatus = await _timerService.loadTimerStatus();

      if (startTime != null) {
        final elapsedTime = ((currentTime - startTime) / 1000).ceil();
        _remainingTime = duration - elapsedTime;

        if (_remainingTime > 0) {
          _elapsedPercentage =
              elapsedTime / GlobalTimerService.totalDurationInSeconds;
          _startInternalTimer();
        } else {
          _remainingTime = 0;
          _elapsedPercentage = 1.0;

          if (timerStatus == "on") {
            //await _handleTimerCompletion();
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading timer: $e');
    } finally {
      setState(() {});
    }
  }

  void _startInternalTimer() async {
    _isTimerRunning = true;
    await _timerService.saveTimerStatus("on");

    _internalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          _elapsedPercentage = 1.0 -
              (_remainingTime / GlobalTimerService.totalDurationInSeconds);
        } else {
          timer.cancel();
          _isTimerRunning = false;
          _elapsedPercentage = 0.0;
          //_handleTimerCompletion();
        }
      });
    });
  }

  Future<void> _handleTimerCompletion() async {
    int newDiamondsNumber = _diamondsNumber ?? 0;
    double newDollarsNumber =
        (_dailyIncome ?? 0.0001) + (_dollarsNumber ?? 0.0);

    await updateUserDiamondsDollars(newDiamondsNumber, newDollarsNumber);

    MyUser? updatedUser = await _timerService.refetchAndStoreUserData();
    if (updatedUser != null) {
      setState(() {
        _diamondsNumber = updatedUser.diamondsNumber;
        _dollarsNumber = updatedUser.dollarsNumber;
      });
    }
    await _timerService.saveTimerStatus("off");
  }

  Future<void> _startTimer() async {
    _handleTimerCompletion();
    try {
      final DateTime networkTime = await NTP.now();
      final int startTime = networkTime.millisecondsSinceEpoch;

      await _timerService.saveStartTime(startTime);

      _remainingTime = GlobalTimerService.totalDurationInSeconds;
      _elapsedPercentage = 0.0;
      _startInternalTimer();
    } catch (e) {
      debugPrint('Error starting timer: $e');
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    const size = 280.0;
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                    startAngle: 0.0,
                    endAngle: twoPI,
                    stops: [_elapsedPercentage, _elapsedPercentage],
                    center: Alignment.center,
                    colors: [Colors.blue, Colors.grey.withAlpha(55)],
                  ).createShader(rect);
                },
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Image.asset(MyImages.radialScale).image,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: size - 45,
                  height: size - 45,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                    child: Stack(
                      children: [
                        Image.asset(MyImages.iraqFlag),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _dailyIncome != null
                                    ? _dailyIncome!.toStringAsFixed(5)
                                    : '0.0001',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Image(
                                height: 35,
                                image: AssetImage(MyImages.dollarAnimation),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 25),
        HomeRoundedContainer(
          text: MyHelperFunctions().formatDuration(_remainingTime),
          icon: _isTimerRunning ? Icons.pause_circle : Icons.play_circle,
          onIconPressed: _isTimerRunning ? null : _startTimer,
        ),
      ],
    );
  }
}
