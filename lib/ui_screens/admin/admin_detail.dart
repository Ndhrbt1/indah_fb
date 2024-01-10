import 'package:flutter/material.dart';
import 'package:indah_fb/ui_screens/admin/ctrl.dart';

class AdminDetail extends StatelessWidget {
  const AdminDetail({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Detail'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getDetail(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data!.id),
                  Text(snapshot.data!.name),
                  Text("Rp: ${snapshot.data!.price}"),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
