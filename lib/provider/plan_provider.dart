import 'package:flutter/material.dart';
import '../models/data_layer.dart'; 

class PlanProvider extends InheritedNotifier<ValueNotifier<Plan>> {
  const PlanProvider({
    super.key,
    required Widget child,
    required ValueNotifier<Plan> notifier,
  }) : super(child: child, notifier: notifier);

  static ValueNotifier<Plan> of(BuildContext context) {
    // Mengambil ValueNotifier<Plan> dari widget InheritedNotifier terdekat
    return context.dependOnInheritedWidgetOfExactType<PlanProvider>()!.notifier!;
  }
}
