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
    return Container(
      child: GetX<ScrappingController>(
        init: ScrappingController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[700],
              title: Text(
                _.getCategoryHR(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              centerTitle: true,
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: SizedBox(
                      height: 30,
                      child: Image.asset(
                        'assets/images/thumbnails/${_.getCategory().toString()}.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: SizedBox(
                      height: 30,
                      child: Image.asset(
                        'assets/images/site_logo/${_.getWebSite().toString()}.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: Constants.CATEGORY_LIST.keys.length,
                        itemBuilder: (context, index) {
                          var site =
                              Constants.WEBSITE_LIST.entries.elementAt(index);
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  child: Image.asset(
                                    'assets/images/site_logo/${site.key.toString()}.png',
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    child: Text(
                                      site.value.toString(),
                                    ),
                                    onPressed: () {
                                      var sitekey = site.key.toString();

                                      _.setWebSite(sitekey);
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                        _.getWebSite() ==
                                                Constants.WEBSITE_LIST.entries
                                                    .elementAt(index)
                                                    .key
                                                    .toString()
                                            ? Colors.grey[800]
                                            : Colors.grey[600],
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: Constants
                            .CATEGORY_LIST[_.getWebSite()]!.keys.length,
                        itemBuilder: (context, index) {
                          var category = Constants
                              .CATEGORY_LIST[_.getWebSite()]!.entries
                              .elementAt(index)
                              .key
                              .toString();
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[300] as Color,
                                  width: 2,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: Image.asset(
                                    'assets/images/thumbnails/${category.toString()}.png',
                                  ).image,
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      _.setCategory(
                                        category,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      _.getCategoryHR(
                                        category.capitalize.toString(),
                                      ),
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                        _.getCategory().capitalize ==
                                                Constants
                                                    .CATEGORY_LIST[
                                                        _.getWebSite()]!
                                                    .entries
                                                    .elementAt(index)
                                                    .key
                                                    .capitalize
                                                    .toString()
                                            ? Colors.grey[800]
                                            : Colors.grey[600],
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: StreamBuilder<List<BasicProductModel>>(
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
                      FutureBuilder<bool>(
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
            ),
          );
        },
      ),
    );
  }
}
