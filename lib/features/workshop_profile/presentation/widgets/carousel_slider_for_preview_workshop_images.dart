import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderForPreviewWorkshopImages extends StatelessWidget {
  const CarouselSliderForPreviewWorkshopImages(
      {super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.33,
        viewportFraction: 1.0,
      ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(
                    i,
                  ),
                  fit: BoxFit.fill,
                  onError: (e, stackTrace) {
                    print(e);
                  },
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
