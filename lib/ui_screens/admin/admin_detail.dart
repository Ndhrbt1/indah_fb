import 'package:flutter/material.dart';
import 'package:indah_fb/ui_screens/admin/admin_edit.dart';

import '../../dt_sources/ctrl.dart';

class AdminDetail extends StatefulWidget {
  const AdminDetail({super.key, required this.id});
  final String id;

  @override
  State<AdminDetail> createState() => _AdminDetailState();
}

class _AdminDetailState extends State<AdminDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminEdit(id: widget.id)),
              );
            },
            child: const Icon(Icons.edit),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            child: const Icon(Icons.loop),
          ),
          const SizedBox(width: 10),
        ],
      ),
      appBar: AppBar(
        title: const Text('Admin Detail'),
        actions: [
          IconButton(
            onPressed: () async {
              await deleteDoc(widget.id);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: getDetail(widget.id),
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
                  Text(
                    snapshot.data!.description,
                    textAlign: TextAlign.justify,
                  ),
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
