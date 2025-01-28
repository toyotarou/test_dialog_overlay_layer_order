import 'package:flutter/material.dart';

class OverlayContentWidget extends StatelessWidget {
  const OverlayContentWidget({
    super.key,
    required this.str,
    required this.dialogContentWidget,
    required this.onOpenDialog,
    required this.onCloseOverlay,
  });

  final String str;
  final Widget dialogContentWidget;
  final VoidCallback onOpenDialog;
  final VoidCallback onCloseOverlay;

  ///
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          str,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 18),
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: onOpenDialog, child: const Text('ダイアログ開く')),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: onCloseOverlay, child: const Text('オーバーレイ閉じる')),
      ],
    );
  }
}
