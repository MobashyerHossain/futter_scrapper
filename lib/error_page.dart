import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final error;
  ErrorPage({
    Key? key,
    required this.error,
  }) : super(key: key);

  getError() => this.error;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ErrorWidget(
          this.getError(),
        ),
      ),
    );
  }
}
