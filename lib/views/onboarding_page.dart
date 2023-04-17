import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_service.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key, required this.title});

  final String title;

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            appService.onboarding = true;
          },
          child: const Text('DONE'),
        ),
      ),
    );
  }
}
