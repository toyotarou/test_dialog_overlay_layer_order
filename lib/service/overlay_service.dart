import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../parts/overlay_content_widget.dart';
import 'dialog_service.dart';

class OverlayService {
  OverlayEntry? overlayEntry;

  bool overlayOpenFlag = false;

  late OverlayState overlayState;

  ///
  void initOverlay(BuildContext context) => overlayState = Overlay.of(context);

  ///
  void openOverlay({required BuildContext context, required Widget dialogContentWidget, required String str}) {
    closeOverlay();

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
            str: str,
            dialogContentWidget: dialogContentWidget,
            onOpenDialog: () {
              callDialogService(
                context: context,
                str: str,
                dialogContentWidget: dialogContentWidget,
              );
            },
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
  Future<void> callDialogService(
      {required BuildContext context, required String str, required Widget dialogContentWidget}) async {
    await openDialog(
      context: context,
      dialogContentWidget: dialogContentWidget,

      ///
      paddingTop: context.screenSize.height * 0.3,
      paddingLeft: context.screenSize.width * 0.3,

      ///
      closeOverlay: closeOverlay,
      openOverlay: () => openOverlay(context: context, str: str, dialogContentWidget: dialogContentWidget),
      isOverlayOpen: overlayOpenFlag,
    );
  }
}
