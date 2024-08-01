import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_jwt/models/user.dart';
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
        User user = controller.listUser[index];
        return _buildDataRow(user);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 5,
        );
      },
      itemCount: controller.listUser.length,
    );
  }

  Widget _buildDataRow(User user) {
    return ListTile(
      title: Text(user.userName),
      subtitle: Text(user.password.toString()),
    );
  }
}
