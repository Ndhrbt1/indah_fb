import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:indah_fb/models/product.dart';

import 'data.dart';

Future<List<Product>> getCol() async {
  List<Product> products = [];
  final result = await FirebaseFirestore.instance
      .collection('product')
      .orderBy('created_at', descending: true)
      .limit(3)
      .startAfter(
    [productList.isEmpty ? '9999-99-9' : productList.last.createdAt],
  ).get();
  for (var element in result.docs) {
    products.add(Product.fromMap(element.data()));
  }
  return products;
}

addColToUserList() async {
  final dataCol = await getCol();
  productList.addAll(dataCol);
  if (dataCol.length < 3) {
    isEnd = true;
  }
}

Future<void> createDoc(Product data) async {
  final docId = data.id;
  final nama = data.name;
  final createdAt = data.createdAt;
  final imageUrl = data.imageUrl;
  final price = data.price;
  await FirebaseFirestore.instance.collection('product').doc(docId).set(
    {
      'name': nama,
      'id': docId,
      'created_at': createdAt,
      'image_url': imageUrl,
      'price': price,
    },
  );
  await FirebaseFirestore.instance.collection('productDetail').doc(docId).set(data.toMap());
  productList.insert(0, data);
}

Future<void> editDoc(Product editData) async {
  final docId = editData.id;
  final nama = editData.name;
  final createdAt = editData.createdAt;
  final imageUrl = editData.imageUrl;
  final price = editData.price;

  await FirebaseFirestore.instance.collection('product').doc(docId).set(
    {
      'name': nama,
      'id': docId,
      'created_at': createdAt,
      'image_url': imageUrl,
      'price': price,
    },
  );
  await FirebaseFirestore.instance.collection('productDetail').doc(docId).set(editData.toMap());
  final index = productList.indexWhere((element) => element.id == docId);
  productList[index] = editData;
}

Future<Product> getDetail(String id) async {
  final result = await FirebaseFirestore.instance.collection('productDetail').doc(id).get();
  final detail = Product.fromMap(result.data() ?? {});
  selectedProduct = detail;

  return detail;
}

Future<void> deleteDoc(String docId) async {
  await FirebaseFirestore.instance.collection('product').doc(docId).delete();
  await FirebaseFirestore.instance.collection('productDetail').doc(docId).delete();

  final index = productList.indexWhere((element) => element.id == docId);
  productList.removeAt(index);
}

// * storage
Future<String> uploadImage() async {
  final imageName = pickedImage!.name;
  final imageType = pickedImage!.mimeType;
  final imageId = UniqueKey().toString();
  final imageBytes = await pickedImage!.readAsBytes();
  final task = await FirebaseStorage.instance.ref('$imageId $imageName').putData(
        imageBytes,
        SettableMetadata(contentType: imageType),
      );
  imageUrltoS = await task.ref.getDownloadURL();
  return imageUrltoS;
}

Future<String> editImage() async {
  editPickedImage = pickedImage;
  final imageName = editPickedImage!.name;
  final imageType = editPickedImage!.mimeType;
  final imageId = UniqueKey().toString();
  final imageBytes = await editPickedImage!.readAsBytes();
  final task = await FirebaseStorage.instance.ref('$imageId $imageName').putData(
        imageBytes,
        SettableMetadata(contentType: imageType),
      );
  imageUrltoS = await task.ref.getDownloadURL();
  return imageUrltoS;
}
