import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../flutter_quill.dart';
import 'quill_icon_button.dart';

class ClearFormatButton extends StatefulWidget {
  const ClearFormatButton({
    required this.icon,
    required this.controller,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final Color? fillColor;
  final Color? borderColor;

  final QuillController controller;

  @override
  _ClearFormatButtonState createState() => _ClearFormatButtonState();
}

class _ClearFormatButtonState extends State<ClearFormatButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color;
    final fillColor = theme.canvasColor;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: !kIsWeb ? 1.5 : 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.borderColor ?? Colors.transparent,
        ),
        color: widget.fillColor,
      ),
      child: QuillIconButton(
          highlightElevation: 0,
          hoverElevation: 0,
          size: widget.iconSize * kIconButtonFactor,
          icon: Icon(widget.icon, size: widget.iconSize, color: iconColor),
          fillColor: Colors.transparent,
          onPressed: () {
            for (final k
                in widget.controller.getSelectionStyle().attributes.values) {
              widget.controller.formatSelection(Attribute.clone(k, null));
            }
          }),
    );
  }
}
