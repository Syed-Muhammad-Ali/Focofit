// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DiaryContainerTile extends StatelessWidget {
  DiaryContainerTile({super.key, required this.child, this.padding});
  final Widget child;
  EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 10),
        ],
        border: Border.all(color: Color(0xffD2D2D2)),
      ),
      child: child,
    );
  }
}
