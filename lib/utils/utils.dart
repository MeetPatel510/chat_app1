import 'package:flutter/material.dart';

snackbar(BuildContext context,String text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}