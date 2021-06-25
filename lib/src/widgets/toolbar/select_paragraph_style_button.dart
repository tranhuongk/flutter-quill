import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/documents/attribute.dart';
import '../../models/documents/style.dart';
import '../controller.dart';
import '../toolbar.dart';

class SelectParaStyleButton extends StatefulWidget {
  const SelectParaStyleButton({
    required this.controller,
    this.iconSize = kDefaultIconSize,
    Key? key,
  }) : super(key: key);

  final QuillController controller;
  final double iconSize;

  @override
  _SelectParaStyleButtonState createState() => _SelectParaStyleButtonState();
}

class _SelectParaStyleButtonState extends State<SelectParaStyleButton> {
  Attribute? _value;

  Style get _selectionStyle => widget.controller.getSelectionStyle();

  @override
  void initState() {
    super.initState();
    setState(() {
      _value =
          _selectionStyle.attributes[Attribute.align.key] ?? Attribute.align;
    });
    widget.controller.addListener(_didChangeEditingValue);
  }

  @override
  Widget build(BuildContext context) {
    final _valueToText = <Attribute, IconData>{
      Attribute.leftAlignment: Icons.format_align_left,
      Attribute.centerAlignment: Icons.format_align_center,
      Attribute.rightAlignment: Icons.format_align_right,
      // Attribute.justifyAlignment: Icons.format_align_justify,
    };

    final _valueAttribute = <Attribute>[
      Attribute.leftAlignment,
      Attribute.centerAlignment,
      Attribute.rightAlignment,
      // Attribute.justifyAlignment
    ];
    final _valueIconData = <IconData>[
      Icons.format_align_left,
      Icons.format_align_center,
      Icons.format_align_right,
      // Icons.format_align_justify,
    ];

    final theme = Theme.of(context);
    final style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: widget.iconSize * 0.7,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: !kIsWeb ? 1.0 : 5.0),
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              width: widget.iconSize * kIconButtonFactor,
              height: widget.iconSize * kIconButtonFactor,
            ),
            child: RawMaterialButton(
              hoverElevation: 0,
              highlightElevation: 0,
              elevation: 0,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              fillColor: _valueToText[_value] == _valueIconData[index]
                  ? theme.toggleableActiveColor
                  : theme.canvasColor,
              onPressed: () =>
                  widget.controller.formatSelection(_valueAttribute[index]),
              child: Icon(
                _valueIconData[index],
                color: _valueToText[_value] == _valueIconData[index]
                    ? theme.primaryIconTheme.color
                    : theme.iconTheme.color,
                size: widget.iconSize,
              ),
            ),
          ),
        );
      }),
    );
  }

  void _didChangeEditingValue() {
    setState(() {
      _value =
          _selectionStyle.attributes[Attribute.align.key] ?? Attribute.align;
    });
  }

  @override
  void didUpdateWidget(covariant SelectParaStyleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_didChangeEditingValue);
      widget.controller.addListener(_didChangeEditingValue);
      _value =
          _selectionStyle.attributes[Attribute.align.key] ?? Attribute.align;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_didChangeEditingValue);
    super.dispose();
  }
}
