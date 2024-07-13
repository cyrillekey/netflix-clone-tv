import 'package:flutter/material.dart';

class CircularButtons extends StatelessWidget {
  const CircularButtons({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      focusNode: FocusNode(),
      child: Builder(builder: (context) {
        bool hasFocus = Focus.of(context).hasFocus;
        return InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            width: hasFocus ? 42 : 36,
            height: hasFocus ? 42 : 36,
            margin: const EdgeInsets.only(top: 8, right: 8),
            decoration: BoxDecoration(
                color: const Color(0xFF23232B).withOpacity(0.60),
                border: Border.all(width: 0.75, color: const Color(0xFF373741)),
                borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: Icon(icon, color: const Color(0xFF9D9DA5)),
            ),
          ),
        );
      }),
    );
  }
}
