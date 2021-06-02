import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/faq.dart';

import '../../styles.dart';

class FaqDetail extends StatelessWidget {
  final Faq faq;

  FaqDetail(this.faq);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Text(
            faq.quest,
            style: Styles.projectTextTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 100),
          Text(
            faq.resp,
            style: Styles.projectText,
            textAlign: TextAlign.center,
          ),
        ]));
  }
}
