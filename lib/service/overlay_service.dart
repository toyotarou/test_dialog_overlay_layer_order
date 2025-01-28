import 'package:flutter/material.dart';

import 'dialog_service.dart';

class OverlayService {
  OverlayEntry? _overlayEntry;

  bool _overlayOpenFlag = false;

  late OverlayState _overlayState;

  ///
  void initOverlay(BuildContext context) => _overlayState = Overlay.of(context);

  ///
  void openOverlay({required BuildContext context, required String str}) {
    if (_overlayEntry != null) {
      return;
    }

    _overlayOpenFlag = true;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 100,
        left: 50,
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                str,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () => _callDialogService(context, str), child: const Text('ダイアログ開く')),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: closeOverlay, child: const Text('オーバーレイ閉じる')),
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

    _overlayOpenFlag = false;
  }

  ///
  Future<void> _callDialogService(BuildContext context, String str) async {
    await openDialog(
      context: context,
      str: str,
      removeOverlay: closeOverlay,
      reOpenOverlay: () => openOverlay(context: context, str: str),
      isOverlayOpen: _overlayOpenFlag,
    );
  }
}
