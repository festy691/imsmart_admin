import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class CustomKeyboard extends StatefulWidget {
  final TextEditingController textController;
  const CustomKeyboard({
    Key? key,
    required this.textController,
  }) : super(key: key);

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  late TextEditingController _textcontroller;

  @override
  void initState() {
    _textcontroller = widget.textController;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _buildButton(String text, {VoidCallback? onPressed}) {
    return Expanded(
      child: InkWell(
        focusColor: Pallet.white,
        onTap: onPressed ?? () => _input(text),
        child: Center(
          child: TextView(
            text: text,
            textStyle: titleStyle.copyWith(
              fontSize: setSp(25),
              letterSpacing: 0.29,
              fontWeight: FontWeight.w400,
              color: Pallet.white,
            ),
          ),
        ),
      ),
    );
  }

  void _input(String text) {
    final value = _textcontroller.text + text;
    _textcontroller.text = value;
  }

  void _backSpace() {
    final value = _textcontroller.text;
    if (value.isNotEmpty) {
      _textcontroller.text = value.substring(0, (value.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Pallet.white.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: setHeight(40),
          left: setWidth(6),
          right: setWidth(6),
          bottom: setHeight(45),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                _buildButton("1"),
                SizedBox(width: setWidth(6)),
                _buildButton("2"),
                SizedBox(width: setWidth(6)),
                _buildButton("3"),
              ],
            ),
            SizedBox(height: setHeight(30)),
            Row(
              children: [
                _buildButton("4"),
                SizedBox(width: setWidth(6)),
                _buildButton("5"),
                SizedBox(width: setWidth(6)),
                _buildButton("6"),
              ],
            ),
            SizedBox(height: setHeight(30)),
            Row(
              children: [
                _buildButton("7"),
                SizedBox(width: setWidth(6)),
                _buildButton("8"),
                SizedBox(width: setWidth(6)),
                _buildButton("9"),
              ],
            ),
            SizedBox(height: setHeight(30)),
            Row(
              children: [
                _buildButton(" "),
                SizedBox(width: setWidth(6)),
                _buildButton("0"),
                SizedBox(width: setWidth(6)),
                _buildButton(
                  "⌫",
                  onPressed: _backSpace,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
