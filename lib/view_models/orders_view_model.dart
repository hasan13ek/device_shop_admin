import 'dart:async';

import 'package:device_shop_admin/data/models/order_model.dart';
import 'package:device_shop_admin/data/models/product_model.dart';
import 'package:device_shop_admin/data/repository/orders_repositroy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersViewModel extends ChangeNotifier {
  final OrdersRepository ordersRepository;

  OrdersViewModel({required this.ordersRepository}) {
    listenOrders(FirebaseAuth.instance.currentUser!.uid);
  }

  late StreamSubscription subscription;

  ProductModel? productModel;

  List<OrderModel> userOrders = [];

  listenOrders(String userId) async {
    subscription =
        ordersRepository.getOrdersByUserId(userId: userId).listen((List<OrderModel> orders) {
          userOrders = orders;
          notifyListeners();
        });
  }

  addOrder(OrderModel orderModel) =>
      ordersRepository.addOrder(orderModel: orderModel);

  updateOrderIfExists({
    required String productId,
    required int count,
  }) {
    OrderModel orderModel =
    userOrders.firstWhere((element) => element.productId == productId);

    int currentCount = orderModel.count;

    int price = orderModel.totalPrice ~/ orderModel.count;

    ordersRepository.updateOrder(
      orderModel: orderModel.copWith(
        count: currentCount + count,
        totalPrice: price * (currentCount + count),
      ),
    );
  }

  updateOrder(OrderModel orderModel) =>
      ordersRepository.updateOrder(orderModel: orderModel);

  getSingleProduct(String docId) async {
    productModel = await ordersRepository.getSingleProductById(docId: docId);
    notifyListeners();
  }

  deleteOrder(String docId) => ordersRepository.deleteOrderById(docId: docId);

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}