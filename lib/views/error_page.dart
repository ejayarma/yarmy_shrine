import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/route_utils.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, required this.error});

  final String error;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.error),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.error),
            TextButton(
              onPressed: () {
                GoRouter.of(context).goNamed(AppPage.home.toName);
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
