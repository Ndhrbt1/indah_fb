import 'package:flutter/material.dart';
import 'package:indah_fb/models/product.dart';
import 'package:indah_fb/ui_screens/admin/ctrl.dart';

import 'data.dart';

class AdminInput extends StatefulWidget {
  const AdminInput({super.key});

  @override
  State<AdminInput> createState() => _AdminInputState();
}

class _AdminInputState extends State<AdminInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Input'),
      ),
      // ignore: prefer_const_constructors
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: ctrl1,
              onChanged: (value) {
                setState(() {
                  isShowClear1 = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                labelText: 'Product Name',
                suffixIcon: isShowClear1
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ctrl1.clear();
                          setState(() {
                            isShowClear1 = false;
                          });
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ctrl2,
              onChanged: (value) {
                setState(() {
                  isShowClear2 = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                labelText: 'Price',
                suffixIcon: isShowClear2
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ctrl2.clear();
                          setState(() {
                            isShowClear2 = false;
                          });
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ctrl3,
              onChanged: (value) {
                setState(() {
                  isShowClear3 = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                labelText: 'Description',
                suffixIcon: isShowClear3
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ctrl2.clear();
                          setState(() {
                            isShowClear3 = false;
                          });
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () async {
                final valName = ctrl1.text;
                final valDesc = ctrl3.text;
                final valPrice = int.parse(ctrl2.text);
                final id = UniqueKey().toString();
                final createdAt = DateTime.now().toString();

                final inputProduct = Product(
                  name: valName,
                  price: valPrice,
                  description: valDesc,
                  id: id,
                  createdAt: createdAt,
                );

                setState(() {
                  isLoading = true;
                });
                await createDoc(inputProduct);
                setState(() {
                  isLoading = false;
                });
                ctrl1.clear();
                ctrl2.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: Text(isLoading ? 'loading...' : 'submit'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
