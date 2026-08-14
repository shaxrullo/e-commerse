import 'package:dio/dio.dart';
import 'package:e_commerce/Model/productDetail.dart';
import 'package:e_commerce/Services/Constlar/apikeys.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final int id;
  Details({super.key, required this.id});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedColor = 0;
  int selectedSize = 0;

  @override
  void initState() {
    super.initState();
    getProductDetail();
  }

  ProductDetail? productDetail;

  Future<void> addToCart(
    int productId,
    int quantity,
    Map<String, String> properties,
  ) async {
    try {
      final response = await Dio().post(
        "https://ecommercev01.pythonanywhere.com/order/add-to-cart/",
        data: {
          "product_id": productId,
          "quantity": quantity,
          "properties":
              properties, // masalan: {"Rang": "Qora", "O'lcham": "42"}
        },
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );
      print(response.data);
    } on DioException catch (e) {
      print(e.response?.data);
    }
  }

  Future<void> getProductDetail() async {
    final response = await Dio().get(
      "https://ecommercev01.pythonanywhere.com/product/detail/",
      queryParameters: {"product_id": widget.id},
      options: Options(
        headers: {"Authorization": "Bearer ${apiService.accessToken}"},
      ),
    );

    productDetail = ProductDetail.fromJson(response.data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (productDetail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final product = productDetail!;

    final colors = List<String>.from(product.properties["color"] ?? []);

    final sizes = List<String>.from(product.properties["size"] ?? []);
    final images = product.pictures;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: images.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      PageView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            "https://ecommercev01.pythonanywhere.com${images[index].file}",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        top: 40,
                        left: 12,
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Text(
                      "${product.title}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text(
                          "${product.stars}",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " (${product.reviewQuantity} ta sharh)",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${product.quantity} dona",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    if (product.discountPercent != null)
                      Text(
                        "${product.price} so'm",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    Text(
                      "🔥${product.discountPrice} so'm",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "Ranglar",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: List.generate(colors.length, (i) {
                        final isSelected = selectedColor == i;
                        return GestureDetector(
                          onTap: () => setState(() {
                            selectedColor = i;
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Colors.orangeAccent
                                    : Colors.grey.shade300,
                                width: isSelected ? 3 : 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(colors[i]),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "O'lcham",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: List.generate(sizes.length, (i) {
                        final isSelected = selectedSize == i;
                        return GestureDetector(
                          onTap: () => setState(() {
                            selectedSize = i;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            width: 45,
                            height: 40,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.orangeAccent
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.orangeAccent
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(sizes[i]),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "Tavsif",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Yuvish va ishlatish paytida narsalar cho'zilmaydi, deformatsiyalanmaydi, ulardagi tikuvlar siljimaydi\n"
                      "Tasodifiy uslub\n"
                      "Siz chiroyli va zamonaviy ko'rinasiz\n"
                      "O'zbekiston bo'ylab bepul yetkazib berish.\n"
                      "Agar mahsulot sizga mos kelmasa, pulni qaytarib berishni kafolatlaymiz.\n"
                      "Shimlarning qulay joylashishi. Konfor va harakat erkinligi. Kichik narsalarni qulay saqlash uchun yon cho'ntaklar.\n"
                      "MUHIM!!!!! USHBU KARTA FAQAT SHIM, T-SHIRT YOKI TO'LIQ SET BOShQA KARTALARDA SOTILADI",
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          final Map<String, String> properties = {};

                          if (colors.isNotEmpty) {
                            properties["color"] = colors[selectedColor];
                          }
                          if (sizes.isNotEmpty) {
                            properties["size"] = sizes[selectedSize];
                          }
                          
                          addToCart(widget.id, 1, properties);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Savatchaga qo'shish",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
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
    );
  }
}
