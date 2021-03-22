import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrapper_test/constants.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/scrapping_controller.dart';
import 'package:get/get.dart';

class ScrappingPage extends GetView<ScrappingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
        ),
      ),
      body: Container(
        child: GetX<ScrappingController>(
          init: ScrappingController(),
          builder: (_) {
            return StreamBuilder<List<BasicProductModel>>(
              stream: _.getData(),
              builder:
                  (context, AsyncSnapshot<List<BasicProductModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<BasicProductModel> prolist = snapshot.data ??
                      [
                        BasicProductModel.sampleModel(),
                      ];
                  return Column(
                    children: [
                      Container(
                        height: 50,
                        color: Colors.grey,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              Constants.CATEGORY_LIST['ryans']!.keys.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.ac_unit),
                                onPressed: () {
                                  var category = Constants
                                      .CATEGORY_LIST['ryans']!.entries
                                      .elementAt(index)
                                      .value
                                      .toString();
                                  print(category);
                                  _.setCategory(
                                    category,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: prolist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  print(
                                    '${prolist[index].title.toLowerCase().replaceAll(' ', '-')}',
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text('${prolist[index].title}'),
                                      content: Text('${prolist[index].price}'),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  elevation: MaterialStateProperty.all(1),
                                  splashFactory: InkSplash.splashFactory,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          useOldImageOnUrlChange: true,
                                          imageUrl: '${prolist[index].thumb}',
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text('${prolist[index].title}'),
                                        subtitle: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 1,
                                          ),
                                          child: Text(
                                            '${prolist[index].price}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      FutureBuilder(
                        future: _.checkNextPageAvailibility(),
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          return ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: _.getPageNum() == 1
                                    ? null
                                    : () => _.goToPrevPage(),
                                icon: Icon(Icons.chevron_left),
                              ),
                              Text('Page ${_.getPageNum()}'),
                              IconButton(
                                onPressed: snapshot.data == true
                                    ? () => _.goToNextPage()
                                    : null,
                                icon: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? Center(
                                        child: SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: CircularProgressIndicator
                                              .adaptive(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.chevron_right,
                                      ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
