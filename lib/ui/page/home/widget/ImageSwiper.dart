import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

var images = [
  'assets/images/plant_1.jpg',
  'assets/images/plant_2.jpg',
  'assets/images/plant_3.jpg'
];

Swiper imageSwiper(context, constraints) {
  return new Swiper(
    autoplay: true,
    autoplayDelay: 5000,
    itemBuilder: (BuildContext context, int index) {
      return new ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            images[index],
            fit: BoxFit.fill,
          ));
    },
    pagination: new SwiperPagination(
        builder:
            DotSwiperPaginationBuilder(color: Color(0xffD2EDE3), activeColor: Color(0xff0C9359))),
    itemCount: images.length,
    viewportFraction: 0.75,
    scale: 0.9,
  );
}
