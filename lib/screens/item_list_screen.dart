import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_assignments/models/item.dart';
import 'package:test_assignments/providers/item_list_provider.dart';
import 'package:test_assignments/screens/item_detail_screen.dart';


class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itemListProvider =
          Provider.of<ItemListProvider>(context, listen: false);
      itemListProvider.fetchItems();
    });
  }

  Future<void> _refreshItems() async {
    final itemListProvider =
        Provider.of<ItemListProvider>(context, listen: false);
    await itemListProvider.fetchItems();
  }

  Future<void> _addItem() async {
    final itemListProvider =
        Provider.of<ItemListProvider>(context, listen: false);
    final newItem = Item(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleController.text,
      description: _descriptionController.text,
      imageUrl:
          'https://via.placeholder.com/150', // Replace with your image URL field
    );
    await itemListProvider.addItem(newItem);
    _titleController.clear();
    _descriptionController.clear();
    if (context.mounted) Navigator.of(context).pop();
  }

  Future<void> _deleteItem(Item item) async {
    final itemListProvider =
        Provider.of<ItemListProvider>(context, listen: false);
    await itemListProvider.deleteItem(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Add Item'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _addItem,
                      child: const Text('Add'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<ItemListProvider>(
        builder: (context, itemListProvider, _) {
          if (itemListProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshItems,
            child: ListView.builder(
              itemCount: itemListProvider.items.length,
              itemBuilder: (context, index) {
                final item = itemListProvider.items[index];
                return Dismissible(
                  key: ValueKey(item.id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (_) => _deleteItem(item),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailScreen(item: item),
                        ),
                      );
                    },
                    leading: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(item.title),
                    subtitle: Text(item.description),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
