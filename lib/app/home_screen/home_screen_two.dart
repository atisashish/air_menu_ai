import 'package:air_menu_ai_app/app/cart_screen/cart_screen.dart';
import 'package:air_menu_ai_app/app/edit_profile_screen/edit_profile_screen.dart';
import 'package:air_menu_ai_app/app/home_screen/restaurant_list_screen.dart';
import 'package:air_menu_ai_app/app/home_screen/restro_detail_screen.dart';
import 'package:air_menu_ai_app/app/search_screen/search_screen.dart';
import 'package:air_menu_ai_app/constant/constant.dart';
import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/controllers/edit_profile_controller.dart';
import 'package:air_menu_ai_app/controllers/home_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/themes/responsive.dart';
import 'package:air_menu_ai_app/themes/text_field_widget.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:air_menu_ai_app/utils/network_image_widget.dart';
import 'package:badges/badges.dart' as badges show Badge;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/restro_model.dart' as restroModel;

class HomeScreenTwo extends StatefulWidget {
  HomeScreenTwo({super.key});

  @override
  State<HomeScreenTwo> createState() => _HomeScreenTwoState();
}

class _HomeScreenTwoState extends State<HomeScreenTwo> {
  final HomeController homeController = Get.put(HomeController());

  final EditProfileController editProfileController = Get.put(
    EditProfileController(),
  );
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(EditProfileScreen());
                        },
                        child: Obx(
                          () =>
                              (homeController.userData.value.data?.img == null)
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.asset(
                                      Constant.userPlaceHolder,
                                      height: Responsive.width(13, context),
                                      width: Responsive.width(13, context),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: NetworkImageWidget(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          homeController
                                              .userData
                                              .value
                                              .data
                                              ?.img ??
                                          "",
                                      height: Responsive.width(13, context),
                                      width: Responsive.width(13, context),
                                      errorWidget: Image.asset(
                                        Constant.userPlaceHolder,
                                        fit: BoxFit.cover,
                                        height: Responsive.width(13, context),
                                        width: Responsive.width(13, context),
                                      ),
                                    ),
                                  ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                homeController.userData.value.data?.name ??
                                    "No Name Found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppThemeData.medium,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : AppThemeData.grey900,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {},
                              child: Text.rich(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          homeController.selectedAddress.value,
                                      style: TextStyle(
                                        fontFamily: AppThemeData.medium,
                                        overflow: TextOverflow.ellipsis,
                                        color:
                                            themeChange.getThem()
                                                ? AppThemeData.grey50
                                                : AppThemeData.grey900,
                                        fontSize: 14,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: SvgPicture.asset(
                                        "assets/icons/ic_down.svg",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Obx(
                        () => badges.Badge(
                          showBadge: true,
                          badgeContent: Text(
                            homeController.cartList.value.data?.items?.length
                                    .toString() ??
                                "",
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: AppThemeData.semiBold,
                              fontWeight: FontWeight.w600,
                              color:
                                  themeChange.getThem()
                                      ? AppThemeData.grey50
                                      : AppThemeData.grey50,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              if (homeController
                                      .cartList
                                      .value
                                      .data
                                      ?.items
                                      ?.isEmpty ??
                                  false) {
                                ShowToastDialog.showToast(
                                  "Your Cart Looks Empty",
                                  position: EasyLoadingToastPosition.bottom,
                                );
                              } else {
                                Get.to(CartScreen());
                              }
                            },
                            child: ClipOval(
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.grey700
                                              : AppThemeData.grey200,
                                    ),
                                    borderRadius: BorderRadius.circular(120),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/ic_shoping_cart.svg",
                                    colorFilter: ColorFilter.mode(
                                      themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : AppThemeData.grey900,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Get.to(SearchScreen());
                    },
                    child: TextFieldWidget(
                      suffix: Image.asset(
                        "assets/icons/ai.png",
                        height: 3,
                        width: 3,
                      ),
                      hintText: 'Search the dish, restaurant, food, meals'.tr,
                      controller: null,
                      enable: false,
                      prefix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset("assets/icons/ic_search.svg"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () =>
                          homeController.isBanner.value
                              ? Center(
                                child: Container(
                                  height: 170,
                                  width: 370,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                              )
                              : CarouselSlider.builder(
                                options: CarouselOptions(
                                  aspectRatio: 2.0,
                                  viewportFraction: 1,
                                  enlargeCenterPage: true,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  height: 170,
                                  initialPage: _currentIndex,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                ),
                                itemCount:
                                    homeController.bannerList.value.length,
                                itemBuilder: (context, index, realIndex) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        width: 370,
                                        imageUrl:
                                            homeController
                                                .bannerList
                                                .value[index]
                                                .image ??
                                            "",
                                        alignment: Alignment.topCenter,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                        placeholder:
                                            (context, url) => Container(
                                              width: 370,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withOpacity(
                                                  0.2,
                                                ),
                                              ),
                                            ),
                                        errorWidget:
                                            (context, url, error) => Container(
                                              width: 370,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withOpacity(
                                                  0.2,
                                                ),
                                              ),
                                              child: Center(
                                                child: Icon(Icons.error),
                                              ),
                                            ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            homeController.bannerList.value.map((item) {
                              int index = homeController.bannerList.value
                                  .indexOf(item);
                              return GestureDetector(
                                onTap: () {},
                                child:
                                    _currentIndex == index
                                        ? Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 4.0,
                                          ),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                          ),
                                        )
                                        : Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 4.0,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                              );
                            }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fastest Delivery 🔥‍",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.red.shade100,
                          //     foregroundColor: Colors.red.shade700,
                          //     elevation: 0,
                          //     padding: EdgeInsets.symmetric(
                          //       horizontal: 20,
                          //       vertical: 4,
                          //     ),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(20),
                          //     ),
                          //     textStyle: TextStyle(
                          //       fontWeight: FontWeight.w600,
                          //       fontSize: 13,
                          //     ),
                          //   ),
                          //   child: Text("See all"),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () =>
                          homeController.isRestaurantLoading.value
                              ? SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  itemCount:
                                      3, // Number of shimmer placeholders
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                      baseColor:
                                          themeChange.getThem()
                                              ? Colors.grey[800]!
                                              : Colors.grey[300]!,
                                      highlightColor:
                                          themeChange.getThem()
                                              ? Colors.grey[700]!
                                              : Colors.grey[100]!,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 16,
                                        ),
                                        child: Container(
                                          width: 280,
                                          decoration: ShapeDecoration(
                                            color:
                                                themeChange.getThem()
                                                    ? Colors.grey[800]
                                                    : Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Image placeholder with shimmer
                                              Container(
                                                width: double.infinity,
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  color:
                                                      themeChange.getThem()
                                                          ? Colors.grey[700]
                                                          : Colors.grey[200],
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(16),
                                                        topRight:
                                                            Radius.circular(16),
                                                      ),
                                                ),
                                              ),

                                              // Bottom content
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8,
                                                    ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Title placeholder
                                                    Container(
                                                      width: 150,
                                                      height: 20,
                                                      color:
                                                          themeChange.getThem()
                                                              ? Colors.grey[700]
                                                              : Colors
                                                                  .grey[200],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    // Subtitle placeholder
                                                    Container(
                                                      width: 200,
                                                      height: 16,
                                                      color:
                                                          themeChange.getThem()
                                                              ? Colors.grey[700]
                                                              : Colors
                                                                  .grey[200],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                              : SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  itemCount:
                                      homeController
                                          .restroList
                                          .value
                                          .length, // Now we have exactly 5 items
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            RestroDetailScreen(),
                                            arguments: {
                                              "categoryID": "6",
                                              "restroID":
                                                  homeController
                                                      .restroList
                                                      .value[index]
                                                      .sId ??
                                                  "",
                                              "name":
                                                  homeController
                                                      .productList
                                                      .value[index]
                                                      .sId,
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 280,
                                          decoration: ShapeDecoration(
                                            color:
                                                themeChange.getThem()
                                                    ? AppThemeData.grey900
                                                    : AppThemeData.grey50,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Image with overlay and icons
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                16,
                                                              ),
                                                          topRight:
                                                              Radius.circular(
                                                                16,
                                                              ),
                                                        ),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 140,
                                                      color: Colors.grey[300],
                                                      child: Image.network(
                                                        homeController
                                                                .restroList
                                                                .value[index]
                                                                .mainImage ??
                                                            "",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  // Gradient overlay
                                                  Container(
                                                    height: 140,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end:
                                                            Alignment
                                                                .bottomCenter,
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(0),
                                                          const Color(
                                                            0xFF111827,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // Like Icon
                                                  Positioned(
                                                    right: 10,
                                                    top: 10,
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: SvgPicture.asset(
                                                        "assets/icons/ic_like.svg",
                                                      ),
                                                    ),
                                                  ),
                                                  // Ratings + Distance Tags
                                                  Positioned(
                                                    bottom: 10,
                                                    right: 10,
                                                    child: Row(
                                                      children: [
                                                        _buildTag(
                                                          bgColor:
                                                              themeChange
                                                                      .getThem()
                                                                  ? AppThemeData
                                                                      .primary600
                                                                  : AppThemeData
                                                                      .primary50,
                                                          icon:
                                                              "assets/icons/ic_star.svg",
                                                          text:
                                                              homeController
                                                                  .restroList
                                                                  .value[index]
                                                                  .rating
                                                                  ?.toStringAsFixed(
                                                                    2,
                                                                  ) ??
                                                              "",
                                                          textColor:
                                                              AppThemeData
                                                                  .primary300,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        _buildTag(
                                                          bgColor:
                                                              themeChange
                                                                      .getThem()
                                                                  ? AppThemeData
                                                                      .secondary600
                                                                  : AppThemeData
                                                                      .secondary50,
                                                          icon:
                                                              "assets/icons/ic_map_distance.svg",
                                                          text:
                                                              homeController
                                                                  .restroList
                                                                  .value[index]
                                                                  .distance ??
                                                              "",
                                                          textColor:
                                                              AppThemeData
                                                                  .secondary300,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Title & Subtitle
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8,
                                                    ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      homeController
                                                              .restroList
                                                              .value[index]
                                                              .name ??
                                                          "",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            AppThemeData
                                                                .semiBold,
                                                        color:
                                                            themeChange
                                                                    .getThem()
                                                                ? AppThemeData
                                                                    .grey50
                                                                : AppThemeData
                                                                    .grey900,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      homeController
                                                              .restroList
                                                              .value[index]
                                                              .location ??
                                                          "",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppThemeData.medium,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppThemeData
                                                                .grey400,
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
                                  },
                                ),
                              ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Explore the Categories",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppThemeData.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              // InkWell(
                              //   onTap: () {},
                              //   child: Text(
                              //     "View all".tr,
                              //     textAlign: TextAlign.center,
                              //     style: TextStyle(
                              //       fontFamily: AppThemeData.regular,
                              //       color:
                              //           themeChange.getThem()
                              //               ? AppThemeData.primary300
                              //               : AppThemeData.primary300,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CategoryView(),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "New Arrivals".tr,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppThemeData.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          NewArrival(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Exclusive Offerings",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppThemeData.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              OfferCard(
                                image: 'assets/icons/7.png',
                                textTop: 'Flat',
                                textBottom: '50% OFF',
                                gradientColors: [
                                  Color(0xFF7B61FF),
                                  Color(0xFF5AC8FA),
                                ],
                              ),
                              OfferCard(
                                image: 'assets/icons/8.png',
                                textTop: '20% OFF',
                                textBottom: 'and above',
                                gradientColors: [
                                  Color(0xFFFF4D67),
                                  Color(0xFFFF84A1),
                                ],
                              ),
                              OfferCard(
                                image: 'assets/icons/9.png',
                                textTop: 'Book in',
                                textBottom: 'advance',
                                gradientColors: [
                                  Color(0xFF9E9E9E),
                                  Color(0xFFEEEEEE),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height:
                          280 *
                          homeController.restroList.value.length.toDouble(),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: homeController.restroList.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  RestroDetailScreen(),
                                  arguments: {
                                    "restroID":
                                        homeController
                                            .restroList
                                            .value[index]
                                            .sId ??
                                        "",
                                    "categoryID": "6",
                                    "name":
                                        homeController
                                            .productList
                                            .value[index]
                                            .sId,
                                  },
                                );
                              },
                              child: Container(
                                width: 280,
                                decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 0.5,
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey900
                                          : AppThemeData.grey50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Image with overlay and icons
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: 180,
                                            color: Colors.grey[300],
                                            child: Image.network(
                                              homeController
                                                      .restroList
                                                      .value[index]
                                                      .mainImage ??
                                                  "",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        // Gradient overlay
                                        Container(
                                          height: 180,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.black.withOpacity(0),
                                                Colors.black.withOpacity(0.3),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Like Icon
                                        Positioned(
                                          right: 10,
                                          top: 10,
                                          child: InkWell(
                                            onTap: () {},
                                            child: SvgPicture.asset(
                                              "assets/icons/ic_like.svg",
                                            ),
                                          ),
                                        ),
                                        // Ratings + Distance Tags
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: Row(
                                            children: [
                                              _buildTag(
                                                bgColor:
                                                    themeChange.getThem()
                                                        ? AppThemeData
                                                            .primary600
                                                        : AppThemeData
                                                            .primary50,
                                                icon:
                                                    "assets/icons/ic_star.svg",
                                                text:
                                                    homeController
                                                        .restroList
                                                        .value[index]
                                                        .rating
                                                        ?.toStringAsFixed(2) ??
                                                    "",
                                                textColor:
                                                    AppThemeData.primary300,
                                              ),
                                              const SizedBox(width: 10),
                                              _buildTag(
                                                bgColor:
                                                    themeChange.getThem()
                                                        ? AppThemeData
                                                            .secondary600
                                                        : AppThemeData
                                                            .secondary50,
                                                icon:
                                                    "assets/icons/ic_map_distance.svg",
                                                text:
                                                    homeController
                                                        .restroList
                                                        .value[index]
                                                        .distance ??
                                                    "",
                                                textColor:
                                                    AppThemeData.secondary300,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Title & Subtitle
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            homeController
                                                    .restroList
                                                    .value[index]
                                                    .name ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: AppThemeData.semiBold,
                                              color:
                                                  themeChange.getThem()
                                                      ? AppThemeData.grey50
                                                      : AppThemeData.grey900,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            homeController
                                                    .restroList
                                                    .value[index]
                                                    .location ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: AppThemeData.medium,
                                              fontWeight: FontWeight.w500,
                                              color: AppThemeData.grey400,
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
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(120)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontFamily: AppThemeData.semiBold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewArrival extends StatelessWidget {
  NewArrival({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Obx(
      () =>
          homeController.isRestaurantLoading.value
              ? SizedBox(
                height: Responsive.height(24, context),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4, // Number of shimmer placeholders
                  itemBuilder: (BuildContext context, int index) {
                    return Shimmer.fromColors(
                      baseColor:
                          themeChange.getThem()
                              ? Colors.grey[800]!
                              : Colors.grey[300]!,
                      highlightColor:
                          themeChange.getThem()
                              ? Colors.grey[700]!
                              : Colors.grey[100]!,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: Responsive.width(55, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image placeholder
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Container(
                                    color:
                                        themeChange.getThem()
                                            ? Colors.grey[700]
                                            : Colors.grey[200],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Title placeholder
                              Container(
                                width: Responsive.width(30, context),
                                height: 16,
                                color:
                                    themeChange.getThem()
                                        ? Colors.grey[700]
                                        : Colors.grey[200],
                              ),
                              const SizedBox(height: 8),
                              // Rating and distance row
                              Row(
                                children: [
                                  // Rating placeholder
                                  Row(
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        color:
                                            themeChange.getThem()
                                                ? Colors.grey[600]
                                                : Colors.grey[300],
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        width: 30,
                                        height: 12,
                                        color:
                                            themeChange.getThem()
                                                ? Colors.grey[600]
                                                : Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  // Distance placeholder
                                  Row(
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        color:
                                            themeChange.getThem()
                                                ? Colors.grey[600]
                                                : Colors.grey[300],
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        width: 30,
                                        height: 12,
                                        color:
                                            themeChange.getThem()
                                                ? Colors.grey[600]
                                                : Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Location placeholder
                              Container(
                                width: Responsive.width(40, context),
                                height: 12,
                                color:
                                    themeChange.getThem()
                                        ? Colors.grey[600]
                                        : Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              : SizedBox(
                height: Responsive.height(24, context),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.restroList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          RestroDetailScreen(),
                          arguments: {
                            "restroID":
                                homeController.restroList.value[index].sId ??
                                "",
                            "categoryID": "6",
                            "name": "Haldiram Restaurent",
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: Responsive.width(55, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      NetworkImageWidget(
                                        imageUrl:
                                            homeController
                                                .restroList
                                                .value[index]
                                                .mainImage ??
                                            "",
                                        fit: BoxFit.cover,
                                        height: Responsive.height(100, context),
                                        width: Responsive.width(100, context),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: const Alignment(0.00, 1.00),
                                            end: const Alignment(0, -1),
                                            colors: [
                                              Colors.black45.withOpacity(0.1),
                                              AppThemeData.grey900,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {},
                                          child: SvgPicture.asset(
                                            "assets/icons/ic_like.svg",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                homeController.restroList.value[index].name ??
                                    "",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: AppThemeData.semiBold,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/ic_star.svg",
                                        colorFilter: ColorFilter.mode(
                                          AppThemeData.primary300,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        homeController
                                                .restroList
                                                .value[index]
                                                .rating
                                                ?.toStringAsFixed(2) ??
                                            "",
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: AppThemeData.medium,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              themeChange.getThem()
                                                  ? AppThemeData.grey400
                                                  : AppThemeData.grey400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/ic_map_distance.svg",
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        homeController
                                                .restroList
                                                .value[index]
                                                .distance ??
                                            "",
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: AppThemeData.medium,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              themeChange.getThem()
                                                  ? AppThemeData.grey400
                                                  : AppThemeData.grey400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                homeController
                                        .restroList
                                        .value[index]
                                        .location ??
                                    "",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: AppThemeData.medium,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey400
                                          : AppThemeData.grey400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}

class RestaurantShimmer extends StatelessWidget {
  const RestaurantShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(width: 80, height: 80, color: Colors.grey[300]),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 12,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 12,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 60,
                            height: 12,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final HomeController homeController = Get.find();

    final List<List<Color>> categoryGradients = [
      [const Color(0xFF841F1F), Colors.black],
      [const Color(0xFF1A2C85), Colors.black],
      [const Color(0xFF176633), Colors.black],
      [const Color(0xFF7C39A7), Colors.black],
      [const Color(0xFF723F11), Colors.black],
      [const Color(0xFF901A3D), Colors.black],
    ];

    return Obx(
      () =>
          homeController.isLoading.value
              ? SizedBox(
                height: 124,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 16),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor:
                          themeChange.getThem()
                              ? Colors.grey[800]!
                              : Colors.grey[300]!,
                      highlightColor:
                          themeChange.getThem()
                              ? Colors.grey[700]!
                              : Colors.grey[100]!,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color:
                                themeChange.getThem()
                                    ? Colors.grey[800]
                                    : Colors.grey[300],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      themeChange.getThem()
                                          ? Colors.grey[700]
                                          : Colors.grey[200],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                height: 12,
                                width: 70,
                                color:
                                    themeChange.getThem()
                                        ? Colors.grey[700]
                                        : Colors.grey[200],
                              ),
                              const SizedBox(height: 4),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                height: 12,
                                width: 50,
                                color:
                                    themeChange.getThem()
                                        ? Colors.grey[700]
                                        : Colors.grey[200],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              : SizedBox(
                height: 124,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 16),
                  itemCount: homeController.category.value.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(const RestaurantListScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: categoryGradients[index],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      themeChange.getThem()
                                          ? const Color(0xFF333333)
                                          : const Color(0xFFF0F0F0),
                                  border: Border.all(
                                    color:
                                        themeChange.getThem()
                                            ? const Color(0xFF444444)
                                            : const Color(0xFFE0E0E0),
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: NetworkImageWidget(
                                    imageUrl:
                                        homeController
                                            .category
                                            .value[index]
                                            .image ??
                                        "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  homeController.category.value[index].title ??
                                      "",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: AppThemeData.medium,
                                    fontSize: 12,
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
              ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String places;
  final String imagePath;

  const CategoryCard({
    super.key,
    required this.title,
    required this.places,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gradient background with circular image
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade200, Colors.red.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  imageUrl: imagePath,
                ),
              ),
            ),
          ),

          // Text section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatefulWidget {
  final List<restroModel.GalleryImages> imageUrls;
  final String name;
  final String location;
  final String cuisine;
  final String price;
  final String offer;
  final bool isNew;

  const RestaurantCard({
    super.key,
    required this.imageUrls,
    required this.name,
    required this.location,
    required this.cuisine,
    required this.price,
    required this.offer,
    this.isNew = false,
  });

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Card(
      color: themeChange.getThem() ? AppThemeData.grey900 : AppThemeData.grey50,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Image Carousel
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.imageUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: widget.imageUrls[index].url ?? "",
                        placeholder:
                            (context, url) =>
                                Container(color: Colors.grey[200]),
                        errorWidget:
                            (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.restaurant),
                            ),
                      ),
                    );
                  },
                ),
              ),

              // New Tag
              if (widget.isNew)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'New',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Offer Tag
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade300, Colors.red.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.offer,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Image Indicator
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_currentImageIndex + 1}/${widget.imageUrls.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Name
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                // Location and Distance
                Text(
                  widget.location,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),

                const SizedBox(height: 8),

                // Cuisine and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.cuisine, style: const TextStyle(fontSize: 14)),
                    Text(
                      widget.price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrinkCard extends StatefulWidget {
  final String? image;
  final String? title;
  final String? subTitle;
  final String? amount;
  final Widget? button;

  const DrinkCard({
    super.key,
    this.image,
    this.title,
    this.subTitle,
    this.amount,
    this.button,
  });

  @override
  State<DrinkCard> createState() => _DrinkCardState();
}

class _DrinkCardState extends State<DrinkCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color:
            themeChange.getThem() ? AppThemeData.grey900 : AppThemeData.grey50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  imageUrl: widget.image ?? '',
                  errorWidget:
                      (context, url, error) => Container(
                        color: Colors.grey.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://static.thenounproject.com/png/2616531-200.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://static.thenounproject.com/png/2616531-200.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.title ?? 'Mojito',
                          style: TextStyle(
                            fontFamily: AppThemeData.medium,
                            color:
                                themeChange.getThem()
                                    ? AppThemeData.grey50
                                    : AppThemeData.grey900,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.info,
                          size: 16,
                          color:
                              themeChange.getThem()
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: 180,
                      child: Text(
                        widget.subTitle ??
                            'Mixed drink of mint, lime, sugar, and club soda.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppThemeData.medium,
                          color:
                              themeChange.getThem()
                                  ? AppThemeData.grey50
                                  : AppThemeData.grey900,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.amount ?? '₹ 250.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppThemeData.medium,
                            color:
                                themeChange.getThem()
                                    ? AppThemeData.grey50
                                    : AppThemeData.grey900,
                            fontSize: 15,
                          ),
                        ),
                        // widget.button == null
                        //     ? Container(
                        //       decoration: BoxDecoration(
                        //         color: AppThemeData.primary300,
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //           horizontal: 18,
                        //           vertical: 8,
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             Icon(
                        //               Icons.shopping_bag,
                        //               size: 15,
                        //               color: Colors.white,
                        //             ),
                        //             SizedBox(width: 7),
                        //             Text(
                        //               'Add',
                        //               style: TextStyle(
                        //                 fontFamily: AppThemeData.medium,
                        //                 color: Colors.white,
                        //                 fontSize: 12,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //     : (widget.button ?? SizedBox()),
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
}

class OfferCard extends StatelessWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final List<Color> gradientColors;

  const OfferCard({
    super.key,
    required this.image,
    required this.textTop,
    required this.textBottom,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4), // Border thickness
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Image.asset(image, fit: BoxFit.contain)),
              const SizedBox(height: 10),
              Text(
                textTop,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                textBottom,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
