import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  
  Future<List<Widget>> createList(BuildContext context) async {
    List<Widget> items = [];
    try {
      String dataString =
          await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJSON = jsonDecode(dataString);

      for (var object in dataJSON) {
        if (object.containsKey("placeItems") &&
            object.containsKey("placeImage") &&
            object.containsKey("placeName") &&
            object.containsKey("minOrder")) {
          String finalString = object["placeItems"].join(" | ");

          items.add(
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      child: Image.asset(
                        object["placeImage"],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(object["placeName"]),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0, bottom: 2.0),
                              child: Text(
                                finalString,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            Text(
                              "Min. Order: ${object["minOrder"]}",
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                    ),
                    const Text(
                      "Foodies",
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              BannerWidgetArea(),
              FutureBuilder(
                future: createList(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return snapshot.data?[index];
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(
          MdiIcons.food,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BannerWidgetArea extends StatelessWidget {
  final List<String> bannerItems = [
    "Burger",
    "Cheese Chilly",
    "Noodles",
    "Pizza"
  ];
  final List<String> bannerImage = [
    "images/burger.jpg",
    "images/cheesechilly.jpg",
    "images/noodles.jpg",
    "images/pizza.jpg"
  ];
   PageController controller =
        PageController(viewportFraction: 0.8, initialPage: 1);

  BannerWidgetArea({super.key});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    List<Widget> banners = [];

    for (int x = 0; x < bannerItems.length; x++) {
      var bannerView = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Image.asset(
                bannerImage[x],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bannerItems[x],
                    style:
                        const TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  const Text(
                    "More than 40% Off",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      );
      banners.add(bannerView);
    }

    return SizedBox(
      width: screenWidth,
      height: screenWidth * 9 / 16,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}
