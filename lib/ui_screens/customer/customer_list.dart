import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indah_fb/dt_sources/ctrl.dart';
import 'package:indah_fb/ui_screens/customer/customer_detail.dart';

import '../../dt_sources/data.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  void initState() {
    addColToUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Page'),
        actions: [
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      // ignore: use_build_context_synchronously
                      // Navigator.pop(context);
                    },
                    icon: const Icon(Icons.logout)),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.currentUser!.delete();
                      // ignore: use_build_context_synchronously
                      // Navigator.pop(context);
                    },
                    icon: const Icon(Icons.remove_circle_outline)),
                const SizedBox(width: 10),
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
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        ...List.generate(
                          productList.length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedId = productList[index].id;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CustomerDetail(id: productList[index].id)),
                                );
                              },
                              child: Card(
                                surfaceTintColor: Colors.white,
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Column(
                                    children: [
                                      productList[index].imageUrl.isEmpty
                                          ? const SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: Text('No Image'),
                                            )
                                          : SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                productList[index].imageUrl,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                      Text(
                                        productList[index].name,
                                      ),
                                      Text('Rp: ${productList[index].price.toString()}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        // isEnd
                        //     ? const Center(child: Text('end of list'))
                        //     : snapshot.connectionState == ConnectionState.waiting
                        //         ? const CircularProgressIndicator()
                        //         : ElevatedButton(
                        //             onPressed: () {
                        //               setState(() {
                        //                 addColToUserList();
                        //               });
                        //             },
                        //             child: const Text('loadmore'),
                        //           ),
                      ],
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
