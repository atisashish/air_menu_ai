import 'package:air_menu_ai_app/app/home_screen/restro_detail_screen.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  bool _showFilters = false;
  final _scrollController = ScrollController();

  // Filter options - Updated to match the images
  final Map<String, bool> _sortFilters = {
    'Relevance': false,
    'Rating: High to Low': false,
    'Cost: Low to High': false,
    'Cost: High to Low': false,
    'Distance: Near to Far': false,
    'Offer: High to Low': false,
  };

  final Map<String, bool> _cuisineFilters = {
    'Cafe': false,
    'South Indian': false,
    'North Indian': false,
    'Mithai': false,
    'Gujarati': false,
    'Healthy Food': false,
    'Mughlai': false,
    // Original additional cuisines
    'Italian': false,
    'Chinese': false,
    'Fast Food': false,
    'Seafood': false,
    'Maharashtrian': false,
  };

  final Map<String, bool> _costFilters = {
    '₹2,500 - Any': false,
    '₹2,000 - ₹2,500': false,
    '₹1,500 - ₹2,000': false,
    '₹1,000 - ₹1,500': false,
    '₹500 - ₹1,000': false,
    'Less than ₹500': false,
  };

  final Map<String, bool> _moreFilters = {
    'Wheelchair Accessible': false,
    'Buffet': false,
    'Cafes': false,
    'Pubs and Bars': false,
    'Fine dining': false,
    'Bakeries': false,
    'Live Music': false,
    'Brunch': false,
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
        title: Text(
          "Romantic Dining",
          style: TextStyle(
            fontSize: 16,
            color:
                themeChange.getThem()
                    ? AppThemeData.grey50
                    : AppThemeData.grey900,
            fontFamily: AppThemeData.medium,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color:
                  themeChange.getThem()
                      ? AppThemeData.grey50
                      : AppThemeData.grey900,
            ),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main Content
          ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            itemCount: 10, // Replace with your actual item count
            itemBuilder: (context, index) {
              return _buildRestaurantCard(themeChange, index);
            },
          ),

          // Filter Panel
          if (_showFilters) _buildFilterPanel(themeChange),
        ],
      ),
    );
  }

  Widget _buildFilterPanel(DarkThemeProvider themeChange) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color:
                    themeChange.getThem() ? AppThemeData.grey800 : Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey500
                              : AppThemeData.grey300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Title and Close button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter by",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              themeChange.getThem()
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color:
                              themeChange.getThem()
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _showFilters = false;
                          });
                        },
                      ),
                    ],
                  ),

                  // Filter content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFilterSection("Sort by", _sortFilters),
                          const SizedBox(height: 24),
                          _buildFilterSection(
                            "Dishes and cuisines",
                            _cuisineFilters,
                          ),
                          const SizedBox(height: 24),
                          _buildFilterSection("Cost for two", _costFilters),
                          const SizedBox(height: 24),
                          _buildFilterSection("More Filters", _moreFilters),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),

                  // Apply buttons
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey800
                              : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color:
                                    themeChange.getThem()
                                        ? AppThemeData.grey500
                                        : AppThemeData.grey300,
                              ),
                            ),
                            onPressed: _resetAllFilters,
                            child: Text(
                              "Clear all",
                              style: TextStyle(
                                color:
                                    themeChange.getThem()
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppThemeData.primary300,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () {
                              setState(() {
                                _showFilters = false;
                              });
                              // Apply filters here
                            },
                            child: const Text(
                              "Apply",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _resetAllFilters() {
    setState(() {
      _sortFilters.forEach((key, value) => _sortFilters[key] = false);
      _cuisineFilters.forEach((key, value) => _cuisineFilters[key] = false);
      _costFilters.forEach((key, value) => _costFilters[key] = false);
      _moreFilters.forEach((key, value) => _moreFilters[key] = false);
    });
  }

  Widget _buildFilterSection(String title, Map<String, bool> filters) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: themeChange.getThem() ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              filters.entries.map((entry) {
                return FilterChip(
                  label: Text(
                    entry.key,
                    style: TextStyle(
                      color:
                          entry.value
                              ? Colors.white
                              : (themeChange.getThem()
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                  selected: entry.value,
                  backgroundColor:
                      themeChange.getThem()
                          ? AppThemeData.grey700
                          : AppThemeData.grey100,
                  selectedColor: AppThemeData.primary300,
                  checkmarkColor: Colors.white,
                  onSelected: (bool selected) {
                    setState(() {
                      filters[entry.key] = selected;
                    });
                  },
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildRestaurantCard(DarkThemeProvider themeChange, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Get.to(
              RestroDetailScreen(),
              arguments: {"categoryID": "6", "name": "Haldiram Restaurant"},
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      "https://t3.ftcdn.net/jpg/03/24/73/92/360_F_324739203_keeq8udvv0P2h1MLYJ0GLSlTBagoXS48.jpg",
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/ic_like.svg",
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Row(
                      children: [
                        _buildTag(
                          bgColor: AppThemeData.primary300.withOpacity(0.9),
                          icon: "assets/icons/ic_star.svg",
                          text: '4.5',
                          textColor: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        _buildTag(
                          bgColor: Colors.black.withOpacity(0.7),
                          icon: "assets/icons/ic_map_distance.svg",
                          text: '1.2 KM',
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Haldiram Restaurant',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            themeChange.getThem() ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Surat, Gujarat',
                      style: TextStyle(
                        color:
                            themeChange.getThem()
                                ? AppThemeData.grey400
                                : AppThemeData.grey600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'North Indian',
                          style: TextStyle(
                            color:
                                themeChange.getThem()
                                    ? AppThemeData.grey400
                                    : AppThemeData.grey600,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '₹1500 for two',
                          style: TextStyle(
                            color:
                                themeChange.getThem()
                                    ? AppThemeData.grey400
                                    : AppThemeData.grey600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag({
    required Color bgColor,
    required String icon,
    required String text,
    required Color textColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 14,
            height: 14,
            colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
