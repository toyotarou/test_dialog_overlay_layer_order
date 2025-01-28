import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OverlayEntry? _overlayEntry;
  bool _isOverlayOpened = false;

  ///
  void openOverlay({required BuildContext context, required String str}) {
    if (_overlayEntry != null) {
      return;
    }

    _isOverlayOpened = true;

    final OverlayState overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 100,
        left: 50,
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(10)),
          child: displayOverlayContent(str: str),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  ///
  Widget displayOverlayContent({required String str}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          str,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => openDialog(context),
          child: const Text('オーバーレイから\nダイアログ開く'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => closeOverlay(),
          child: const Text('オーバーレイ閉じる'),
        ),
      ],
    );
  }

  ///
  void closeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    _isOverlayOpened = false;
  }

  ///
  void openDialog(BuildContext context) {
    _overlayEntry?.remove();
    _overlayEntry = null;

    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ダイアログ'),
        content: const Text('ダイアログの中身'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              if (_isOverlayOpened) {
                openOverlay(context: context, str: 'aaaaa');
              }
            },
            child: const Text('ダイアログ閉じる'),
          ),
        ],
      ),
    );
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => openOverlay(context: context, str: 'aaaaa'),
              child: const Text('オーバーレイ開く'),
            ),
          ],
        ),
      ),
    );
  }
}
