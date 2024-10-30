import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_prac/controllers/makeup_home_controller.dart';
import 'package:map_prac/widgets/my_textfield.dart';

class MakeupHomeScreen extends StatelessWidget {
  const MakeupHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MakeupHomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Makeup Home Screen"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.fetchAllProducts({}),
          child: Stack(
            children: [
              Obx(
                () {
                  return controller.loading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.products.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (_, index) {
                                var item = controller.products[index];

                                return ListTile(
                                  title: Text(item['name']),
                                  subtitle: Text(item['brand']),
                                  trailing: Text(item['price'].toString()),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      item['image_link'],
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) {
                                        return Image.asset(
                                            "assets/images/place.png");
                                      },
                                    ),
                                  ),
                                );
                              },
                              itemCount: controller.products.length,
                            )
                          : const Center(
                              child: Text("No Products found"),
                            );
                },
              ),
              MyTextField(
                hint: 'Brand',
                onFieldSubmitted: (brand) {
                  controller.fetchAllProducts({"brand": brand});
                },
              ).marginAll(10)
            ],
          ),
        ),
      ),
    );
  }
}
