import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:test_jwt/models/book.dart';
import 'package:test_jwt/modules/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Obx(
            (() => _buildListBook()),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            controller.fetchApi();
          },
          icon: const Icon(Icons.near_me),
        ),
      ),
    );
  }

  Widget _buildListBook() {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Book book = controller.listBook[index];
        return _buildDataRow(book);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 5,
        );
      },
      itemCount: controller.listBook.length,
    );
  }

  Widget _buildDataRow(Book book) {
    return ListTile(
      title: Text(book.name),
      subtitle: Text(book.id.toString()),
    );
  }
}
