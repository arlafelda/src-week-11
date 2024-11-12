import 'package:flutter/material.dart'; 
import './models/plan.dart';  
import 'package:master_plan/views/plan_screen.dart';
import 'package:master_plan/provider/plan_provider.dart'; // Import PlanProvider

void main() => runApp(MasterPlanApp()); 

class MasterPlanApp extends StatelessWidget { 
  const MasterPlanApp({super.key}); 

  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      theme: ThemeData(primarySwatch: Colors.purple), 
      home: PlanProvider( 
        notifier: ValueNotifier<Plan>(const Plan()), // Menyediakan Plan dengan ValueNotifier
        child: const PlanScreen(), // PlanScreen akan menerima data melalui PlanProvider
      ),
    ); 
  } 
}
