import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../app/tokens.dart";

//! vibes

class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      height: 33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r18),
        border: Border.all(color: const Color(0xFFCDCDCD)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x00AFAFAF), // rgba(175, 175, 175, 0.00)
            offset: Offset(24, -30),
            blurRadius: 40,
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(r18),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(r18),
            onTap: () => context.router.maybePop(),
            child: const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios, size: 16, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    "Powrót",
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
