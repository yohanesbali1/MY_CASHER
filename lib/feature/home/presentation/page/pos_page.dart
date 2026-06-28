import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_casher/shared/widget/app_bar/app_app_bar.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Kasir'),
      body: Container(),
    );
  }
}
