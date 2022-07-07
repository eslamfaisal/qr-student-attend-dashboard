import 'package:qr_attend/routs/routs_names.dart';
import 'package:qr_attend/screens/navigation/widgets/drawer_item_widget.dart';
import 'package:qr_attend/screens/navigation/widgets/pop_up_item.dart';
import 'package:qr_attend/services/navigation_service.dart';
import 'package:qr_attend/services/shared_pref_services.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/shared_preferences_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';
import '../navigation_index.dart';

class NavigationContainer extends StatefulWidget {
  final Widget child;
  final int initialIndex;

  NavigationContainer(this.child, this.initialIndex);

  @override
  _NavigationContainerState createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(
        vsync: this, length: 11, initialIndex: widget.initialIndex)
      ..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.green),
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width < 1300 ? true : false,
        title: Image.asset('assets/images/ic_logo.png'),
        actions: <Widget>[
          const SizedBox(width: 16),
          PopupMenuButton(
            tooltip: tr('settings'),
            icon: const SizedBox(
              height: 50,
              width: 50,
              child: Icon(
                Icons.settings,
              ),
            ),
            itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: tr('change_language_string_key'),
                child: PopUpItemWidget(
                    tr('current_language_name') == 'ar' ? "English" : 'عربي',
                    Icons.language),
              ),
              PopupMenuItem<String>(
                value: tr('logout'),
                child: PopUpItemWidget(tr('logout'), Icons.logout),
              ),
            ],
            onSelected: (selected) async {
              if (selected == tr('logout')) {
                locator<SharedPrefServices>().clear();
                locator<NavigationService>()
                    .navigateToAndClearStack(RouteName.LOGIN);
              } else if (selected == tr('change_language_string_key')) {
                if (context.locale == const Locale('ar', 'EG')) {
                  context.setLocale(const Locale('en', 'US'));
                } else {
                  context.setLocale(const Locale('ar', 'EG'));
                }
              }
            },
          ),
          const SizedBox(width: 16),
        ],
        // automaticallyImplyLeading: false,
      ),
      body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1300
              ? Container()
              : Card(
                  elevation: 2.0,
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    height: MediaQuery.of(context).size.height,
                    width: 300,
                    color: Colors.white,
                    child: getMenuItemsWidget(),
                  ),
                ),
          Container(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 310,
            child: widget.child,
          )
        ],
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(top: 56),
        child: Drawer(
          child: getMenuItemsWidget(),
        ),
      ),
    );
  }

  Widget getMenuItemsWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        listDrawerItems(),
      ],
    );
  }

  Widget listDrawerItems() {
    return ListView(
      physics: const BouncingScrollPhysics(), // shrinkWrap: true,
      children: <Widget>[
        DrawerItemWidget(
          tr("countries"),
          tabController!.index == COUNTRIES_INDEX
              ? Colors.deepOrange[200]!
              : Colors.white,
          () {
            locator<NavigationService>().navigateTo(RouteName.COUNTIRES_SCREEN);
          },
          Icon(
            Icons.category,
            color: primaryColor,
            size: 26,
          ),
        ),
        DrawerItemWidget(
          tr("categories"),
          tabController!.index == CATEGORIES_INDEX
              ? Colors.deepOrange[200]!
              : Colors.white,
          () {
            locator<NavigationService>()
                .navigateTo(RouteName.CATEGORIES_SCREEN);
          },
          Icon(
            Icons.category,
            color: primaryColor,
            size: 26,
          ),
        ),
        DrawerItemWidget(
          tr("stores"),
          tabController!.index == STORES_INDEX
              ? Colors.deepOrange[200]!
              : Colors.white,
          () {
            locator<NavigationService>().navigateTo(RouteName.STORES_SCREEN);
          },
          Icon(
            Icons.store,
            color: primaryColor,
            size: 26,
          ),
        ),
        DrawerItemWidget(
          tr("coupon_and_offers"),
          tabController!.index == COUPONS_OFFERS_INDEX
              ? Colors.deepOrange[200]!
              : Colors.white,
          () {
            locator<NavigationService>()
                .navigateTo(RouteName.COUPONS_OFFERS_SCREEN);
          },
          Icon(
            Icons.store,
            color: primaryColor,
            size: 26,
          ),
        ),
        DrawerItemWidget(
          tr("notifications"),
          tabController!.index == NOTIFICATIONS_INDEX
              ? Colors.deepOrange[200]!
              : Colors.white,
          () {
            locator<NavigationService>()
                .navigateTo(RouteName.NOTIFICATIONS_SCREEN);
          },
          Icon(
            Icons.store,
            color: primaryColor,
            size: 26,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }
}
