import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indah_fb/models/product.dart';
import 'package:indah_fb/ui_screens/admin/data.dart';

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
  await FirebaseFirestore.instance.collection('product').doc(docId).set(
    {
      'name': nama,
      'id': docId,
      'created_at': createdAt,
    },
  );
  await FirebaseFirestore.instance.collection('productDetail').doc(docId).set(data.toMap());
  productList.insert(0, data);
}

Future<Product> getDetail(String id) async {
  final result = await FirebaseFirestore.instance.collection('productDetail').doc(id).get();
  final detail = Product.fromMap(result.data() ?? {});
  return detail;
}
