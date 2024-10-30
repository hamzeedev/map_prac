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
                      ? const Center( child: CircularProgressIndicator(),)
                      :  controller.productsList.isNotEmpty //!without model //controller.products.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (_, index) {
                                //! without model - below one..
                                // var item = controller.products[index];
                                //? with model - below one..
                                 var item = controller.productsList[index];

                                return ListTile(
                                  //! without model - below one..
                                  // title: Text(item['name']),
                                  // subtitle: Text(item['brand']),
                                  // trailing: Text(item['price'].toString()),
                                  // leading: Container(
                                  //   height: 50,
                                  //   width: 50,
                                  //   decoration: const BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //   ),
                                  //   child: Image.network(
                                  //     item['image_link'],
                                  //     fit: BoxFit.cover,
                                  //     errorBuilder: (_, __, ___) {
                                  //       return Image.asset(
                                  //           "assets/images/place.png");
                                  //     },
                                  //   ),
                                  // ),
                                  //? with model
                                  title:    Text(item.name),
                                  subtitle: Text(item.brand),
                                  trailing: Text(item.price.toString()),
                                  leading:  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(shape: BoxShape.circle,),
                                    child: Image.network(
                                      item.thumbnail,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) {
                                        return Image.asset("assets/images/place.png");},
                                    ),
                                  ),
                                );
                              },
                              itemCount: controller.productsList.length,
                            )
                          : const Center(child: Text("No Products found"),);
                },
              ),
              MyTextField(
                hint: 'Brand',
                onFieldSubmitted: (brand) {
                  controller.fetchAllProducts({"brand": brand});
                },).marginAll(10)
            ],
          ),
        ),
      ),
    );
  }
}
