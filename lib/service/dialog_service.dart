import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
Future<void> openDialog({
  required BuildContext context,
  required Widget dialogContentWidget,

  ///
  double paddingTop = 0,
  double paddingRight = 0,
  double paddingBottom = 0,
  double paddingLeft = 0,
  bool clearBarrierColor = false,
  bool? executeFunctionWhenDialogClose,
  WidgetRef? ref,
  String? from,

  ///
  VoidCallback? closeOverlay,
  VoidCallback? openOverlay,
  bool? isOverlayOpen,
}) async {
  if (closeOverlay != null) {
    closeOverlay();
  }

  // ignore: inference_failure_on_function_invocation
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(top: paddingTop, right: paddingRight, bottom: paddingBottom, left: paddingLeft),
        child: Dialog(
          backgroundColor: Colors.blueGrey.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          insetPadding: const EdgeInsets.all(30),
          child: dialogContentWidget,
        ),
      );
    },
    // ignore: always_specify_types
  ).then((value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: use_if_null_to_convert_nulls_to_bools
      if (isOverlayOpen == true) {
        if (openOverlay != null) {
          openOverlay();
        }
      }
    });
  });
}
