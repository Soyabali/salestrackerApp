// TextFormField
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
// TextFormField
Widget commonTextFormField({
  required TextEditingController controller,
  required String labelText,
   IconData? prefixIcon,

  FocusNode? focusNode,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,

  bool obscureText = false,

  /// 🔥 NEW: password support
  bool isPassword = false,
  VoidCallback? onTogglePassword,

  int maxLines = 1,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return TextFormField(
    controller: controller,
    focusNode: focusNode,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    obscureText: obscureText,
    maxLines: maxLines,
    validator: validator,
    onChanged: onChanged,

    style: GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      letterSpacing: 1.0,
    ),

    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
        letterSpacing: 1,
      ),

      prefixIcon: Icon(
        prefixIcon,
        color: const Color(0xFFB957FF),
      ),

      /// 🔥 PASSWORD TOGGLE ICON
      // suffixIcon: isPassword
      //     ? IconButton(
      //   onPressed: onTogglePassword,
      //   icon: Icon(
      //     obscureText
      //         ? Icons.visibility
      //         : Icons.visibility_off,
      //     color: Colors.grey,
      //   ),
      // )
      //     : null,
      suffixIcon: isPassword
          ? IconButton(
        onPressed: onTogglePassword,
        icon: Icon(
          obscureText
              ? Icons.visibility_off   // 👁️ hidden state
              : Icons.visibility,      // 👁️ visible state
          color: Colors.grey,
        ),
      )
          : null,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.2,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.8,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),

      filled: true,
      fillColor: Colors.white.withOpacity(0.15),
    ),
  );
}

// button function

Widget commonGradientButton({
  required String label,
  required VoidCallback onPressed,

  double width = double.infinity,
  double height = 58,

  double borderRadius = 18,

  Color startColor = const Color(0xFFB957FF),
  Color endColor = const Color(0xFF7B2CBF),

  TextStyle? textStyle,

  IconData? icon,
  double iconSize = 22,
  double iconSpacing = 10,

  bool showShadow = true,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            startColor,
            endColor,
          ],
        ),

        boxShadow: showShadow
            ? [
          BoxShadow(
            color: startColor.withOpacity(0.45),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ]
            : [],
      ),

      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: textStyle ??
                  const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
            ),

            if (icon != null) ...[
              SizedBox(width: iconSpacing),
              Icon(
                icon,
                color: Colors.white,
                size: iconSize,
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
//  textView function
Widget commonTextView({
  required String text,

  double fontSize = 16,
  FontWeight fontWeight = FontWeight.w500,
  Color color = Colors.black87,

  double letterSpacing = 0,
  FontStyle fontStyle = FontStyle.normal,

  TextAlign textAlign = TextAlign.center,

  EdgeInsetsGeometry padding =
  const EdgeInsets.symmetric(vertical: 10, horizontal: 0),

  double? width,
}) {
  return Container(
    width: width ?? double.infinity,
    padding: padding,
    child: Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.lato(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
        letterSpacing: letterSpacing,
      ),
    ),
  );
}
// COMMON Card all applicarion
Widget commonGlassFormCard({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required String title,
  required List<Widget> children,
  required Widget button,

  double widthFactor = 0.7,
  double? height,

  EdgeInsetsGeometry padding =
  const EdgeInsets.all(20),

}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 20,
      top: 20,
      bottom: 20,
    ),
    child: Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),

        child: GlassmorphicContainer(
          width: MediaQuery.of(context).size.width * widthFactor,
          height: height ??
              (MediaQuery.of(context).size.height < 700 ? 470 : 350),

          borderRadius: 24,
          blur: 20,
          alignment: Alignment.center,
          border: 1.5,

          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.90),
              const Color(0xFFe1befa).withOpacity(0.5),
              Colors.white.withOpacity(0.10),
            ],
          ),

          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.85),
              const Color(0xFFB957FF).withOpacity(0.12),
              Colors.white.withOpacity(0.70),
            ],
          ),

          child: Padding(
            padding: padding,

            child: Form(
              key: formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// DYNAMIC FIELDS
                  ...children,

                  const SizedBox(height: 20),

                  /// BUTTON
                  button,
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// uplode document Cards

Widget uploadDocumentCard({
  VoidCallback? onCameraTap,
  VoidCallback? onGalleryTap,
}) {
  return Card(
    elevation: 8,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: DottedBorder(
      options: const RoundedRectDottedBorderOptions(
        radius: Radius.circular(20),
        dashPattern: [8, 5],
        strokeWidth: 1.5,
        color: Color(0xFFB957FF),
      ),
      child: Container(
        height: 105,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [

            /// Camera
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: onCameraTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6503AB).withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 24,
                        color: Color(0xFF6503AB),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Click Photo",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6503AB),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Container(
            //   width: 1,
            //   margin: const EdgeInsets.symmetric(vertical: 15),
            //   color: Colors.grey.shade200,
            // ),

            /// Gallery
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: onGalleryTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6503AB).withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.photo_library_rounded,
                        size: 24,
                        color: Color(0xFF6503AB),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Select Photo",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6503AB),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    ),
  );
}
// tost code
void displayToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}