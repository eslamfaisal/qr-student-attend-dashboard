import 'package:qr_attend/screens/countries/model/country_model.dart';
import 'package:qr_attend/screens/countries/view/country_dialog_widget.dart';
import 'package:qr_attend/screens/countries/viewmodel/countries_view_model.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CountryItemWidget extends StatelessWidget {
  final int index;
  final CountriesViewModel viewModel;

  CountryItemWidget(this.index, this.viewModel);

  @override
  Widget build(BuildContext context) {
    CountryModel country = currentAllCountriesList[index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: bold14Text(
                    notNullString(country.name_ar),
                  ),
                ),
              ),
              const VerticalDivider(),
              Expanded(
                flex: 1,
                child: Center(
                  child: bold14Text(
                    notNullString(country.name_en),
                  ),
                ),
              ),
              const VerticalDivider(),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: primaryColor,
                    ).onTap(() async {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: CountryDialogWidget(
                            isNewCategory: false,
                            countryModel: currentAllCountriesList[index],
                          ),
                        ),
                      );
                    }),
                    widthSpace(8),
                    Icon(
                      Icons.delete,
                      color: primaryColor,
                    ).onTap(
                      () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(tr('delete_category_msg')),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: bold14Text(tr('cancel'),
                                      color: primaryColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    viewModel.deleteCountry(index);
                                    final snackBar = SnackBar(
                                        content:
                                            Text(tr('deleted_successfully')));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Navigator.pop(context, false);
                                  }, // passing true
                                  child: normal14Text(tr('delete')),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
