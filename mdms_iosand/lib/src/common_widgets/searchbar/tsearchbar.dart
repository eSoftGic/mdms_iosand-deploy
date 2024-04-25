import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Icons.search,
    this.showBackground = false,
    this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width - 24,
      height: 50,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: showBackground
              ? isDark
                  ? tWhiteColor
                  : tPrimaryColor.withOpacity(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: showBorder ? Border.all(color: tWhiteColor) : null),
      child: Row(children: [
        Icon(
          icon,
          color: tWhiteColor,
          size: 24,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: tWhiteColor)),
      ]),
    );
  }
}
