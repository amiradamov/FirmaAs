import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firmaac/Model/prodModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'product/product_info.dart';
import 'product/product_cat.dart';
import 'package:sizer/sizer.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:model/model.dart';
import 'page/categories.dart';


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


    Widget categoryName(String cat_name) {
      return ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            cat_name,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder:(context)=>AboutPage(cat_name)));

          }
          );
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
        body: 
        Container(
          child: Container(
            child: StaggeredGridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              staggeredTiles: [
                // Новинки
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
                captionText("Новинки"),
                myPhotoListBig("products/phone_3.jpg",
                    'Lorem ipsum dolor 12PRO MAX NEW 128 GB', 50000),
                myPhotoListSmall("products/headphones_1.jpg",
                    'Наушники Lorem Ipsum Go', '8000'),
                myPhotoListSmall("products/keyboad_2.jpg",
                    'Kлавиатура Lorem Lor 12 RR Go', '15000'),
                myPhotoListSmall("products/laptop_1.png",
                    'Lorem ipsum dolor 12PRO MAX NEW 128 GB', '15000'),
                myPhotoListSmall("products/keyboard_1.jpg",
                    'Lorem ipsum dolor 12PRO MAX NEW 128 GB', '15000'),
                myPhotoListSmall("products/mause_2.jpg",
                    'Lorem ipsum dolor 12PRO MAX NEW 128 GB', '15000'),
                captionText("Популярные"),
                myPhotoListSmall("products/mause_2.jpg",
                    'Lorem ipsum dolor 12PRO MAX NEW 128 GB', '15000'),
                myPhotoListBig("products/keyboard_1.jpg",
                    'Lorem ipsum dolor 12PRO MAX NEW 128 GB', 15000),
                myPhotoListSmall("products/mause_2.jpg",
                    'Lorem ipsum dolor 12PRO MAX NEW 128 GB', '15000'),
                myPhotoListSmall("products/laptop_1.png",
                    'Lorem ipsum dolor 12PRO MAX NEW 128 GB', '15000'),
                myPhotoListSmall("products/keyboad_2.jpg",
                    'Kлавиатура Lorem Lor 12 RR Go', '15000'),
                myPhotoListSmall("products/headphones_1.jpg",
                    'Наушники Lorem Ipsum Go', '8000'),
                captionText("Сейчас покупают"),
                scrollVertical(),
              ],
              padding: const EdgeInsets.all(5.0),
            ),
          ),
        ),
        drawer: Drawer(
          child: 
          
          ListView(children: <Widget>[
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


  Future<List<ProdModel>>ReadJsonData() async{
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/all_prod1.json');
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