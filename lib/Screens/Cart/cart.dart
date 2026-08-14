import 'package:dio/dio.dart';
import 'package:e_commerce/Model/cartItem.dart';
import 'package:e_commerce/Model/cartResponse.dart';
import 'package:e_commerce/Screens/Checkout/checkOut.dart';
import 'package:e_commerce/Services/Constlar/apikeys.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartItem> orderProduct = [];
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    getOrder();
  }

  Future<void> getOrder() async {
    final response = await Dio().get(
      "https://ecommercev01.pythonanywhere.com/order/cart-items/",
      options: Options(
        headers: {"Authorization": "Bearer ${apiService.accessToken}"},
      ),
    );

    final cart = CartResponse.fromJson(response.data);
    orderProduct = cart.cartItems;
    totalPrice = cart.totalPrice;
    setState(() {});
  }

  Future<void> deleteAllOrders() async {
    try {
      // Barcha elementlarni bir vaqtda o'chirish so'rovlari
      await Future.wait(
        orderProduct.map(
          (item) => Dio().delete(
            "https://ecommercev01.pythonanywhere.com/order/remove-from-cart",
            queryParameters: {"cart_item_id": item.id},
            options: Options(
              headers: {"Authorization": "Bearer ${apiService.accessToken}"},
            ),
          ),
        ),
      );

      orderProduct.clear();
      totalPrice = 0;
      setState(() {});
    } on DioException catch (e) {
      print("Xato: ${e.response?.data}");
    }
  }

  Future<void> deleteOrder(int cartItemId) async {
    print("O'chirilayotgan ID: $cartItemId");

    try {
      final response = await Dio().delete(
        "https://ecommercev01.pythonanywhere.com/order/remove-from-cart",
        queryParameters: {"cart_item_id": cartItemId},
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );

      print("Muvaffaqiyatli: ${response.data}");

      orderProduct.removeWhere((item) => item.id == cartItemId);
      setState(() {});
    } on DioException catch (e) {
      print("Xato status: ${e.response?.statusCode}");
      print("Xato ma'lumot: ${e.response?.data}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My cart",
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              deleteAllOrders();
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: orderProduct.length,
            itemBuilder: (context, index) {
              final product = orderProduct[index];
              final mainPicture = product.pictures.isNotEmpty
                  ? product.pictures.first.file
                  : null;

              return Container(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 10,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.orangeAccent, width: 1),
                ),
                child: Stack(
                  clipBehavior: .none,
                  children: [
                    ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: mainPicture != null
                            ? Image.network(
                                "https://ecommercev01.pythonanywhere.com$mainPicture",
                                width: 70,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(width: 70),
                      ),
                      title: Text(
                        product.title,
                        maxLines: 2,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        product.properties
                            .map((p) => "${p.key}: ${p.value}")
                            .join(", "),
                        style: GoogleFonts.plusJakartaSans(fontSize: 13),
                      ),
                      trailing: Text(
                        "${product.subtotal.toStringAsFixed(0)} so'm",
                      ),
                    ),
                    Positioned(
                      right: -12,
                      top: -12,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: Colors.orangeAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            deleteOrder(product.id);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 60),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.green
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Checkout(cartItems: [], totalPrice: totalPrice),
                  ),
                ),
                child: Text(
                  "Buyurtma berish",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
