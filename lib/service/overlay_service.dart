import 'package:flutter/material.dart';

import 'dialog_service.dart';

class OverlayService {
  OverlayEntry? overlayEntry;

  bool overlayOpenFlag = false;

  late OverlayState overlayState;

  ///
  void initOverlay(BuildContext context) => overlayState = Overlay.of(context);

  ///
  void openOverlay({
    required BuildContext context,
    required String str,
    required Widget dialogContentWidget,
  }) {
    if (overlayEntry != null) {
      return;
    }

    overlayOpenFlag = true;

    overlayEntry = OverlayEntry(
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
              ElevatedButton(
                onPressed: () =>
                    callDialogService(context: context, str: str, dialogContentWidget: dialogContentWidget),
                child: const Text('ダイアログ開く'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: closeOverlay, child: const Text('オーバーレイ閉じる')),
            ],
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry!);
  }

  ///
  void closeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }

    overlayOpenFlag = false;
  }

  ///
  Future<void> callDialogService({
    required BuildContext context,
    required String str,
    required Widget dialogContentWidget,
  }) async {
    await openDialog(
      context: context,
      str: str,
      removeOverlay: closeOverlay,
      reOpenOverlay: () => openOverlay(context: context, str: str, dialogContentWidget: dialogContentWidget),
      isOverlayOpen: overlayOpenFlag,
      dialogContentWidget: dialogContentWidget,
    );
  }
}
