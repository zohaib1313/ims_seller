import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ims_seller/common_widgets/app_popups.dart';
import 'package:ims_seller/common_widgets/common_widgets.dart';
import 'package:ims_seller/models/search_result_model.dart';
import 'package:ims_seller/view_models/search_customer_view_model.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../styles.dart';

class SearchCustomerScreen extends StatefulWidget {
  SearchCustomerScreen({Key? key}) : super(key: key);
  static const id = "SearchCustomerId";

  @override
  _SearchCustomerScreenState createState() => _SearchCustomerScreenState();
}

class _SearchCustomerScreenState extends State<SearchCustomerScreen> {
  Stream<List<SearchResultModel>>? streamSearch;
  var view = Provider.of<SearchCustomerViewModel>(myContext!);

  @override
  void initState() {
    streamSearch = view.streamController.stream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        view.resetState();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(120.r),
            child: Column(
              children: [
                getHeader(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 150.h),
                      Text(
                        'Search Customer',
                        style: AppTextStyles.largeBold
                            .copyWith(color: AppColor.blackColor),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Add customer mobile number\nto check the customer registration',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.small.copyWith(
                            color: AppColor.blackColor, wordSpacing: 1.5),
                      ),
                      SizedBox(height: 50.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(25.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColor.blackColor)),
                            child: Text(
                              '+959',
                              style: AppTextStyles.small
                                  .copyWith(color: AppColor.blackColor),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: MyTextField(
                              rightPadding: 0,
                              controller: view.searchTextEditingController,
                              leftPadding: 0,
                              hintText: 'Enter Mobile Number',
                              onChanged: (String text) {
                                print("text   $text");
                                if (text.isNotEmpty) {
                                  streamSearch = view.getSearchResult();
                                } else {
                                  view.streamController.sink.add([]);
                                }

                                /*   if (text.isNotEmpty) {
                                  setState(() {
                                    isSearching = true;
                                  });
                                } else {
                                  setState(() {
                                    isSearching = false;
                                  });
                                }*/
                              },
                            ),
                          ),
                        ],
                      ),
                      showSearchList()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSearchList() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.blackColor),
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: StreamBuilder(
                    stream: streamSearch,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<SearchResultModel>> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (!snapshot.hasData && snapshot.error != null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData && snapshot.data != null) {
                        var list = snapshot.data!;
                        return list.isNotEmpty
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            view.resetState();
                                            view.streamController.sink.add([]);
                                          },
                                          child: Icon(Icons.cancel)),
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        return getSearchItem(
                                            list[index].name.toString(),
                                            list[index].phone.toString());
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : view.searchTextEditingController.text.isNotEmpty
                                ? Center(
                                    child: Text('No data found',
                                        style: AppTextStyles.mediumBold
                                            .copyWith(
                                                color: AppColor.blackColor)),
                                  )
                                : Center(
                                    child: Container(
                                      padding: EdgeInsets.all(80.r),
                                      decoration: BoxDecoration(
                                          color: AppColor.blueColor,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (view.searchTextEditingController
                                              .text.isNotEmpty) {
                                            streamSearch =
                                                view.getSearchResult();
                                          } else {
                                            AppPopUps().showSnackBar(
                                                'Enter number to search');
                                          }
                                        },
                                        child: Icon(
                                          Icons.search,
                                          size: 100.r,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                    ),
                                  );
                      } else {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(80.r),
                            decoration: BoxDecoration(
                                color: AppColor.blueColor,
                                borderRadius: BorderRadius.circular(100)),
                            child: GestureDetector(
                              onTap: () {
                                if (view.searchTextEditingController.text
                                    .isNotEmpty) {
                                  streamSearch = view.getSearchResult();
                                } else {
                                  AppPopUps()
                                      .showSnackBar('Enter number to search');
                                }
                              },
                              child: Icon(
                                Icons.search,
                                size: 100.r,
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getSearchItem(String title, String number) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toString()),
        Text(number.toString()),
        const Divider(
          color: AppColor.blackColor,
        )
      ],
    );
  }

  getHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            view.resetState();
            Navigator.of(myContext!).pop();
          },
          child: const SvgViewer(
            svgPath: 'assets/icons/icon-close.svg',
            height: 20,
            width: 20,
            color: AppColor.blackColor,
          ),
        ),
        SizedBox(width: 100.w),
        Text(
          "Sale Invoice",
          style: AppTextStyles.large.copyWith(color: AppColor.blackColor),
        )
      ],
    );
  }
}
