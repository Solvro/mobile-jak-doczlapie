import 'package:flutter/material.dart';
import 'package:jak_doczlapie/common/widgets/app_bar.dart';
import 'package:jak_doczlapie/features/home/data/stop.dart';

class StopDetailsView extends StatelessWidget {
  const StopDetailsView({super.key, required this.stop});

  final Stop stop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: stop.name));
  }
}
