import 'dart:async';

import 'package:air_menu_ai_app/themes/responsive.dart';
import 'package:air_menu_ai_app/utils/network_image_widget.dart';
import 'package:flutter/material.dart';

class RestaurantImageView extends StatefulWidget {
  const RestaurantImageView({super.key});

  @override
  State<RestaurantImageView> createState() => _RestaurantImageViewState();
}

class _RestaurantImageViewState extends State<RestaurantImageView> {
  int currentPage = 0;

  PageController pageController = PageController(initialPage: 1);

  @override
  void initState() {
    animateSlider();
    super.initState();
  }

  List photos = [
    "https://t3.ftcdn.net/jpg/03/25/35/08/360_F_325350805_D8PVU73qs1dj5TdWgm9IpuAjJ7sgHacK.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4QJQTNU5ehJTUEu-kprjY0sm8yozQ2wN16tFp4MA9MPIIhDjt25yVpBpk1r3J_m6_fR8&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT72XA-2H_nx6nYT15JxLSlRJJvI1xbqTyZ1Zzi1cLZEHJBl__ElU8LcOrmsx95FHsf9pQ&usqp=CAU",
    "https://media.istockphoto.com/id/1309352410/photo/cheeseburger-with-tomato-and-lettuce-on-wooden-board.jpg?s=612x612&w=0&k=20&c=lfsA0dHDMQdam2M1yvva0_RXfjAyp4gyLtx4YUJmXgg=",
    "https://parade.com/.image/t_share/MjAwMjQwOTU4NDg1MzA4NTI0/what-happens-if-you-eat-a-burger-every-day.jpg",
  ];

  void animateSlider() {
    if (photos.isNotEmpty) {
      if (photos.length > 1) {
        Timer.periodic(const Duration(seconds: 2), (Timer timer) {
          if (currentPage < photos.length - 1) {
            currentPage++;
          } else {
            currentPage = 0;
          }
          if (pageController.hasClients) {
            pageController.animateToPage(
              currentPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height(20, context),
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.horizontal,
        allowImplicitScrolling: true,
        itemCount: photos.length,
        padEnds: false,
        pageSnapping: true,
        itemBuilder: (BuildContext context, int index) {
          return NetworkImageWidget(
            imageUrl: photos[index].toString(),
            fit: BoxFit.cover,
            height: Responsive.height(20, context),
            width: Responsive.width(100, context),
          );
        },
      ),
    );
  }
}
