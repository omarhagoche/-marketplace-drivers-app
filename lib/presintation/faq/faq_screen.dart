import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/drawer.dart';
import '../widgets/faq_item.dart';
import '../widgets/loading_widget.dart';
import 'faq_controller.dart';

class FaqScreen extends GetView<FaqController> {
  const FaqScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>controller.faqs.isEmpty
        ? Scaffold(
      body: LoadingWidget(),
    )
        : DefaultTabController(
      length: controller.faqs.length,
      child: Scaffold(
        key: controller.scaffoldKey,
        drawer: DrawerWidget(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).focusColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          bottom: TabBar(
            tabs: List.generate(controller.faqs.length, (index) {
              return Tab(text: controller.faqs.elementAt(index).name ?? '');
            }),
            labelColor: Theme.of(context).primaryColor,
          ),
          title: Text(
            'faq'.tr,
            style: Theme.of(context).textTheme.headline6!.merge(TextStyle(letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: controller.refreshFaqs,
          child: TabBarView(
            children: List.generate(controller.faqs.length, (index) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 15),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        Icons.help,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'help_supports'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.faqs.elementAt(index).faqs!.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 15);
                      },
                      itemBuilder: (context, indexFaq) {
                        return FaqItemWidget(faq: controller.faqs.elementAt(index).faqs!.elementAt(indexFaq));
                      },
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      ),
    );
  }
}
