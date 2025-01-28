import 'package:flutter/material.dart';
import '../service/overlay_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OverlayService _overlayService = OverlayService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _overlayService.initOverlay(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              _overlayService.openOverlay(context: context, str: 'aaaaa'),
          child: const Text('オーバーレイ開く'),
        ),
      ),
    );
  }
}
