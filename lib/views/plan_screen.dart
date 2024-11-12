import 'package:flutter/material.dart';
import 'package:master_plan/models/task.dart'; // Pastikan path sesuai
import 'package:master_plan/provider/plan_provider.dart'; // Pastikan path sesuai
import 'package:master_plan/models/data_layer.dart'; // Pastikan path sesuai

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengakses Plan dari PlanProvider menggunakan PlanProvider.of
    final planNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arlafelda Meindra Widayat'),
      ),
      body: ValueListenableBuilder<Plan>(
        valueListenable: planNotifier, // Mendengarkan perubahan pada Plan
        builder: (context, plan, child) {
          return Column(
            children: [
              // Daftar tugas yang dapat di-scroll
              Expanded(
                child: _buildList(plan, context), // Membuat daftar tugas dengan ruang sisa
              ),
              // Progress bar di bagian bawah
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LinearProgressIndicator(
                  value: plan.completedCount / plan.tasks.length,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              // SafeArea untuk menampilkan completenessMessage
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    plan.completenessMessage, // Pesan kelengkapan tugas
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  // Method untuk membuat tombol tambah tugas
  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<Plan> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final newTask = Task(description: "New Task", complete: false);
        Plan currentPlan = planNotifier.value;
        planNotifier.value = Plan(
          name: currentPlan.name,
          tasks: List.from(currentPlan.tasks)..add(newTask),
        );
      },
    );
  }

  // Method untuk membuat daftar tugas
  Widget _buildList(Plan plan, BuildContext context) {
    return ListView.builder(
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) {
        return _buildTaskTile(plan.tasks[index], index, context); // Memperbaiki pemanggilan _buildTaskTile
      },
    );
  }

  // Method untuk membuat tampilan tiap task dalam list
  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    // Mengakses ValueNotifier<Plan> dari PlanProvider menggunakan BuildContext
    ValueNotifier<Plan> planNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          // Mengambil nilai currentPlan dari planNotifier
          Plan currentPlan = planNotifier.value;

          // Memperbarui tasks setelah status checkbox berubah
          planNotifier.value = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)
              ..[index] = Task(
                description: task.description,
                complete: selected ?? false,
              ),
          );
        },
      ),
      title: TextFormField(
        initialValue: task.description,  // Menampilkan nilai awal task.description
        onChanged: (text) {
          // Ketika deskripsi task diubah, perbarui task tersebut
          Plan currentPlan = planNotifier.value;

          // Memperbarui planNotifier dengan deskripsi task yang baru
          planNotifier.value = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)
              ..[index] = Task(
                description: text,  // Deskripsi task yang diperbarui
                complete: task.complete,
              ),
          );
        },
      ),
    );
  }
}
