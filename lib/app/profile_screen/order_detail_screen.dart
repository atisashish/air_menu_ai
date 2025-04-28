import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  // Static food order data
  static final Map<String, dynamic> _staticOrder = {
    "sId": "FOOD789456",
    "status": "Delivered",
    "createdAt": "2023-06-20T19:45:00Z",
    "subtotal": 850.00,
    "totalAmount": 1020.00,
    "deliveryCharge": 40.00,
    "packingCharge": 30.00,
    "gstPercentage": 5.0,
    "items": [
      {
        "product": {
          "name": "Margherita Pizza",
          "image": "https://example.com/pizza.jpg",
          "price": 399.00,
          "description": "Classic pizza with tomato sauce and mozzarella",
        },
        "quantity": 1,
        "variation": "Large",
        "price": 399.00,
        "addons": [
          {"name": "Extra Cheese", "price": 50.00},
          {"name": "Olives", "price": 30.00},
        ],
      },
      {
        "product": {
          "name": "Pasta Alfredo",
          "image": "https://example.com/pasta.jpg",
          "price": 299.00,
          "description": "Creamy white sauce pasta with mushrooms",
        },
        "quantity": 2,
        "variation": "Regular",
        "price": 299.00,
      },
      {
        "product": {
          "name": "Garlic Bread",
          "image": "https://example.com/garlicbread.jpg",
          "price": 99.00,
          "description": "Freshly baked bread with garlic butter",
        },
        "quantity": 1,
        "price": 99.00,
      },
    ],
    "deliveryAddress": {
      "name": "Jane Smith",
      "address": "456 Foodie Lane, Apt 12",
      "city": "Bangalore",
      "state": "Karnataka",
      "pincode": "560001",
      "phone": "9876543210",
      "instructions": "Ring the bell twice",
    },
    "restaurant": {
      "name": "Italian Bistro",
      "address": "123 Restaurant Street, Food Court",
    },
  };

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final isDark = themeChange.getThem();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
        title: Text(
          "Order Detail",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Restaurant Info
            Card(
              color: isDark ? AppThemeData.grey800 : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _staticOrder["restaurant"]["name"],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _staticOrder["restaurant"]["address"],
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Order Summary Card
            Card(
              color: isDark ? AppThemeData.grey800 : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order #${_staticOrder["sId"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Chip(
                          label: Text(
                            _staticOrder["status"],
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: _getStatusColor(
                            _staticOrder["status"],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Placed on: ${_formatDate(_staticOrder["createdAt"])}",
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Food Items List
            Card(
              color: isDark ? AppThemeData.grey800 : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Items (${_staticOrder["items"].length})",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _staticOrder["items"].length,
                      itemBuilder: (context, index) {
                        return _buildFoodItemRow(
                          _staticOrder["items"][index],
                          isDark,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(height: 24);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Payment Summary
            Card(
              color: isDark ? AppThemeData.grey800 : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bill Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPaymentRow(
                      "Item Total",
                      "₹${_staticOrder["subtotal"]}",
                      isDark,
                    ),
                    _buildPaymentRow(
                      "Delivery Fee",
                      "₹${_staticOrder["deliveryCharge"]}",
                      isDark,
                    ),
                    _buildPaymentRow(
                      "Packing Charges",
                      "₹${_staticOrder["packingCharge"]}",
                      isDark,
                    ),
                    _buildPaymentRow(
                      "GST (${_staticOrder["gstPercentage"]}%)",
                      "₹${(_staticOrder["subtotal"] * _staticOrder["gstPercentage"] / 100).toStringAsFixed(2)}",
                      isDark,
                    ),
                    const Divider(),
                    _buildPaymentRow(
                      "Total Amount",
                      "₹${_staticOrder["totalAmount"]}",
                      isDark,
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Delivery Information
            // Card(
            //   color: isDark ? AppThemeData.grey800 : Colors.white,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   elevation: 2,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "Delivery Information",
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: isDark ? Colors.white : Colors.black,
            //           ),
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           _staticOrder["deliveryAddress"]["name"],
            //           style: TextStyle(
            //             color: isDark ? Colors.white : Colors.black,
            //           ),
            //         ),
            //         Text(
            //           _staticOrder["deliveryAddress"]["address"],
            //           style: TextStyle(
            //             color: isDark ? Colors.grey[400] : Colors.grey[600],
            //           ),
            //         ),
            //         Text(
            //           "${_staticOrder["deliveryAddress"]["city"]}, ${_staticOrder["deliveryAddress"]["state"]} - ${_staticOrder["deliveryAddress"]["pincode"]}",
            //           style: TextStyle(
            //             color: isDark ? Colors.grey[400] : Colors.grey[600],
            //           ),
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           "Phone: ${_staticOrder["deliveryAddress"]["phone"]}",
            //           style: TextStyle(
            //             color: isDark ? Colors.grey[400] : Colors.grey[600],
            //           ),
            //         ),
            //         if (_staticOrder["deliveryAddress"]["instructions"] != null)
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const SizedBox(height: 8),
            //               Text(
            //                 "Delivery Instructions:",
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   color:
            //                       isDark ? Colors.grey[400] : Colors.grey[600],
            //                 ),
            //               ),
            //               Text(
            //                 _staticOrder["deliveryAddress"]["instructions"],
            //                 style: TextStyle(
            //                   color:
            //                       isDark ? Colors.grey[400] : Colors.grey[600],
            //                 ),
            //               ),
            //             ],
            //           ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItemRow(Map<String, dynamic> item, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item["product"]["image"] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item["product"]["image"],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.fastfood),
                      ),
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["product"]["name"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  if (item["variation"] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        item["variation"],
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ),
                  Text(
                    "₹${item["price"]} × ${item["quantity"]}",
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  if (item["addons"] != null && item["addons"].isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          "Add-ons:",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        ...item["addons"]
                            .map<Widget>(
                              (addon) => Text(
                                "• ${addon["name"]} (+₹${addon["price"]})",
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      isDark
                                          ? Colors.grey[400]
                                          : Colors.grey[600],
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                ],
              ),
            ),
            Text(
              "₹${(item["price"] * item["quantity"]).toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        if (item["product"]["description"] != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              item["product"]["description"],
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentRow(
    String label,
    String value,
    bool isDark, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateString;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
      case "delivered":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "cancelled":
        return Colors.red;
      case "preparing":
        return Colors.blue;
      case "on the way":
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }
}
