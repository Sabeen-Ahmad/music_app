import 'package:flutter/material.dart';
import 'package:music_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatefulWidget {
  const NeuBox({super.key, required this.child});
  final Widget? child;
  @override
  State<NeuBox> createState() => _NeuBoxState();
}

class _NeuBoxState extends State<NeuBox> {
  @override
  Widget build(BuildContext context) {
    //dark mode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            //darker shadow on bottom right
            BoxShadow(
              color: isDarkMode?Colors.black45:Colors.grey.shade500,
              blurRadius: 15,
              offset: Offset(4, 4),
            ),
            BoxShadow(
              color: isDarkMode?Colors.grey:Colors.grey.shade500,
              blurRadius: 15,
              offset: Offset(-4, -4),
            )
          ]),
      padding: const EdgeInsets.all(12),
      child: widget.child,
    );
  }
}
