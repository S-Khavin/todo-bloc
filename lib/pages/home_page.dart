import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/todo_page.dart';
import 'package:todo/provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Consumer(
          builder: (context, watch, _) {
            final completedCount = ref.watch(completedCountProvider);
            final notCompletedCount = ref.watch(notCompletedCountProvider);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoPage(),
                          ),
                        ),
                    child: Text("Todo Count : $notCompletedCount")),
                ElevatedButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoPage(),
                          ),
                        ),
                    child: Text("Completed Count : $completedCount")),
              ],
            );
          },
        ),
      ),
    );
  }
}
