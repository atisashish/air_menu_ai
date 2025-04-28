import 'package:air_menu_ai_app/app/home_screen/table_booking_screen.dart';
import 'package:air_menu_ai_app/app/restaurant_details_screen/restaurant_details_screen.dart';
import 'package:air_menu_ai_app/controllers/home_controller.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:air_menu_ai_app/widget/no_data_found.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class RestroDetailScreen extends StatefulWidget {
  const RestroDetailScreen({super.key});

  @override
  State<RestroDetailScreen> createState() => _RestroDetailScreenState();
}

class _RestroDetailScreenState extends State<RestroDetailScreen>
    with SingleTickerProviderStateMixin {
  final List<String> imageUrls = [
    'https://recipesblob.oetker.in/assets/d8a4b00c292a43adbb9f96798e028f01/1272x764/pizza-pollo-arrostojpg.webp',
    'https://content.jdmagicbox.com/v2/comp/delhi/c7/011pxx11.xx11.181214134549.k6c7/catalogue/my-imperial-pizzaector-mandir-marg-delhi-pizza-outlets-e85ogv6fux.jpg',
    'https://content.jdmagicbox.com/v2/comp/navi-mumbai/h9/022pxx22.xx22.171007182505.i1h9/catalogue/laziz-pizza-sanpada-sector-1-navi-mumbai-pizza-outlets-1rrvdvc.jpg',
  ];

  int _currentIndex = 0;
  final HomeController homeController = Get.find();
  String categoryID = '';
  String restroID = '';
  String name = '';
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'All',
      'price': '',
      'image': 'https://rastorant-frontend.vercel.app/categories/new/1.png',
    },
    {
      'name': 'Appetizers',
      'price': '5€',
      'image': 'https://rastorant-frontend.vercel.app/categories/new/1.png',
    },
    {
      'name': 'Burgers',
      'price': '8€',
      'image': 'https://rastorant-frontend.vercel.app/categories/new/2.png',
    },
    {
      'name': 'Veggie',
      'price': '7€',
      'image': 'https://rastorant-frontend.vercel.app/categories/new/3.png',
    },
    {
      'name': 'Sandwich',
      'price': '6€',
      'image': 'https://rastorant-frontend.vercel.app/categories/new/4.png',
    },
    {
      'name': 'Hot Chicken',
      'price': '9€',
      'image': 'https://rastorant-frontend.vercel.app/categories/new/5.png',
    },
    {
      'name': 'Beef',
      'price': '10€',
      'image': 'https://rastorant-frontend.vercel.app/categories/new/6.png',
    },
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    dynamic argumentData = Get.arguments;
    categoryID = argumentData["categoryID"];
    name = argumentData["name"];
    restroID = argumentData["restroID"];
    homeController.getCategoryProduct(categoryID: categoryID);
    homeController.gerRestroDetail(restroID: restroID);
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : 3;
    double childAspectRatio = (screenWidth / crossAxisCount) / 280;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Get.to(TableBookingScreen(restaurantName: 'JW Marriott'));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: const Text(
              'Book Your Table',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () =>
            homeController.isRetsroDetailLoading.value
                ? NestedScrollView(
                  headerSliverBuilder:
                      (context, innerBoxIsScrolled) => [
                        SliverAppBar(
                          expandedHeight: 200,
                          flexibleSpace: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(color: Colors.white),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 100,
                              color: Colors.white,
                              margin: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ],
                  body: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(
                            4,
                            (index) => Container(
                              height: 100,
                              margin: EdgeInsets.all(16),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                            3,
                            (index) => Container(
                              height: 120,
                              margin: EdgeInsets.all(16),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (
                    BuildContext context,
                    bool innerBoxIsScrolled,
                  ) {
                    return [
                      SliverAppBar(
                        foregroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        backgroundColor: Colors.white,
                        expandedHeight: 300.0,
                        pinned: true,
                        floating: true,
                        centerTitle: true,
                        leading: InkWell(
                          child: Icon(Icons.arrow_back, color: Colors.black),
                          onTap: () {
                            Get.back();
                          },
                        ),
                        title: Text(
                          homeController.restroDetail.value.data?.name ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              CarouselSlider.builder(
                                itemCount:
                                    homeController
                                        .restroDetail
                                        .value
                                        .data
                                        ?.galleryImages
                                        ?.length ??
                                    0,
                                itemBuilder: (context, index, realIdx) {
                                  return CachedNetworkImage(
                                    imageUrl:
                                        homeController
                                            .restroDetail
                                            .value
                                            .data
                                            ?.galleryImages?[index]
                                            .url ??
                                        "",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    placeholder:
                                        (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                            const Icon(Icons.error),
                                  );
                                },
                                options: CarouselOptions(
                                  height: 300,
                                  viewportFraction: 1.0,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: -230,
                                left: 0,
                                right: 0,
                                top: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      homeController
                                          .restroDetail
                                          .value
                                          .data!
                                          .galleryImages!
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                            return Container(
                                              width: 8.0,
                                              height: 8.0,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4.0,
                                                  ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    _currentIndex == entry.key
                                                        ? Colors.black
                                                        : Colors.grey,
                                              ),
                                            );
                                          })
                                          .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          Container(
                            color: Colors.white,
                            child: TabBar(
                              tabAlignment: TabAlignment.start,
                              controller: _tabController,
                              isScrollable: true,
                              // Make the TabBar scrollable
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.red,
                              indicatorWeight: 3,
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              tabs: const [
                                Tab(text: 'All offers'),
                                Tab(text: 'Menu'),
                                Tab(text: 'Gallery'),
                                Tab(text: 'Reviews'),
                                Tab(text: 'About'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRestaurantInfo(),
                            const SizedBox(height: 24),
                            const Text(
                              "Pre-book offer",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildOfferCard(
                              title: "Flat 30% OFF",
                              subtitle: "8 slots available from 12:00 PM today",
                              buttonText: "Book now →",
                            ),
                            const SizedBox(height: 16),
                            _buildOfferCard(
                              title: "Signature Package(s)",
                              subtitle: "Starting at ₹1,699",
                              buttonText: "View menu • Book now →",
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              "Walk-in offers",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildOfferCard(
                              title: "Instant offer",
                              subtitle: "Flat 10% OFF\nValid from 11AM–6AM",
                              buttonText: "",
                            ),
                          ],
                        ),
                      ),
                      // Menu Content
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => Column(
                            children: [
                              SizedBox(height: 15),
                              Container(
                                height: 115,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Container(
                                        width: 80,
                                        margin: EdgeInsets.only(right: 12),
                                        child: Column(
                                          children: [
                                            // Circular Image Container
                                            Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    selectedIndex == index
                                                        ? Colors.orange[100]
                                                        : Colors.grey[200],
                                                border: Border.all(
                                                  color:
                                                      selectedIndex == index
                                                          ? Colors.orange
                                                          : Colors.grey[300]!,
                                                  width: 2,
                                                ),
                                              ),
                                              child: ClipOval(
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      categories[index]['image'],
                                                  placeholder:
                                                      (context, url) => Center(
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                Color
                                                              >(Colors.orange),
                                                        ),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                            Icons.fastfood,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            // Category Name
                                            Text(
                                              categories[index]['name'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    selectedIndex == index
                                                        ? Colors.orange
                                                        : Colors.black,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Expanded(
                                child:
                                    homeController.isProductLoading.value
                                        ? GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: crossAxisCount,
                                                crossAxisSpacing: 8,
                                                mainAxisSpacing: 8,
                                                childAspectRatio:
                                                    childAspectRatio,
                                              ),
                                          itemCount: 6,
                                          itemBuilder: (context, index) {
                                            return _buildShimmerEffect();
                                          },
                                        )
                                        : homeController
                                            .productList
                                            .value
                                            .isEmpty
                                        ? const NoDataFound()
                                        : GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: crossAxisCount,
                                                crossAxisSpacing: 8,
                                                mainAxisSpacing: 8,
                                                childAspectRatio:
                                                    childAspectRatio,
                                              ),
                                          itemCount:
                                              homeController
                                                  .productList
                                                  .value
                                                  .length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Get.to(
                                                  RestaurantDetailsScreen(),
                                                  arguments: {
                                                    "productId":
                                                        homeController
                                                            .productList
                                                            .value[index]
                                                            .sId,
                                                  },
                                                );
                                              },
                                              child: FoodCard(
                                                image:
                                                    homeController
                                                        .productList
                                                        .value[index]
                                                        .image ??
                                                    "",
                                                title:
                                                    homeController
                                                        .productList
                                                        .value[index]
                                                        .name ??
                                                    "",
                                                price: "₹ 500",
                                              ),
                                            );
                                          },
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Gallery Content
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: childAspectRatio,
                              ),
                          itemCount:
                              homeController
                                  .restroDetail
                                  .value
                                  .data
                                  ?.galleryImages
                                  ?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl:
                                  homeController
                                      .restroDetail
                                      .value
                                      .data
                                      ?.galleryImages?[index]
                                      .url ??
                                  "",
                              imageBuilder:
                                  (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              placeholder:
                                  (context, url) => Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                            );
                          },
                        ),
                      ),

                      // Reviews Content
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRestaurantInfo(),
                            const SizedBox(height: 16),
                            RatingStars(
                              value: 4.2,
                              starBuilder:
                                  (index, color) => Icon(
                                    Icons.star_rounded,
                                    color: color,
                                    size: 20,
                                  ),
                              starCount: 5,
                              valueLabelVisibility: false,
                            ),
                            const Text(
                              '4.2 rating based on 1,200+ reviews',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _buildReviewCard(
                              name: 'Anjali',
                              review: 'Amazing ambiance and delicious food!',
                            ),
                            const SizedBox(height: 16),
                            _buildReviewCard(
                              name: 'Ravi',
                              review:
                                  'Loved the dhaba-style interiors. Great service.',
                            ),
                          ],
                        ),
                      ),

                      // About Content
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRestaurantInfo(),
                            const SizedBox(height: 16),
                            // Restaurant About Header
                            const Text(
                              'About the restaurant',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Basic Info
                            Text(
                              homeController
                                      .restroDetail
                                      .value
                                      .data
                                      ?.description ??
                                  "",
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              homeController.restroDetail.value.data?.price ??
                                  "",
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            const SizedBox(height: 16),

                            // Cuisines
                            Text(
                              homeController.restroDetail.value.data?.cuisine ??
                                  "",
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            const SizedBox(height: 16),

                            // Facilities
                            const Text(
                              'Available facilities',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildFacilityItem('Home Delivery'),
                            _buildFacilityItem('Takeaway Available'),
                            _buildFacilityItem('Mall Parking'),
                            const SizedBox(height: 16),

                            // More Facilities
                            _buildFacilityItem('Outdoor Seating'),
                            _buildFacilityItem('Family Friendly'),
                            _buildFacilityItem('Table booking recommended'),
                            const SizedBox(height: 16),

                            // Featured In
                            const Text(
                              'Featured in',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://img.freepik.com/premium-photo/group-friends-eating-together_53876-42081.jpg?semt=ais_hybrid&w=740",
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) => Container(
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                errorWidget:
                                    (context, url, error) => Container(
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.error),
                                    ),
                              ),
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

  Widget _buildRestaurantInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeController.restroDetail.value.data?.name ?? "",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    homeController.restroDetail.value.data?.location ?? "",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${homeController.restroDetail.value.data?.distance ?? ""} away • ${homeController.restroDetail.value.data?.price ?? ""}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.circle, size: 10, color: Colors.green),
                      SizedBox(width: 5),
                      Text("Open", style: TextStyle(color: Colors.green)),
                      SizedBox(width: 10),
                      Text(
                        "• 9:30 AM to 11:00 PM",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade300, Colors.red.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Text(
                    homeController.restroDetail.value.data?.rating
                            ?.toStringAsFixed(2) ??
                        "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.star, color: Colors.white, size: 16),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFacilityItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard({required String name, required String review}) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                '2 days ago',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard({
    required String title,
    required String subtitle,
    required String buttonText,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ),
          if (buttonText.isNotEmpty) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 14,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 12,
                        width: 50,
                        color: Colors.grey.shade300,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 35,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
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
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 48; // Minimum height of the tab bar

  @override
  double get maxExtent => 48; // Maximum height of the tab bar

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class FoodCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const FoodCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder:
                    (context, url) => Container(color: Colors.grey.shade200),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Add',
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
  }
}
