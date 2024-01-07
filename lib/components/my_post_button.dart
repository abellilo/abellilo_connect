import 'package:flutter/material.dart';

class MyPostButton extends StatelessWidget {
  final void Function()? onTap;
  MyPostButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: 10),
        child: Center(
          child: Icon(Icons.done,color: Theme.of(context).colorScheme.primary,),
        ),
      ),
    );
  }
}
