import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/locator.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/categories/model/category_model.dart';
import 'package:qr_attend/screens/categories/viewmodel/category_dialog_view_model.dart';
import 'package:qr_attend/services/navigation_service.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:qr_attend/widgets/styled_text_field.dart';

import '../../base_screen.dart';

class CategoryDialogWidget extends StatelessWidget {
  CategoryModel? categoryModel;
  bool? isNewCategory = true;

  CategoryDialogWidget({@required this.isNewCategory, this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return BaseScreen<CategoryDialogViewModel>(
      onModelReady: (viewModel) {
        if (!isNewCategory!) {
          viewModel.titleARController.text = categoryModel!.name_ar!;
          viewModel.titleENController.text = categoryModel!.name_en!;
          viewModel.priorityController.text = categoryModel!.priority!.toString();
        }
      },
      builder: (c, viewModel, _) {
        return SingleChildScrollView(
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bold14Text(tr('add_new_category')),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        locator<NavigationService>().goBack();
                      },
                    )
                  ],
                ),
                heightSpace(8),
                Divider(color: Colors.grey),
                heightSpace(4),
                StyledTextField(
                  controller: viewModel.titleARController,
                  hint: tr('title_ar'),
                  validator: requiredValidator(),
                ),
                heightSpace(8),
                StyledTextField(
                  controller: viewModel.titleENController,
                  hint: tr('title_en'),
                  validator: requiredValidator(),
                ),
                heightSpace(8),
                StyledTextField(
                  controller: viewModel.priorityController,
                  hint: tr('priority'),
                  validator: requiredValidator(),
                ),
                heightSpace(8),
                heightSpace(16),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      viewModel.state == ViewState.Busy
                          ? const CircularProgressIndicator()
                          : TextButton(
                              onPressed: () async {
                                Resource<CategoryModel>? response;
                                if (!isNewCategory!) {
                                  response = await viewModel.updateAd(categoryModel!);
                                } else {
                                  response = await viewModel.createNewAd();
                                }

                                if (response.status == Status.ERROR) {
                                  final snackBar = SnackBar(
                                      content: Text(response.errorMessage!));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                      content:
                                          Text(tr('created_successfully')));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context, response.data);
                                }
                              },
                              child: Text(
                                tr(isNewCategory! ? 'create' : 'update'),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      VerticalDivider(),
                      TextButton(
                        onPressed: () {
                          locator<NavigationService>().goBack();
                        },
                        child: Text(
                          tr('cancel'),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
