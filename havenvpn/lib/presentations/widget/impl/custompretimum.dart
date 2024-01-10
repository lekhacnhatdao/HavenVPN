import 'package:flutter/material.dart';

class CustomPretimum extends StatefulWidget {
  const CustomPretimum({super.key, required this.text, required this.image});
  final String image;

  final String text;
  @override
  State<CustomPretimum> createState() => _CustomPretimumState();
}

class _CustomPretimumState extends State<CustomPretimum> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10,),
        Container(margin: EdgeInsets.only(top: 10),child: const Icon(Icons.check, color: Colors.green,)) ,
        const SizedBox(width: 10,),
        Container(margin: EdgeInsets.only(top: 10), child: Text(widget.text, style: const TextStyle(color: Colors.black),)),
        const SizedBox(width: 10,),
        Image.asset(widget.image , height: 40,)
        
      ],
    );
  }
}