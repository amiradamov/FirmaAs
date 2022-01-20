import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firmaac/product/product_cat.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../product/product_info.dart';
import 'package:firmaac/Model/prodModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/material.dart';
import 'package:firmaac/main.dart';
import 'dart:convert';

class ProductPage extends StatefulWidget {
  final String prod_name;
  final String prod_image;
  final String prod_price;
  final String prod_ost;
  ProductPage(this.prod_name, this.prod_image, this.prod_price, this.prod_ost);
  @override
  State<StatefulWidget> createState() {
    return ProductPageState(
        this.prod_name, this.prod_image, this.prod_price, this.prod_ost);
  }
}

class ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  String prod_name;
  String prod_image;
  String prod_price;
  String prod_ost;
  ProductPageState(
      this.prod_name, this.prod_image, this.prod_price, this.prod_ost);
  @override
  Widget _ost1() {
    if (int.parse(prod_ost) > 5) {
      return Row(
        children: const <Widget>[
          Icon(
            Icons.check,
            color: Colors.green,
            size: 15,
          ),
          SizedBox(
            width: 4.0,
          ),
          Text(
            'В наличии',
            style: TextStyle(
              fontSize: 18,
              color: Colors.green,
            ),
          ),
        ],
      );
    }
    return Row(
      children: const <Widget>[
        Icon(
          Icons.check,
          color: Colors.green,
          size: 15,
        ),
        SizedBox(
          width: 4.0,
        ),
        Text(
          'Осталось мало',
          style: TextStyle(fontSize: 18, color: Colors.green),
        ),
      ],
    );
  }

  Widget _ost2() {
    if (int.parse(prod_ost) > 5) {
      return Row(
        children: const <Widget>[
          Text(
            'Осталось:',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 4.0,
          ),
          Text(
            'В наличии',
            style: TextStyle(
              fontSize: 18,
              color: Colors.green,
            ),
          ),
        ],
      );
    }
    return Row(
      children: const <Widget>[
        Text(
          'Осталось:',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 4.0,
        ),
        Text(
          'Осталось мало',
          style: TextStyle(fontSize: 18, color: Colors.green),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
      body: _buildProductDetailsPage(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  _buildProductDetailsPage(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildProductImagesWidgets(),
                _buildProductTitleWidget(),
                SizedBox(height: 12.0),
                _buildPriceWidgets(),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildDetailsAndMaterialWidgets(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildProductImagesWidgets() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 250.0,
        child: Center(
            child: Image.network(
          prod_image,
          fit: BoxFit.cover,
        )),
      ),
    );
  }

  _buildProductTitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            prod_name,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(
            height: 8.0,
          ),
          _ost1()
        ],
      ),
    );
  }

  _buildPriceWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            prod_price + ' ₽',
            style: TextStyle(fontSize: 40.0, color: Colors.black),
          ),
        ],
      ),
    );
  }

  _buildDetailsAndMaterialWidgets() {
    TabController tabController = TabController(length: 2, vsync: this);
    return Container(
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Характеристики",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Наличие",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 180.0,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            'Бренд',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.grey.shade600),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 170,
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text('Другая',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.grey.shade600)),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'г. Махачкала, пр. Петра Первого, 21 (2 этаж)',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '''8 (8722) 78-02-06, 55-55-15 (доб. 510, 511)
С 9:00 до 18:00. Перерыв с 13:00 до 14:00. Выходной: Воскресенье''',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 18),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      _ost2()
                    ],
                  ),
                )
                // Text(
                //   "86% acrylic, 9% polyster, 1% metallic yarn Hand-wash cold",
                //   style: TextStyle(
                //     color: Colors.black,
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBottomNavigationBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.white,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.red,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "В КОРЗИНУ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
