import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/countries/model/country_model.dart';

import 'countries_view_model.dart';

class ChooseCountriesViewModel extends BaseViewModel {

  List<CountryModel> selectedCountriesList = [];
  bool allSelected = false;

  initOldSelectedCountries(List<CountryModel> selectedCountries) {
    selectedCountriesList.clear();
    selectedCountriesList.addAll(selectedCountries);

    for (var selectedCountry in selectedCountries) {
      selectedCountriesList[selectedCountries.indexOf(selectedCountry)]
          .isSelected = true;
    }
    checkAllSelected();
    setState(ViewState.Idle);
  }

  void onCountrySelected(CountryModel country) {
    if (selectedCountriesList.contains(country)) {
      selectedCountriesList.remove(country);
    } else {
      selectedCountriesList.add(country);
    }

    checkAllSelected();
    setState(ViewState.Idle);
  }

  void checkAllSelected() {
    if (selectedCountriesList.length == currentAllCountriesList.length) {
      allSelected = true;
    } else {
      allSelected = false;
    }
  }

  void setAllSelected(bool? value) {
    allSelected = value ?? false;
    selectedCountriesList.clear();
    if (allSelected) {
      selectedCountriesList.addAll(currentAllCountriesList);
    }
    setState(ViewState.Idle);
  }
}
