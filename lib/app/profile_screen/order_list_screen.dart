import 'package:air_menu_ai_app/app/profile_screen/order_detail_screen.dart';
import 'package:air_menu_ai_app/controllers/home_controller.dart';
import 'package:air_menu_ai_app/models/order_list_model.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final HomeController homeController = Get.find();

  @override
  void initState() {
    homeController.getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeChange.getThem()
              ? AppThemeData.surfaceDark
              : AppThemeData.surface,
      appBar: AppBar(
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
        title: Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () =>
            homeController.isOrderList.value
                ? _buildShimmerList(isDarkMode)
                : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: homeController.orderList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(OrderDetailPage());
                      },
                      child: OrderCard(order: homeController.orderList[index]),
                    );
                  },
                ),
      ),
    );
  }

  Widget _buildShimmerList(bool isDarkMode) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Shimmer.fromColors(
            baseColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            highlightColor:
                isDarkMode ? Colors.grey.shade600 : Colors.grey.shade100,
            child: Card(
              color:
                  themeChange.getThem()
                      ? AppThemeData.grey900
                      : AppThemeData.grey50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      color:
                          isDarkMode
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 12,
                            width: 120,
                            color:
                                isDarkMode
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade300,
                          ),
                          SizedBox(height: 6),
                          Container(
                            height: 10,
                            width: 80,
                            color:
                                isDarkMode
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade300,
                          ),
                          SizedBox(height: 6),
                          Container(
                            height: 14,
                            width: 60,
                            color:
                                isDarkMode
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final Data order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Card(
      color: themeChange.getThem() ? AppThemeData.grey900 : AppThemeData.grey50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID: ${order.sId?.substring(0, 10)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(
                    order.status ?? "Pending",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getStatusColor(order.status),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (order.items != null && order.items!.isNotEmpty)
              SizedBox(
                height:
                    60 * double.parse((order.items?.length.toString() ?? "0")),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: order.items?.length ?? 0,
                  itemBuilder: (context, index1) {
                    return _buildItemRow(order.items![index1]);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ₹${order.totalAmount}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.createdAt ?? '',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(Items item) {
    return Row(
      children: [
        if (item.product?.image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.product!.image!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.product?.name ?? "Unknown Product",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              "Qty: ${item.quantity} | Size: ${item.size ?? 'N/A'}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
