import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _ScreenState();
}

class _ScreenState extends State<Splash> {
  bool image1 = false;
  double scaleOfImage1 = 0.2;
  bool image1Shift = false;
  bool title = false;
  double titleOfScale = 0.1;
  bool image2 = false;
  bool load = false;
  int dot = 1;

  @override
  void initState() {
    super.initState();
    startInitial();
  }

  void startInitial() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          image1 = true;
          scaleOfImage1 = 5.5;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 1700), () {
      if (mounted) {
        setState(() {
          scaleOfImage1 = 4.0;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2900), () {
      if (mounted) {
        setState(() {
          image1Shift = true;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 3900), () {
      if (mounted) {
        setState(() {
          title = true;
          titleOfScale = 1.0;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 4600), () {
      if (mounted) {
        setState(() {
          image2 = true;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 5200), () {
      if (mounted) {
        setState(() {
          load = true;
        });

        Timer.periodic(const Duration(milliseconds: 350), (timer) {
          if (mounted) {
            setState(() {
              if (dot == 3) {
                dot = 1;
              } else {
                dot = dot + 1;
              }
            });
          } else {
            timer.cancel();
          }
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 8500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 248, 159),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: scaleOfImage1,
              duration: const Duration(milliseconds: 1200),
              child: AnimatedOpacity(
                opacity: image1 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1000),
                child: AnimatedPadding(
                  padding: EdgeInsets.only(top: image1Shift ? 0 : 40),
                  duration: const Duration(milliseconds: 1000),
                  child: Image.asset(
                    'Assets/App_logo.png',
                    height: 90,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: title ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedScale(
                    scale: titleOfScale,
                    duration: const Duration(milliseconds: 600),
                    child: const Text(
                      'CUISINE CIRCLE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2D2013),
                        letterSpacing: 4.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                AnimatedOpacity(
                  opacity: image2 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    'Assets/App_small_logo.png',
                    height: 45,
                  ),
                ),
                const SizedBox(height: 18),
                AnimatedOpacity(
                  opacity: load ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: const Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D2013),
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedOpacity(
                  opacity: load ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: dot == 1 ? 1.6 : 1.0,
                        duration: const Duration(milliseconds: 250),
                        child: const Text('●', style: TextStyle(fontSize: 14, color: Color(0xFF2D2013))),
                      ),
                      const SizedBox(width: 8),
                      AnimatedScale(
                        scale: dot == 2 ? 1.6 : 1.0,
                        duration: const Duration(milliseconds: 250),
                        child: const Text('●', style: TextStyle(fontSize: 14, color: Color(0xFF2D2013))),
                      ),
                      const SizedBox(width: 8),
                      AnimatedScale(
                        scale: dot == 3 ? 1.6 : 1.0,
                        duration: const Duration(milliseconds: 250),
                        child: const Text('●', style: TextStyle(fontSize: 14, color: Color(0xFF2D2013))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
