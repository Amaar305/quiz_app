import 'package:flutter/material.dart';
import 'package:quiz_app/quiz/page/quiz_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => QuizPage()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(100),
          child: Image.asset(
            'assets/icon.png',
            fit: BoxFit.contain,
            width: 150,
          ),
        ),
      ),
    );
  }
}
