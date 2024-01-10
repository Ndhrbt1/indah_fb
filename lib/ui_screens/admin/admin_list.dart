import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indah_fb/ui_screens/admin/admin_detail.dart';
import 'package:indah_fb/ui_screens/admin/admin_input.dart';
import 'package:indah_fb/ui_screens/admin/ctrl.dart';

import 'data.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  void initState() {
    addColToUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminInput()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Admin Page'),
        actions: [
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    "Logout",
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.currentUser!.delete();
                  },
                  child: const Text(
                    "Delete Account",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCol(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                ...List.generate(
                  productList.length,
                  (index) {
                    return Card(
                      child: ListTile(
                        title: Text(productList[index].name),
                        subtitle: Text(productList[index].id),
                        onTap: () {
                          setState(() {
                            selectedId = productList[index].id;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminDetail(id: productList[index].id)),
                          );
                        },
                      ),
                    );
                  },
                ),
                isEnd
                    ? const Text('end of list')
                    : snapshot.connectionState == ConnectionState.waiting
                        ? const CircularProgressIndicator()
                        : OutlinedButton(
                            onPressed: () {
                              setState(() {
                                addColToUserList();
                              });
                            },
                            child: const Text('loadmore'),
                          ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
