import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indah_fb/models/product.dart';
import 'package:indah_fb/ui_screens/admin/ctrl.dart';

import 'data.dart';

class AdminEdit extends StatefulWidget {
  const AdminEdit({super.key, required this.id});
  final String id;

  @override
  State<AdminEdit> createState() => _AdminEditState();
}

class _AdminEditState extends State<AdminEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Edit'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getDetail(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // final ctrl1e = TextEditingController(text: snapshot.data?.name);
              // final ctrl2e = TextEditingController(text: snapshot.data?.price.toString());
              // final ctrl3e = TextEditingController(text: snapshot.data?.description);
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    pickedImage == null
                        ? Container(
                            decoration: const BoxDecoration(
                              color: Colors.white10,
                            ),
                            height: 200,
                            width: 200,
                            child: Image.network(snapshot.data!.imageUrl),
                          )
                        : SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(pickedImage!.path),
                          ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                        setState(() {});
                      },
                      child: const Text(
                        "edit image",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ctrl1e,
                      onChanged: (value) {
                        setState(() {
                          isShowClear1e = value.isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Edit Product Name',
                        suffixIcon: isShowClear1e
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  ctrl1.clear();
                                  setState(() {
                                    isShowClear1e = false;
                                  });
                                },
                              )
                            : null,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ctrl2e,
                      onChanged: (value) {
                        setState(() {
                          isShowClear2e = value.isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Edit Price',
                        suffixIcon: isShowClear2e
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  ctrl1.clear();
                                  setState(() {
                                    isShowClear2e = false;
                                  });
                                },
                              )
                            : null,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ctrl3e,
                      onChanged: (value) {
                        setState(() {
                          isShowClear3e = value.isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Edit Description',
                        suffixIcon: isShowClear3e
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  ctrl1.clear();
                                  setState(() {
                                    isShowClear3e = false;
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
                        final valName = ctrl1e.text.isEmpty ? snapshot.data!.name : ctrl1e.text;
                        final valDesc = ctrl3e.text.isEmpty ? snapshot.data!.description : ctrl3e.text;
                        final valPrice = ctrl2e.text.isEmpty ? snapshot.data!.price : int.parse(ctrl2e.text);
                        final id = snapshot.data!.id;
                        final createdAt = snapshot.data!.createdAt;

                        final editProduct = Product(
                          name: valName,
                          price: valPrice,
                          description: valDesc,
                          id: id,
                          createdAt: createdAt,
                          imageUrl: pickedImage == null ? snapshot.data!.imageUrl : await uploadImage(),
                        );
                        setState(() {
                          isLoading = true;
                        });
                        await editDoc(editProduct);
                        setState(() {
                          isLoading = false;
                        });
                        ctrl1.clear();
                        ctrl2.clear();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);

                        setState(() {});
                      },
                      child: Text(isLoading ? 'loading...' : 'submit'),
                    ),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
