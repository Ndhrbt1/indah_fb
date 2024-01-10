import 'package:flutter/material.dart';
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

var isEnd = false;
