import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/documents/nodes/embed.dart';
import '../controller.dart';
import '../toolbar.dart';
import 'quill_icon_button.dart';

class InsertEmbedButton extends StatelessWidget {
  const InsertEmbedButton({
    required this.controller,
    required this.icon,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  final QuillController controller;
  final IconData icon;
  final double iconSize;
  final Color? fillColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: !kIsWeb ? 1.5 : 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
        color: fillColor,
      ),
      child: QuillIconButton(
        highlightElevation: 0,
        hoverElevation: 0,
        size: iconSize * kIconButtonFactor,
        icon: Icon(
          icon,
          size: iconSize,
          color: Theme.of(context).iconTheme.color,
        ),
        fillColor: Colors.transparent,
        onPressed: () {
          final index = controller.selection.baseOffset;
          final length = controller.selection.extentOffset - index;
          controller.replaceText(
              index, length, BlockEmbed.horizontalRule, null);
        },
      ),
    );
  }
}
