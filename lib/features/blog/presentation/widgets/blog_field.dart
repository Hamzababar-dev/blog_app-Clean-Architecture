import 'package:flutter/material.dart';

class BlogField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const BlogField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: (value){
        if(value!.isEmpty){
          return "Field cannot be empty";
        }
        return null;
      },
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,

      ),
    );
  }
}
