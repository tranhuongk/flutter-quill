import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../flutter_quill.dart';
import 'quill_icon_button.dart';

class HistoryButton extends StatefulWidget {
  const HistoryButton({
    required this.icon,
    required this.controller,
    required this.undo,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final bool undo;
  final QuillController controller;
  final Color? fillColor;
  final Color? borderColor;

  @override
  _HistoryButtonState createState() => _HistoryButtonState();
}

class _HistoryButtonState extends State<HistoryButton> {
  Color? _iconColor;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    _setIconColor();

    final fillColor = theme.canvasColor;
    widget.controller.changes.listen((event) async {
      _setIconColor();
    });
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
        icon: Icon(widget.icon, size: widget.iconSize, color: _iconColor),
        fillColor: Colors.transparent,
        onPressed: _changeHistory,
      ),
    );
  }

  void _setIconColor() {
    if (!mounted) return;

    if (widget.undo) {
      setState(() {
        _iconColor = widget.controller.hasUndo
            ? theme.iconTheme.color
            : theme.disabledColor;
      });
    } else {
      setState(() {
        _iconColor = widget.controller.hasRedo
            ? theme.iconTheme.color
            : theme.disabledColor;
      });
    }
  }

  void _changeHistory() {
    if (widget.undo) {
      if (widget.controller.hasUndo) {
        widget.controller.undo();
      }
    } else {
      if (widget.controller.hasRedo) {
        widget.controller.redo();
      }
    }

    _setIconColor();
  }
}
