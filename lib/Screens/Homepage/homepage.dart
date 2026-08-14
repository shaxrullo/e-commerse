import 'package:dio/dio.dart';
import 'package:e_commerce/Model/category.dart';
import 'package:e_commerce/Model/product.dart';
import 'package:e_commerce/Screens/Cart/cart.dart';
import 'package:e_commerce/Screens/Details/details.dart';
import 'package:e_commerce/Services/Constlar/apikeys.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Product> products = [];
  List<Category> categories = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
    getCategory();
  }

  Future<void> getProducts() async {
    final response = await Dio().get(
      "https://ecommercev01.pythonanywhere.com/product/list/",
      options: Options(
        headers: {"Authorization": "Bearer ${apiService.accessToken}"},
      ),
    );

    products = (response.data as List).map((e) => Product.fromJson(e)).toList();
    setState(() {});
  }

  Future<void> getCategory() async {
    final response = await Dio().get(
      "https://ecommercev01.pythonanywhere.com/product/categories/",
      options: Options(
        headers: {"Authorization": "Bearer ${apiService.accessToken}"},
      ),
    );

    categories = (response.data as List)
        .map((e) => Category.fromJson(e))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text("Maxsulotlar"),
          bottom: TabBar(
            tabs: [for (Category title in categories) Tab(text: title.title)],
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              ),
              icon: Icon(Icons.shopping_bag),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            for (final category in categories)
              CustomScrollView(
                slivers: [
                  SliverGrid.builder(
                    itemCount: products
                        .where((e) => e.category.id == category.id)
                        .length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.77,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final filteredProducts = products
                          .where((e) => e.category.id == category.id)
                          .toList();

                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Details(id: product.id),
                            ),
                          );
                          print(product.id);
                        },
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    width: double.infinity,
                                    height: 120,
                                    "https://img.magnific.com/free-photo/nature-landscape-with-hand-holding-frame_23-2149389976.jpg",
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    color: const Color.fromARGB(
                                      255,
                                      114,
                                      99,
                                      99,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: .spaceBetween,
                                            children: [
                                              Text(
                                                product.title.length > 10
                                                    ? "${product.title.substring(0, 10)}..."
                                                    : product.title,

                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                      fontSize: 16,
                                                      fontWeight: .w600,
                                                    ),
                                              ),
                                              Text(
                                                "🌟${product.stars}",
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                      fontSize: 16,
                                                      fontWeight: .w700,
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            248,
                                                            191,
                                                            116,
                                                          ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          Column(
                                            crossAxisAlignment: .start,
                                            children: [
                                              Text(
                                                "\$${product.price}",
                                                style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "\$${product.discountPrice}",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              minimumSize: Size(
                                                double.infinity,
                                                50,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: Text(
                                              "Savatga",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                    fontWeight: .w500,
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
