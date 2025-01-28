import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OverlayEntry? _overlayEntry;

  bool overlayOpenFlag = false;

  late OverlayState _overlayState;

  ///
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _overlayState = Overlay.of(context);
  }

  ///
  void openOverlay({required String str}) {
    if (_overlayEntry != null) {
      return;
    }

    overlayOpenFlag = true;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 100,
        left: 50,
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                str,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () => openDialog(str: str), child: const Text('ダイアログ開く')),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () => closeOverlay(), child: const Text('オーバーレイ閉じる')),
            ],
          ),
        ),
      ),
    );

    _overlayState.insert(_overlayEntry!);
  }

  ///
  void closeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    overlayOpenFlag = false;
  }

  ///
  void openDialog({required String str}) {
    _overlayEntry?.remove();
    _overlayEntry = null;

    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        title: Text('ダイアログ'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('ダイアログ内容')],
        ),
      ),
    ).then((_) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (overlayOpenFlag) {
          openOverlay(str: str);
        }
      });
    });
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
              onPressed: () => openOverlay(str: 'aaaaa'),
              child: const Text('オーバーレイ開く'),
            ),
          ],
        ),
      ),
    );
  }
}
