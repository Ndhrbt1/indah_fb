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
        actions: [
          IconButton(
            onPressed: () async {
              await deleteDoc(id);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: getDetail(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.network(snapshot.data!.imageUrl),
                  ),
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
