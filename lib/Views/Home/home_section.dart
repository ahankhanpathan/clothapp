import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controllers/home_controller.dart';
import '/Models/product.dart';

class HomeSection extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CategorySelectionWidget(),
          Obx(() {
            if (Get.find<HomeController>().isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (Get.find<HomeController>().productList.isEmpty) {
              return Center(child: Text('No products found'));
            } else {
              return ProductListWidget();
            }
          }),
        ],
      ),
    );
  }
}

class CategorySelectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoryItem(title: "Electronics", category: "electronics"),
          CategoryItem(title: "Jewelry", category: "jewelery"),
          CategoryItem(title: "Men's clothing", category: "men's clothing"),
          CategoryItem(title: "Women's clothing", category: "women's clothing"),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String category;

  CategoryItem({required this.title, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<HomeController>().selectedCategory.value = category;
        Get.find<HomeController>().fetchProductsByCategory(category);
      },
      child: Obx(() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.find<HomeController>().selectedCategory.value == category
                ? Colors.blue
                : Colors.white,
            border: Border.all(
              color: Get.find<HomeController>().selectedCategory.value == category
                  ? Colors.blueAccent
                  : Colors.grey,
            ),
          ),
          child: Row(
            children: [
              Get.find<HomeController>().selectedCategory.value == category
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  : const SizedBox(),
              SizedBox(
                  width: Get.find<HomeController>().selectedCategory.value == category
                      ? 5
                      : 0),
              Text(
                title,
                style: TextStyle(
                  color: Get.find<HomeController>().selectedCategory.value == category
                      ? Colors.white
                      : Colors.grey,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: controller.productList.length,
        itemBuilder: (context, index) {
          Product product = controller.productList[index];
          return Card(
            color: Colors.white,
            shadowColor: Colors.amberAccent,
            margin: const EdgeInsets.all(7),
            child: ListTile(
              leading: Image.network(
                product.image!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product.title!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${product.price!.toStringAsFixed(2)}'),
                  Text(
                    'Rating: ${product.rating!.rate} (${product.rating!.count} reviews)',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              onTap: () {
                Get.toNamed('/itemDetails', arguments: product);
              },
            ),
          );
        },
      ),
    );
  }
}
