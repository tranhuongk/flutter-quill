import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../flutter_quill.dart';
import 'quill_icon_button.dart';

class IndentButton extends StatefulWidget {
  const IndentButton({
    required this.icon,
    required this.controller,
    required this.isIncrease,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final QuillController controller;
  final bool isIncrease;
  final Color? fillColor;
  final Color? borderColor;

  @override
  _IndentButtonState createState() => _IndentButtonState();
}

class _IndentButtonState extends State<IndentButton> {
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
        size: widget.iconSize * 1.77,
        icon: Icon(widget.icon, size: widget.iconSize, color: iconColor),
        fillColor: Colors.transparent,
        onPressed: () {
          final indent = widget.controller
              .getSelectionStyle()
              .attributes[Attribute.indent.key];
          if (indent == null) {
            if (widget.isIncrease) {
              widget.controller.formatSelection(Attribute.indentL1);
            }
            return;
          }
          if (indent.value == 1 && !widget.isIncrease) {
            widget.controller
                .formatSelection(Attribute.clone(Attribute.indentL1, null));
            return;
          }
          if (widget.isIncrease) {
            widget.controller
                .formatSelection(Attribute.getIndentLevel(indent.value + 1));
            return;
          }
          widget.controller
              .formatSelection(Attribute.getIndentLevel(indent.value - 1));
        },
      ),
    );
  }
}
