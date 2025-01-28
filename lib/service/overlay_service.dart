import 'package:flutter/material.dart';

import '../parts/overlay_content_widget.dart';
import 'dialog_service.dart';

class OverlayService {
  OverlayEntry? overlayEntry;

  bool overlayOpenFlag = false;

  late OverlayState overlayState;

  ///
  void initOverlay(BuildContext context) => overlayState = Overlay.of(context);

  ///
  void openOverlay({required BuildContext context, required Widget dialogContentWidget}) {
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
          child: OverlayContentWidget(
            str: 'bbb',
            dialogContentWidget: dialogContentWidget,
            onOpenDialog: () => callDialogService(context: context, dialogContentWidget: dialogContentWidget),
            onCloseOverlay: closeOverlay,
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
  Future<void> callDialogService({required BuildContext context, required Widget dialogContentWidget}) async {
    await openDialog(
      context: context,
      removeOverlay: closeOverlay,
      reOpenOverlay: () => openOverlay(context: context, dialogContentWidget: dialogContentWidget),
      isOverlayOpen: overlayOpenFlag,
      dialogContentWidget: dialogContentWidget,
    );
  }
}
