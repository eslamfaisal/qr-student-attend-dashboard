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
  List<CategoryModel> countries;

  ChooseCategoriesDialog(this.countries);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<CategoriesViewModel>(
      onModelReady: (viewModel) {
      },
      builder: (context, viewModel, _) {
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
                  heightSpace(4),

                  // StyledTextField(
                  //   controller: viewModel.searchController,
                  //   hint: tr('search_country'),
                  //   validator: requiredValidator(),
                  //
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: viewModel.allSelected,
                          onChanged: (value) {
                            viewModel.setAllSelected(value);
                          },
                        ),
                        widthSpace((8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bold14Text(
                              tr('select_all'),
                              color: darkBlueColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  heightSpace(8),
                  Column(
                    children: [
                      ...currentAllCategories
                          .map(
                            (country) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: viewModel.selectedCategoriesList
                                        .contains(country),
                                    onChanged: (value) {
                                      viewModel.onCountrySelected(country);
                                    },
                                  ),
                                  widthSpace((8)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              viewModel.onCountrySelected(country);
                            }),
                          )
                          .toList()
                    ],
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            locator<NavigationService>().goBackWithData(
                                viewModel.selectedCategoriesList);
                          },
                          child: Text(
                            tr('ok'),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
