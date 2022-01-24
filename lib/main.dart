import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart' as rootBundle;
// import 'package:responsive_grid/responsive_grid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firmaac/Model/prodModel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'product/product_info.dart';
import 'product/product_cat.dart';
// import 'package:sizer/sizer.dart';
import 'dart:async' show Future;
import 'dart:convert';
// import 'package:model/model.dart';
import 'page/categories.dart';
import 'package:firmaac/page/product.dart';
import 'package:firmaac/Model/ProductModel.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductModel> cart = [];

  final urlImages = [
    'assets/slider1.jpg',
    'assets/slider2.jpg',
    'assets/slider3.jpg',
  ];
  // final cityName = [
  //   'Все города',
  //   'Махачкала',
  //   'Каспийск',
  //   'Дербент',
  //   'Хасавюрт',
  // ];
  String? selectedValue;
  List<String> items = [
    'Все города',
    'Махачкала',
    'Каспийск',
    'Дербент',
    'Хасавюрт',
  ];

  @override
  Widget build(BuildContext context) {
    Widget myPhotoListBig(
        String MyImages, String Title, String Price, String Ost) {
      return Card(
          child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductPage(Title, MyImages, Price, Ost)));
        },
        child: Column(
          children: [
            Container(
              height: 200.0,
              width: 200.0,
              child: Ink.image(
                image: NetworkImage(MyImages),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                Title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(Price.toString() + ' ₽',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20.0)),
                  SizedBox(
                    width: 140.0,
                  ),
                  Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  )
                ],
              ),
            )
          ],
        ),
      ));
    }

    Widget myPhotoListSmall(
        String MyImages, String Title, String Price, String Ost) {
      return Card(
          child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductPage(Title, MyImages, Price, Ost)));
        },
        child: Column(
          children: [
            Container(
              height: 80.0,
              width: 80.0,
              child: Ink.image(
                image: NetworkImage(MyImages),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                Title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(Price.toString() + ' ₽',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 15.0)),
                  SizedBox(
                    width: 30.0,
                  ),
                  Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  )
                ],
              ),
            )
          ],
        ),
      ));
    }

    Widget categoryName(String cat_name) {
      return ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            cat_name,
          ),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AboutPage(cat_name)));
          });
    }

    Widget categoryProduct() {
      return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          for (var cat in cats) categoryName(cat),
        ],
      );
    }

    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.red),
          title: InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MyHomePage()));
            },
            child: Ink.image(
              image: AssetImage('assets/logo.png'),
              width: 40,
              height: 40,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: StaggeredGridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  staggeredTiles: [
                    // Новинки
                    StaggeredTile.extent(3, 180),
                    StaggeredTile.extent(3, 60),
                    StaggeredTile.count(2, 2),
                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(1, 1),
                    // Популярные
                    StaggeredTile.extent(3, 60),
                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(2, 2),
                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(1, 1),

                    // Horizontal Scroll
                    StaggeredTile.extent(3, 60),
                    StaggeredTile.extent(3, 180),
                    StaggeredTile.extent(3, 60),
                  ],
                  children: <Widget>[
                    ListView(
                      children: [
                        CarouselSlider(
                          items: [
                            //2nd Image of Slider
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1637762646946-8273c74c25ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            //4th Image of Slider
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1639675973843-027a10e2f5a9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            //5th Image of Slider
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1560692901-45d529ed05bf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],

                          //Slider Container properties
                          options: CarouselOptions(
                            height: 180.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                        ),
                      ],
                    ),
                    captionText("Новинки"),
                    myPhotoListBig(
                        "http://www.firmaac.ru//upload/img/77283i0_b.jpg",
                        'Кондиционер Supra Classic US410-12HAI (3.2 кВт, холод/тепло) ',
                        "13500",
                        "1"),
                    myPhotoListSmall(
                        "http://www.firmaac.ru//upload/img/s42607i0_b.jpg",
                        'Стол компьютерный НСС 9, яблоня-локарно (800*600*1430)',
                        '6210',
                        '1'),
                    myPhotoListSmall(
                        "http://www.firmaac.ru//upload/img/s90685i0_b.jpg",
                        'Пылесос LG VK76W02HY (380/2000Вт, циклон, серый/серебристый)',
                        '9620',
                        '1'),
                    myPhotoListSmall(
                        "http://www.firmaac.ru//upload/img/87548i0_b.jpg",
                        'Фен Philips BHD006/00 (1600Вт, белый)',
                        '1570',
                        '1'),
                    myPhotoListSmall(
                        "http://chelny.biomed-mc.ru/upload/iblock/06d/nophoto.jpg",
                        'Фен BBK BHD1602I (1600Вт, черный)',
                        '900',
                        '7'),
                    myPhotoListSmall(
                        "http://www.firmaac.ru//upload/img/86021i0_b.jpg",
                        'Щипцы для завивки волос Philips BHH777/00',
                        '1950',
                        '1'),
                    captionText("Популярные"),
                    myPhotoListSmall(
                        "http://www.firmaac.ru//upload/img/77393i0_b.jpg",
                        'Соковыжималка центробежная Gorenje JC650W (650 Вт, 1.5 л, белая)',
                        '2400',
                        '1'),
                    myPhotoListBig(
                        "http://www.firmaac.ru//upload/img/54156i0_b.jpg",
                        'Кондиционер Mitsubishi SRK/SRC 20HG-S (2.0 кВт, тепло/холод) ',
                        "32000",
                        "1"),
                    myPhotoListSmall(
                        "http://www.firmaac.ru//upload/img/s100245i0_b.jpg",
                        'Соковыжималка шнековая Kitfort KT-1101-2 (150Вт, бордовая)',
                        '6330',
                        '8'),
                    myPhotoListSmall(
                        "http://www.firmaac.ru//upload/img/s106889i0_b.jpg",
                        'Кофемашина Bosch Tassimo TAS1403 (1300Вт/0.7 л/эспрессо/капучино/горячий шоколад/фруктовый и зеленый чай/контроль крепости/цвет: красный)',
                        '3940',
                        '1'),
                    myPhotoListSmall(
                        "http://www.firmaac.ru//upload/img/s100326i0_b.jpg",
                        'Чайник Kitfort KT-633-2 (1.7л, 2150Вт, металл/пластик, красный)',
                        '2820',
                        '1'),
                    myPhotoListSmall(
                        "http://www.firmaac.ru//upload/img/s101162i0_b.jpg",
                        'Чайник Tefal KO150130 (1.5л, 2400Вт, пластик, белый)',
                        '2860',
                        '2'),
                    captionText("Сейчас покупают"),
                    scrollVertical(),
                  ],
                  padding: const EdgeInsets.all(5.0),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(children: <Widget>[
            ListTile(
                leading: const Icon(Icons.person),
                title: new Text('Акаунт'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AboutPage('')));
                }),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.location_city, color: Colors.grey.shade600),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        items[0],
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 220,
                      itemHeight: 40,
                      itemWidth: 140,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.red,
            ),
            categoryProduct(),
          ]),
        ));
  }

  Future<List<ProdModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/data/all_prod1.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => ProdModel.fromJson(e)).toList();
  }

  Widget buildImage(String urlImage, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      color: Colors.grey,
      child: Image.asset(
        urlImage,
        fit: BoxFit.fill,
      ));
}
