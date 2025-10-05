import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:toastification/toastification.dart";

import "../../app/theme.dart";
import "../../app/tokens.dart";
import "../../common/services/location_service.dart";
import "../../common/widgets/app_bars/simple_logo_app_bar.dart";
import "../../common/widgets/gradient_scaffold.dart";
import "../stops/view/animated_double_circle.dart";
import "../stops_map/data/rest_client.dart";
import "data/report_dto.dart";

@RoutePage()
class ReportIncidentsPage extends HookConsumerWidget {
  const ReportIncidentsPage({super.key, required this.routeId, required this.runId});
  final String routeId;
  final int runId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIncidentType = useState<IncidentType?>(null);
    Future<void> onFormSubmit() async {
      if (selectedIncidentType.value != null) {
        final location = await LocationService.getCurrentLocation();
        final restClient = ref.read(restClientProvider);
        final dto = ReportDto(type: selectedIncidentType.value!, coordinates: location, run: runId);
        await restClient.sendReport(routeId, dto);
        toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.flat,
          title: const Text("Zgłoszenie wysłane pomyślnie"),
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
        );
        if (context.mounted) {
          context.router.pop();
        }
      }
    }

    return GradientScaffold(
      safeArea: false,
      body: Stack(
        children: [
          const AnimatedDoubleCircle(isBigger: true),
          SimpleLogoAppBar(),
          Positioned(
            top: 120,
            left: p16,
            right: p16,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(p16),
              child: Column(
                children: [
                  Text("Zgłoś zdarzenie na aktualnej trasie!", style: context.textTheme.headlineSmall?.white.megaBold),
                  const SizedBox(height: p32),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(p16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Wybierz typ zdarzenia:", style: context.textTheme.titleMedium?.megaBold),
                            const SizedBox(height: 16),
                            ...IncidentType.values.map(
                              (type) => _buildRadioOption(
                                context,
                                type,
                                selectedIncidentType.value,
                                (value) => selectedIncidentType.value = value,
                              ),
                            ),

                            // Submit button
                            Positioned(
                              bottom: 110,
                              left: 25,
                              right: 25,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: selectedIncidentType.value != null
                                    ? FilledButton(onPressed: onFormSubmit, child: const Text("WYŚLIJ ZGŁOSZENIE"))
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(
    BuildContext context,
    IncidentType type,
    IncidentType? selectedType,
    ValueChanged<IncidentType> onChanged,
  ) {
    final isSelected = selectedType == type;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey[300]!, width: isSelected ? 2 : 1),
      ),
      child: RadioListTile<IncidentType>(
        value: type,
        // ignore: deprecated_member_use
        groupValue: selectedType,
        // ignore: deprecated_member_use
        onChanged: (value) => value != null ? onChanged(value) : null,
        activeColor: Colors.blue,
        title: Text(
          _getIncidentTypeDisplayName(type),
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blue[800] : Colors.grey[700],
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  String _getIncidentTypeDisplayName(IncidentType type) {
    switch (type) {
      case IncidentType.delay:
        return "Opóźnienie";
      case IncidentType.accident:
        return "Wypadek";
      case IncidentType.press:
        return "Zatłoczenie";
      case IncidentType.failure:
        return "Awaria";
      case IncidentType.didNotArrive:
        return "Nie przyjechał";
      case IncidentType.change:
        return "Zmiana peronu lub linii";
      case IncidentType.other:
        return "Inne";
      case IncidentType.differentStopLocation:
        return "Inna lokalizacja przystanku";
      case IncidentType.requestStop:
        return "Zaproponuj nowy przystanek";
    }
  }
}
