import "dart:io";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_picker/image_picker.dart";
import "package:toastification/toastification.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/simple_logo_app_bar.dart";
import "../../../common/widgets/gradient_scaffold.dart";
import "../../../common/widgets/inputs/multiline_input.dart";
import "../../../common/widgets/inputs/my_input.dart";
import "../../stops/view/animated_double_circle.dart";
import "../hooks/use_image_picker.dart";

class ReportScheduleView extends HookWidget {
  const ReportScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePicker = useImagePicker();
    final image = imagePicker.image.value;
    final key = useRef(GlobalKey<FormBuilderState>());
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return FormBuilder(
      key: key.value,
      child: GradientScaffold(
        safeArea: false,
        body: Stack(
          children: [
            AnimatedDoubleCircle(isBigger: image != null),
            Column(
              children: [
                SimpleLogoAppBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: p16),
                  child: MyInput(controller: nameController, hintText: "Nazwa linii"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: p16),
                  child: MultilineInput(controller: descriptionController, hintText: "Opis problemu"),
                ),
                Expanded(
                  child: ReportScheduleViewContent(
                    image: image,
                    imagePicker: imagePicker,
                    onFormSubmit: () {
                      if (key.value.currentState?.saveAndValidate() ?? false) {
                        toastification.show(
                          type: ToastificationType.success,
                          style: ToastificationStyle.flat,
                          title: const Text("Zgłoszenie wysłane pomyślnie"),
                          autoCloseDuration: const Duration(seconds: 3),
                          alignment: Alignment.topCenter,
                        );
                        context.router.pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReportScheduleViewContent extends StatelessWidget {
  const ReportScheduleViewContent({
    super.key,
    required this.image,
    required this.imagePicker,
    required this.onFormSubmit,
  });

  final XFile? image;
  final ImagePickerController imagePicker;
  final VoidCallback onFormSubmit;

  @override
  Widget build(BuildContext context) {
    final isBigger = image != null;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (image == null)
          Positioned(
            left: 25,
            top: 55,
            right: 27,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: isBigger ? "Zgłoś problem z rozkładem jazdy\n" : "Zgłoś problem z rozkładem jazdy\n",
                    style: context.textTheme.headlineSmall?.white.bold,
                  ),
                  if (!isBigger)
                    TextSpan(
                      text: "Pomóż nam ulepszyć rozkłady jazdy. Zgłoś nieprawidłowości lub propozycje zmian.",
                      style: context.textTheme.titleMedium?.w400.withColor(const Color(0xFFD4D2CC)),
                    ),
                ],
              ),
            ),
          ),

        if (image != null)
          Positioned(
            left: 25,
            right: 25,
            top: 30,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(r18),
                image: DecorationImage(image: FileImage(File(image!.path)), fit: BoxFit.cover),
              ),
            ),
          ),

        // Image picker buttons
        if (image == null)
          Positioned(
            left: 25,
            right: 25,
            bottom: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.icon(
                  onPressed: () => imagePicker.pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Zrób zdjęcie"),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(p16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r18)),

                    textStyle: GoogleFonts.bricolageGrotesque(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.64,
                      color: const Color(0xFFF8F7F7),
                    ),
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    foregroundColor: const Color(0xFF3156EE),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
                const SizedBox(height: p12),
                FilledButton.icon(
                  onPressed: () => imagePicker.pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Wybierz zdjęcie"),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(p16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r18)),

                    textStyle: GoogleFonts.bricolageGrotesque(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.64,
                      color: const Color(0xFFF8F7F7),
                    ),
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    foregroundColor: const Color(0xFF3156EE),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
              ],
            ),
          ),

        // Submit button
        Positioned(
          bottom: 110,
          left: 25,
          right: 25,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isBigger
                ? FilledButton(
                    onPressed: onFormSubmit,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF3156EE),
                      foregroundColor: const Color(0xFFF8F7F7),
                      padding: const EdgeInsets.all(p16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r18)),
                      minimumSize: const Size(370, 48), // 370px width as specified
                      textStyle: GoogleFonts.bricolageGrotesque(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.64,
                        color: const Color(0xFFF8F7F7),
                      ),
                    ),
                    child: const Text("WYŚLIJ ZGŁOSZENIE"),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
