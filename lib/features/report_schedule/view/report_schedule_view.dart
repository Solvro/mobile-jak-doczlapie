import "dart:io";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:form_builder_validators/form_builder_validators.dart";
import "package:image_picker/image_picker.dart";

import "../../../common/widgets/app_bars/app_bar.dart";
import "../hooks/use_image_picker.dart";

class ReportScheduleView extends HookWidget {
  const ReportScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePicker = useImagePicker();
    final image = imagePicker.image.value;
    final key = useRef(GlobalKey<FormBuilderState>());

    return FormBuilder(
      key: key.value,
      child: Scaffold(
        appBar: const CommonAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              FormBuilderTextField(
                name: "name",
                decoration: const InputDecoration(labelText: "Nazwa linii"),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                minLines: 4,
                maxLines: 7,
                name: "description",
                decoration: const InputDecoration(labelText: "Opis"),
                validator: FormBuilderValidators.required(),
              ),

              if (image != null) Image.file(File(image.path), height: 200, fit: BoxFit.cover),
              if (image == null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => imagePicker.pickImage(ImageSource.camera),
                      child: const Text("Zrób zdjęcie"),
                    ),
                    ElevatedButton(
                      onPressed: () => imagePicker.pickImage(ImageSource.gallery),
                      child: const Text("Wybierz zdjęcie"),
                    ),
                  ],
                ),

              ElevatedButton(
                onPressed: () {
                  if (key.value.currentState?.saveAndValidate() ?? false) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("Zgłoszenie wysłane pomyślnie")));
                    context.router.pop();
                  }
                },
                child: const Text("Wyślij zgłoszenie"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
