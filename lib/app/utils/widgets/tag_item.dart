import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  const TagItem({
    Key? key,
    required this.tag,
  }) : super(key: key);
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffdce9ed),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        //border: Border.all(color: Colors.black54),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: const Offset(0, 40),
              blurRadius: 80),
        ],
      ),
      child: Text(tag),
    );
  }
}
