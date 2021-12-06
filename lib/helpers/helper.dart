import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Helper {

  final BuildContext context;

  Helper(this.context);

  // Build the lists here because the context is needed
  List<String> getBodyList() {
    return [
      '058 ' + AppLocalizations.of(context)!.primary,
      '059 ' + AppLocalizations.of(context)!.secondary,
      '060 ' + AppLocalizations.of(context)!.fp,
      '061 ' + AppLocalizations.of(context)!.eoi,
    ];
  }

  List<String> getPrimaryFunctionsList() {
    return [
      '021 ' + AppLocalizations.of(context)!.ccss,
      '022 ' + AppLocalizations.of(context)!.ccnn,
      '023 ' + AppLocalizations.of(context)!.maths,
      '024 ' + AppLocalizations.of(context)!.cast,
      '025 ' + AppLocalizations.of(context)!.english,
      '026 ' + AppLocalizations.of(context)!.french,
      '027 ' + AppLocalizations.of(context)!.ef,
      '028 ' + AppLocalizations.of(context)!.music,
    ];
  }

  List<String> getSecondaryFunctionsList() {
    return [
      '001 ' + AppLocalizations.of(context)!.filo,
      '002 ' + AppLocalizations.of(context)!.greek,
      '003 ' + AppLocalizations.of(context)!.latin,
      '004 ' + AppLocalizations.of(context)!.cast,
      '005 ' + AppLocalizations.of(context)!.geo_hist,
      '006 ' + AppLocalizations.of(context)!.maths,
      '007 ' + AppLocalizations.of(context)!.fq,
      '008 ' + AppLocalizations.of(context)!.bio_geo,
      '009 ' + AppLocalizations.of(context)!.draw,
      '010 ' + AppLocalizations.of(context)!.french,
      '011 ' + AppLocalizations.of(context)!.english,
      '012 ' + AppLocalizations.of(context)!.german,
      '013 ' + AppLocalizations.of(context)!.music,
      '014 ' + AppLocalizations.of(context)!.economy,
      '015 ' + AppLocalizations.of(context)!.ef,
      '016 ' + AppLocalizations.of(context)!.technology,
    ];
  }

  List<String> getFpFunctionsList() {
    return [
      '101 ' + AppLocalizations.of(context)!.cooking,
      '102 ' + AppLocalizations.of(context)!.electronic,
      '103 ' + AppLocalizations.of(context)!.aesthetic,
      '104 ' + AppLocalizations.of(context)!.installs,
      '105 ' + AppLocalizations.of(context)!.vehicle,
      '106 ' + AppLocalizations.of(context)!.hair,
      '107 ' + AppLocalizations.of(context)!.administration,
      '108 ' + AppLocalizations.of(context)!.community_services,
    ];
  }

  List<String> getEoiFunctionsList() {
    return [
      '201 ' + AppLocalizations.of(context)!.german,
      '202 ' + AppLocalizations.of(context)!.english,
      '203 ' + AppLocalizations.of(context)!.spanish_foreign,
      '204 ' + AppLocalizations.of(context)!.french,
    ];
  }

  // Month list for payroll widget
  List<String> getMonthList() {
    return [
      AppLocalizations.of(context)!.january,
      AppLocalizations.of(context)!.february,
      AppLocalizations.of(context)!.march,
      AppLocalizations.of(context)!.april,
      AppLocalizations.of(context)!.may,
      AppLocalizations.of(context)!.june,
      AppLocalizations.of(context)!.july,
      AppLocalizations.of(context)!.august,
      AppLocalizations.of(context)!.september,
      AppLocalizations.of(context)!.october,
      AppLocalizations.of(context)!.november,
      AppLocalizations.of(context)!.december
    ];
  }

  Map<String, String> getCodeList() {
    return {
      '001' : AppLocalizations.of(context)!.filo,
      '002' : AppLocalizations.of(context)!.greek,
      '003' : AppLocalizations.of(context)!.latin,
      '004' : AppLocalizations.of(context)!.cast,
      '005' : AppLocalizations.of(context)!.geo_hist,
      '006' : AppLocalizations.of(context)!.maths,
      '007' : AppLocalizations.of(context)!.fq,
      '008' : AppLocalizations.of(context)!.bio_geo,
      '009' : AppLocalizations.of(context)!.draw,
      '010' : AppLocalizations.of(context)!.french,
      '011' : AppLocalizations.of(context)!.english,
      '012' : AppLocalizations.of(context)!.german,
      '013' : AppLocalizations.of(context)!.music,
      '014' : AppLocalizations.of(context)!.economy,
      '015' : AppLocalizations.of(context)!.ef,
      '016' : AppLocalizations.of(context)!.technology,
      '021' : AppLocalizations.of(context)!.ccss,
      '022' : AppLocalizations.of(context)!.ccnn,
      '023' : AppLocalizations.of(context)!.maths,
      '024' : AppLocalizations.of(context)!.cast,
      '025' : AppLocalizations.of(context)!.english,
      '026' : AppLocalizations.of(context)!.french,
      '027' : AppLocalizations.of(context)!.ef,
      '028' : AppLocalizations.of(context)!.music,
      '101' : AppLocalizations.of(context)!.cooking,
      '102' : AppLocalizations.of(context)!.electronic,
      '103' : AppLocalizations.of(context)!.aesthetic,
      '104' : AppLocalizations.of(context)!.installs,
      '105' : AppLocalizations.of(context)!.vehicle,
      '106' : AppLocalizations.of(context)!.hair,
      '107' : AppLocalizations.of(context)!.administration,
      '108' : AppLocalizations.of(context)!.community_services,
      '201' : AppLocalizations.of(context)!.german,
      '202' : AppLocalizations.of(context)!.english,
      '203' : AppLocalizations.of(context)!.spanish_foreign,
      '204' : AppLocalizations.of(context)!.french,
    };
  }

  // this functions returns the localized string for the job type, example 1 -> Vacant if locale Code is 'ca' (Catalan)
  getTypeString(String type) {
    String typeString;
    type == '0' ? typeString = AppLocalizations.of(context)!.substitution : typeString = AppLocalizations.of(context)!.vacant;
    return typeString;
  }

  // this functions returns the localized string for the functionCode, example 006 -> Matemàtiques if locale Code is 'ca' (Catalan)
  getFunctionString(String functionCode) {
    return getCodeList()[functionCode];
  }

  getBodyString(String bodyCode) {
    String bodyString = "N/A"; // not available
    switch (bodyCode) {
      case '':
        // Primary school
        bodyString = AppLocalizations.of(context)!.primary;
        break;
      case '059':
        // Secondary school
        bodyString = AppLocalizations.of(context)!.secondary;
        break;
      case '060':
        // Fp school
        bodyString = AppLocalizations.of(context)!.fp;
        break;
      case '061':
        // Eoi school
        bodyString = AppLocalizations.of(context)!.eoi;
        break;
    }
    return bodyString;
  }

  Map<String, String> getCepList() {
    return {
      AppLocalizations.of(context)!.formentera_cep : '0',
      AppLocalizations.of(context)!.ibiza_cep : '1',
      AppLocalizations.of(context)!.mallorca_cep : '2',
      AppLocalizations.of(context)!.menorca_cep : '3'
    };
  }

  getCepCode(String cepString) {
    return getCepList()[cepString];
  }

}