import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class LogoCarousel extends StatelessWidget {
  static final List<Widget> _imgList = [
    Image.asset('assets/images/andrew-s-cat-dog.jpg'),
    Image.asset('assets/images/bonnie-kittle-guinea-pigs.jpg'),
    Image.asset('assets/images/tran-mau-tri-tam-cat.jpg'),
    Image.asset('assets/images/alison-pang-yorkie.jpg')
  ];

  LogoCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: _carouselItems,
        options: CarouselOptions(autoPlay: true, viewportFraction: 1));
  }

  final List<Widget> _carouselItems = _imgList
      .map((item) => Container(
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: item,
          )))
      .toList();
}
