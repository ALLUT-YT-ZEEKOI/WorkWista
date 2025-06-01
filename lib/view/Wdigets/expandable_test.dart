import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ExpandableText({
    Key? key,
    required this.text,
    this.trimLength = 100,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final showMore = widget.text.length > widget.trimLength;

    final displayText = isExpanded || !showMore
        ? widget.text
        : widget.text.substring(0, widget.trimLength) + '... ';

    return RichText(
      text: TextSpan(
        text: displayText,
        style: TextStyle(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.6),
          fontSize: 16,
        ),
        children: showMore && !isExpanded
            ? [
                TextSpan(
                  text: 'more',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isExpanded = true;
                      });
                    },
                )
              ]
            : [],
      ),
    );
  }
}
