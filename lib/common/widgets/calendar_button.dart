import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../app/tokens.dart";
import "../utils/date_time_ext.dart";

class CalendarButton extends HookWidget {
  const CalendarButton({super.key, this.readonly = true});

  final bool readonly;

  Future<DateTime> getDateTime(BuildContext context) async {
    final date =
        await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2050)) ?? DateTime.now();
    TimeOfDay? time;
    if (context.mounted) {
      time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    }

    if (time == null) return date;
    return date.copyWith(hour: time.hour, minute: time.minute);
  }

  @override
  Widget build(BuildContext context) {
    final date = useState<DateTime>(DateTime.now());

    return Container(
      padding: const EdgeInsets.all(p4),
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
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: readonly ? null : () async => date.value = await getDateTime(context),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 4),
                  Text(
                    date.value.toPolishShort(),
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
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
