import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///
Future<void> openDialog({
  required BuildContext context,
  required String str,
  required VoidCallback removeOverlay,
  required VoidCallback reOpenOverlay,
  required bool isOverlayOpen,
}) async {
  removeOverlay();

  // ignore: inference_failure_on_function_invocation
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text('ダイアログ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('ダイアログ内容'),
          ],
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
