import 'package:flutter/material.dart';
import 'package:score_keeper/generated/i18n.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(S.of(context).unknown),
      ),
    );
  }
}
