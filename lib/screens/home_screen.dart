import 'package:flutter/material.dart';
import '../service/overlay_service.dart';
import 'second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OverlayService overlayService = OverlayService();

  ///
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    overlayService.initOverlay(context);
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => overlayService.openOverlay(context: context, dialogContentWidget: const SecondScreen()),
          child: const Text('オーバーレイ開く'),
        ),
      ),
    );
  }
}
