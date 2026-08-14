import 'package:dio/dio.dart';
import 'package:e_commerce/Model/cartItem.dart';
import 'package:e_commerce/Services/Constlar/apikeys.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalPrice;

  const Checkout({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final formKey = GlobalKey<FormState>();

  final streetController = TextEditingController();
  final apartmentController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final couponController = TextEditingController();

  String paymentType = "cash"; // yoki backend qanday qiymat kutsa

  Future<void> submitOrder() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final response = await Dio().post(
        "https://ecommercev01.pythonanywhere.com/order/create/",
        data: {
          "street_address": streetController.text,
          "apartment": apartmentController.text,
          "city": cityController.text,
          "phone": phoneController.text,
          "email": emailController.text,
          "paying_amount": widget.totalPrice.toString(),
          "payment_type": paymentType,
          "cart_item_ids": widget.cartItems.map((e) => e.id).toList(),
        },
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );

      print(response.data);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Buyurtma qabul qilindi ✅")),
      );
      Navigator.pop(context);
    } on DioException catch (e) {
      print("Xato: ${e.response?.data}");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Buyurtma yuborishda xatolik")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buyurtmani rasmiylashtirish")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(hintText: "Shahar"),
                validator: (v) => v == null || v.isEmpty ? "Majburiy" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: streetController,
                decoration: const InputDecoration(hintText: "Ko'cha manzili"),
                validator: (v) => v == null || v.isEmpty ? "Majburiy" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: apartmentController,
                decoration: const InputDecoration(hintText: "Xonadon (ixtiyoriy)"),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: "Telefon"),
                validator: (v) => v == null || v.isEmpty ? "Majburiy" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: "Email"),
                validator: (v) => v == null || v.isEmpty ? "Majburiy" : null,
              ),
              const SizedBox(height: 20),
              Text("Jami: ${widget.totalPrice.toStringAsFixed(0)} so'm"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitOrder,
                child: const Text("Buyurtmani tasdiqlash"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}