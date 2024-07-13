import 'package:flutter/material.dart';

Widget TextContainer(String data, EdgeInsets margin, Color color) {
  return Focus(
    child: Builder(builder: (context) {
      bool hasFocus = Focus.of(context).hasFocus;
      return Container(
        constraints: BoxConstraints(minHeight: hasFocus ? 38 : 36),
        margin: margin,
        decoration: BoxDecoration(
            color: color.withOpacity(0.6),
            border: Border.all(
                width: 0.75, color: const Color(0xFFA3A3B0).withOpacity(0.5)),
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            data,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }),
  );
}

Widget TitleText(data) {
  return Container(
    margin: const EdgeInsets.all(8),
    child: Text(
      data,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  );
}
