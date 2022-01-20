import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firmaac/product/product_cat.dart';
import '../product/product_info.dart';
import 'package:firmaac/Model/prodModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/material.dart';
import 'package:firmaac/main.dart';
import 'package:firmaac/page/product.dart';
import 'dart:convert';

class AboutPage extends StatefulWidget {
  final String cat_name;
  AboutPage(this.cat_name);
  @override
  State<StatefulWidget> createState() {
    return AboutPageState(this.cat_name);
  }
}

class AboutPageState extends State<AboutPage> {
  String? selectedValue;
  List<String> items = [
    'Все города',
    'Махачкала',
    'Каспийск',
    'Дербент',
    'Хасавюрт',
  ];

  String cat_name;
  AboutPageState(this.cat_name);
  @override
  Widget build(BuildContext context) {
    Widget productList(
        String MyImages, String Title, String Price, String Ost) {
      double _volume = 0.0;
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ProductPage(Title, MyImages, Price, Ost)));
            },
            child: Container(
              height: 100,
              child: Row(
                children: [
                  Center(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(
                              child:
                                  // Image.asset(MyImages),
                                  Container(
                                child: Ink.image(
                                    image: NetworkImage(MyImages),
                                    fit: BoxFit.fill,
                                    width: 100,
                                    height: 100,
                                    onImageError: (exception, stackTrace) {
                                      print("Image Error:");
                                      print(exception);
                                    }),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ListTile(
                              title: Text(
                                Title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  Price.toString() + ' ₽',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 20.0),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: 8,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    flex: 8,
                  ),
                ],
              ),
            ),
          ),
          margin: EdgeInsets.all(4),
        ),
      );
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
        body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: Text("${data.error}"),
              );
            } else if (data.hasData) {
              var items = data.data as List<ProdModel>;
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    captionText(cat_name),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              // items[index].N_PROD.toString()
                              if (cat_name ==
                                  items[index].GROUP_NAME.toString())
                                productList(
                                    items[index].N_PROD.toString(),
                                    items[index].TOV_NAME.toString(),
                                    items[index].PRICE.toString(),
                                    items[index].OST.toString()),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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
}

Future<List<ProdModel>> ReadJsonData() async {
  final jsondata =
      await rootBundle.rootBundle.loadString('assets/data/all_prod1.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => ProdModel.fromJson(e)).toList();
}
