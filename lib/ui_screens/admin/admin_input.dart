import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indah_fb/models/product.dart';

import '../../dt_sources/ctrl.dart';
import '../../dt_sources/data.dart';

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
            pickedImage == null
                ? Card(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white10,
                      ),
                      height: 100,
                      width: 100,
                      child: const Center(child: Text('No Image')),
                    ),
                  )
                : SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      pickedImage!.path,
                    ),
                  ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                setState(() {});
              },
              child: const Text(
                "pick image from galery",
              ),
            ),
            const SizedBox(height: 20),
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
            ElevatedButton(
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
                  imageUrl: await uploadImage(),
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
