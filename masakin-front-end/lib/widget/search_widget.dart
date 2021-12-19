import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Color(0xFF817E7E));
    final styleHint = TextStyle(
      color: Color(0xFF817E7E),
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          prefixIcon: Icon(Icons.search, size: 24, color: Color(0xFFF5C901)),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, size: 24, color: Color(0xFFF5C901)),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
            borderSide: BorderSide(
              color: Color(0xFFF5C901),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
            borderSide: BorderSide(
              color: Color(0xFFF5C901),
              width: 2,
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
