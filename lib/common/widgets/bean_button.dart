import "package:flutter/material.dart";

import "../../app/theme.dart";
import "../../app/tokens.dart";

class BeanButton extends StatelessWidget {
  const BeanButton({required this.icon, required this.label, required this.isActive, required this.onTap});

  final Widget icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(isActive ? r25 : r27),
        splashColor: Colors.white.withValues(alpha: 0.2),
        highlightColor: Colors.white.withValues(alpha: 0.1),
        child: Container(
          // For expanded form: padding: 18px 20px
          // For small form: width: 56px, height: 56px, padding: 18px 20px
          width: isActive ? null : p56,
          height: isActive ? null : p56,
          padding: isActive ? const EdgeInsets.symmetric(horizontal: p20, vertical: p18) : null,
          decoration: BoxDecoration(
            color: isActive ? Colors.transparent : null,
            border: Border.all(color: isActive ? Colors.white.withValues(alpha: 0.3) : greyBorderNav),
            borderRadius: BorderRadius.circular(isActive ? r25 : r27),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isActive ? r25 : r27),
            child: BackdropFilter(
              filter: navBlurFilter,
              enabled: isActive,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  if (isActive) ...[
                    const SizedBox(width: p8),
                    Text(label, style: context.textTheme.titleMedium?.white),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
