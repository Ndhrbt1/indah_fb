import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indah_fb/ui_screens/admin/admin_detail.dart';
import 'package:indah_fb/ui_screens/admin/admin_input.dart';
import 'package:indah_fb/ui_screens/admin/ctrl.dart';
import 'package:indah_fb/ui_screens/login/login.dart';

import 'data.dart';

class AdminList extends StatefulWidget {
  const AdminList({super.key});

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  @override
  void initState() {
    addColToUserList();
    super.initState();
  }

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
                MaterialPageRoute(builder: (context) => const AdminInput()),
              );
            },
            child: const Icon(Icons.add),
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
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    "Logout",
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.currentUser!.delete();
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
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
            if (productList.isEmpty) {
              return const Center(
                child: Text('Data is empty'),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    productList.length,
                    (index) {
                      return Card(
                        child: ListTile(
                          title: Text(productList[index].name),
                          subtitle: Text(productList[index].id),
                          leading: SizedBox(
                            child: productList[index].imageUrl.isEmpty
                                ? const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Text('No Image'),
                                  )
                                : SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(productList[index].imageUrl),
                                  ),
                          ),
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
                  const SizedBox(height: 10),
                  isEnd
                      ? const Center(child: Text('end of list'))
                      : snapshot.connectionState == ConnectionState.waiting
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  addColToUserList();
                                });
                              },
                              child: const Text('loadmore'),
                            ),
                ],
              ),
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
