import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_casher/feature/pos/presentation/page/cart_page.dart';
import 'package:my_casher/feature/pos/presentation/page/pos_page.dart';
import 'package:my_casher/shared/widget/app_bar/app_app_bar.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  late final PageController _controller;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _controller = PageController();

    _pages = [
      PosPage(controller: _controller),
      CartPage(controller: _controller),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Kasir'),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}
