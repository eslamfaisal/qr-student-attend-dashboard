import 'package:qr_attend/locator.dart';
import 'package:qr_attend/screens/categories/model/category_model.dart';
import 'package:qr_attend/screens/categories/viewmodel/categories_view_model.dart';
import 'package:qr_attend/services/navigation_service.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../base_screen.dart';

class ChooseCategoriesDialog extends StatelessWidget {

  ChooseCategoriesDialog();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            // To make the card compact
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bold14Text(tr("search_categories")),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      locator<NavigationService>().goBack();
                    },
                  )
                ],
              ),
              heightSpace(8),
              const Divider(color: Colors.grey),
              heightSpace(8),
              Column(
                children: [
                  ...currentAllCategories
                      .map(
                        (country) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bold14Text(
                                    translatedString(
                                      ar: country.name_ar!,
                                      en: country.name_en!,
                                    ),
                                    color: darkBlueColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).onTap(() {
                          locator<NavigationService>().goBackWithData(country);
                        }),
                      )
                      .toList()
                ],
              ),
              heightSpace(8),
            ],
          ),
        ),
      ),
    );
  }
}
