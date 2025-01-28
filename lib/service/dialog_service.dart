import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../extensions/extensions.dart';

///
Future<void> openDialog({
  required BuildContext context,
  required String str,
  required VoidCallback removeOverlay,
  required VoidCallback reOpenOverlay,
  required bool isOverlayOpen,
  required Widget dialogContentWidget,
}) async {
  removeOverlay();

  // ignore: inference_failure_on_function_invocation
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(
          top: context.screenSize.height * 0.3,
          left: context.screenSize.width * 0.3,
        ),
        child: Dialog(
          backgroundColor: Colors.blueGrey.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          insetPadding: const EdgeInsets.all(30),
          child: dialogContentWidget,
        ),
      );
    },
  );

  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (isOverlayOpen) {
      reOpenOverlay();
    }
  });
}
