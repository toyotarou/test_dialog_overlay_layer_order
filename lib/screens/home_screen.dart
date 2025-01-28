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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            /////

            ElevatedButton(
              onPressed: () => overlayService.openOverlay(
                context: context,
                str: 'aaa',
                dialogContentWidget: const SecondScreen(str: 'aaa'),
              ),
              child: const Text('aaa'),
            ),

            /////

            ElevatedButton(
              onPressed: () => overlayService.openOverlay(
                context: context,
                str: 'bbb',
                dialogContentWidget: const SecondScreen(str: 'bbb'),
              ),
              child: const Text('bbb'),
            ),
            /////

            ElevatedButton(
              onPressed: () => overlayService.openOverlay(
                context: context,
                str: 'ccc',
                dialogContentWidget: const SecondScreen(str: 'ccc'),
              ),
              child: const Text('ccc'),
            ),

            /////
          ],
        ),
      ),
    );
  }
}
