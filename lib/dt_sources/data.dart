import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indah_fb/models/product.dart';

final ctrl1 = TextEditingController();
final ctrl2 = TextEditingController();
final ctrl3 = TextEditingController();
var isLoading = false;
var isShowClear1 = false;
var isShowClear2 = false;
var isShowClear3 = false;
var selectedId = '';
List<Product> productList = [];
Product? selectedProduct;
var isEnd = false;
// * storge
XFile? pickedImage;
XFile? editPickedImage;
var imageUrltoS = '';
var imageFromDetail = '';
// * Edit

final ctrl1e = TextEditingController();
final ctrl2e = TextEditingController();
final ctrl3e = TextEditingController();
var isShowClear1e = false;
var isShowClear2e = false;
var isShowClear3e = false;
