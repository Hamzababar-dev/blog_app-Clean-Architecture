import 'package:blog_app/core/theme/appcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget{
  final VoidCallback onPressed;
  final String buttonText;

  const AuthGradientButton({super.key, required this.buttonText, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.gradient1,
          AppColors.gradient2,
        ],
        begin: Alignment.bottomLeft,
          end: Alignment.topRight
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: ElevatedButton(onPressed: onPressed, child: Text(buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        fixedSize: Size(395, 55),

      ),),
    );
  }}