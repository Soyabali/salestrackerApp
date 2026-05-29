import 'package:flutter/material.dart';
import 'app_text_style.dart';

class CustomElevatedButton extends StatelessWidget {

  final String text;
  final VoidCallback onTap;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.red,
        // Background color of the container
        borderRadius: BorderRadius.circular(17.0),
        // Circular border radius
        border: Border.all(
          color: Colors.yellow, // Border color
          width: 0.5, // Border width
        ),
      ),
      child: ElevatedButton(
        onPressed: onTap,
         style: ElevatedButton.styleFrom(
           foregroundColor: Colors.white,
           backgroundColor: Colors.red,
           shadowColor: Colors.red, // Custom shadow color
           elevation: 5, // Text color
         ).copyWith(
           overlayColor: MaterialStateProperty.resolveWith<Color?>(
                 (Set<MaterialState> states) {
               if (states.contains(MaterialState.pressed)) {
                 return Colors.yellow; // Splash color when pressed
               }
               return null; // Default splash color
             },
           ),
         ),
         child: Text(text,style: AppTextStyle
             .font14penSansExtraboldWhiteTextStyle,),
       )
    );
  }
}
