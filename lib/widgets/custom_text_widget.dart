import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
 final String? data;
  double? fontSize;
  FontWeight? fontWeight;
  FontStyle? fontStyle;

  CustomTextWidget( this.data, { this.fontSize, this.fontWeight, this.fontStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return  Text(
      data ?? '',
      maxLines: 1,
      style:  TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle:fontStyle,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
