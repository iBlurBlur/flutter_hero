import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hero/src/models/product.dart';
import 'package:flutter_hero/src/pages/management/widgets/product_form.dart';
import 'package:flutter_hero/src/utils/services/network_service.dart';
import 'package:flutter_hero/src/widgets/custom_flushbar.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final _formKey = GlobalKey<FormState>();
  Product _product = Product();
  bool _editMode = false;
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    // must declare in build
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Product) {
      _editMode = true;
      _product = arguments;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: ProductForm(
            _product,
            callBackSetImage: _callBackSetImage,
            deleteProduct: _editMode ? _deleteProduct : null,
            formKey: _formKey,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        centerTitle: false,
        title: Text('${_editMode ? 'Edit' : 'Add'} Product'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () => _submitForm(),
            child: Text('submit'),
          )
        ],
      );

  void _callBackSetImage(File? imageFile) {
    _imageFile = imageFile;
  }

  void _deleteProduct() {
    NetworkService().deleteProduct(_product.id!).then((result) {
      Navigator.pop(context);
      CustomFlushbar.showSuccess(
        context,
        message: result,
      );
    }).catchError((error) {
      CustomFlushbar.showError(
        context,
        message: error.toString(),
      );
    });
  }

  void _submitForm() async {
    FocusScope.of(context).requestFocus(FocusNode());
    _formKey.currentState!.save();
    try {
      String result;
      if (_editMode) {
        result =
            await NetworkService().editProduct(_product, imageFile: _imageFile);
      } else {
        result =
            await NetworkService().addProduct(_product, imageFile: _imageFile);
      }
      Navigator.pop(context);
      CustomFlushbar.showSuccess(
        context,
        message: result,
      );
    } catch (error) {
      CustomFlushbar.showError(
        context,
        message: error.toString(),
      );
    }
  }
}
