import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_assignments/providers/item_list_provider.dart';
import 'package:test_assignments/screens/item_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemListProvider(),
      child: MaterialApp(
        title: 'Item List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ItemListScreen(),
      ),
    );
  }
}