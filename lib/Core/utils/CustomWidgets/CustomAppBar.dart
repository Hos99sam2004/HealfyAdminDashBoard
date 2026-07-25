// import 'package:flutter/material.dart';

// class CustomAppBar extends StatefulWidget {
//   final String text;
//   final List<Color> colors;
//   final bool centerTitle;
//   final bool WithShader;
//   CustomAppBar({
//     super.key,
//     required this.text,
//     this.colors = const [
//       Colors.purple,
//       Colors.indigo,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.orange,
//       Colors.red,
//     ],
//     this.centerTitle = true,
//     this.WithShader = true,
//   });

//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();
// }

// class _CustomAppBarState extends State<CustomAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: ShaderMask(
//         // تحديد النوع (تدرج لوني في هذه الحالة)
//         shaderCallback: (Rect bounds) {
//           return LinearGradient(
//             colors: widget.colors,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ).createShader(bounds); // تحويل التدرج إلى Shader
//         },
//         // تحديد كيفية دمج اللون مع العنصر الأصلي
//         blendMode: BlendMode.srcIn,
//         child: Text(
//           widget.text,
//           style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//         ),
//       ),
//       centerTitle: true,
//     );
//   }
// }
import 'package:flutter/material.dart';

// أضفنا implements PreferredSizeWidget هنا
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String text;
  final List<Color> colors;
  final List<Widget> actions;
  final bool centerTitle;
  final bool withShader;
  final Color bcolor;

  CustomAppBar({
    super.key,
    required this.text,
    this.colors = const [
      Colors.purple,
      Colors.indigo,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.red,
    ],
    this.centerTitle = true,
    this.withShader = false,
    this.actions = const [],
    this.bcolor = Colors.white,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // هذا السطر يخبر Scaffold كم يبلغ ارتفاع الـ AppBar
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.bcolor,
      actions: widget.actions,
      centerTitle: widget.centerTitle,
      title: widget.withShader
          ? ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: widget.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Text(
              widget.text,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
    );
  }
}
