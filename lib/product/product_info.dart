import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../main.dart';

final _controller = PageController();
int activeIndex = 0;

Widget captionText(String titleText) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 18,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                titleText,
                style: TextStyle(color: Colors.black, fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget myPhotoListBig(String MyImages, String Title, int Price) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              // alignment: Alignment.topCenter,
              children: <Widget>[
                Ink.image(
                  height: 200,
                  image: AssetImage(
                    MyImages,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: Text(
                          Title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: Text(
                          Price.toString() + ' ₽',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}

Widget myPhotoListSmall(String MyImages, String Title, String Price) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              // alignment: Alignment.topCenter,
              children: <Widget>[
                Ink.image(
                  height: 70,
                  image: AssetImage(
                    MyImages,
                  ),
                  fit: BoxFit.fitHeight,
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: Text(
                          Title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: Text(
                          Price.toString() + ' ₽',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}

List<CardItem> items = [
  CardItem(
      productImage: 'products/keyboad_2.jpg',
      title: 'Lorem ipsum dolor 12PRO MAX NEW 128 GB',
      subtitle: '5000'),
  CardItem(
      productImage: 'products/phone_3.jpg',
      title: 'Lorem ipsum dolor 12PRO MAX NEW 128 GB',
      subtitle: '40000'),
  CardItem(
      productImage: 'products/headphones_1.jpg',
      title: 'Наушники Lorem Ipsum Go',
      subtitle: '25000'),
  CardItem(
      productImage: 'products/keyboard_1.jpg',
      title: 'LKлавиатура Lorem Lor 12 RR Go',
      subtitle: '3000'),
  CardItem(
      productImage: 'products/mause_2.jpg',
      title: 'Lorem ipsum dolor 12PRO MAX NEW 128 GB',
      subtitle: '15000'),
];

Widget scrollVertical() => Column(
      children: [
        Container(
          height: 140,
          child: ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, _) => SizedBox(
              width: 0,
            ),
            itemBuilder: (context, index) => buildCard(item: items[index]),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        buildIndicator(),
      ],
    );

Widget buildCard({
  required CardItem item,
}) =>
    Card(
      child: InkWell(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Container(
            width: 130,
            height: 200,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    child: Material(
                        child: Ink.image(
                  image: AssetImage(item.productImage),
                  fit: BoxFit.fitHeight,
                  child: InkWell(
                    onTap: () {},
                  ),
                ))),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      child: Text(
                        item.subtitle + ' ₽',
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

class CardItem {
  final String productImage;
  final String title;
  final String subtitle;

  const CardItem({
    required this.productImage,
    required this.title,
    required this.subtitle,
  });
}

Widget buildIndicator() => SmoothPageIndicator(
      controller: _controller,
      count: 2,
      effect: JumpingDotEffect(
        activeDotColor: Colors.red,
        dotColor: Colors.grey,
        dotHeight: 10,
        dotWidth: 10,
        spacing: 16,
        //verticalOffset: 50,
        jumpScale: 2,
      ),
    );

// product page 

