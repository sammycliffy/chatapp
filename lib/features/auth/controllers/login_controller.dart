import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_number/phone_number.dart';
import 'package:speso_chatapp/features/auth/views/countries.dart';
import 'package:speso_chatapp/shared/utils/abc.dart';
import 'package:speso_chatapp/shared/widgets/dialogs.dart';
import 'package:speso_chatapp/theme/theme.dart';

import '../../../shared/models/user.dart';

final countryPickerControllerProvider =
    StateNotifierProvider.autoDispose<CountryPickerController, List<Country>>(
  (ref) => CountryPickerController(ref),
);

final defaultCountryProvider = Provider(
  (ref) => Country(
    phoneCode: '234',
    countryCode: 'NG',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Nigeria',
    example: '7062975416',
    displayName: 'Nigeria (NG) [+234]',
    fullExampleWithPlusSign: '+2347062975416',
    displayNameNoCountryCode: 'Nigeria (NG)',
    e164Key: '234-NG-0',
  ),
);

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, Country>(
  (ref) => LoginController(ref),
);

class CountryPickerController extends StateNotifier<List<Country>> {
  final AutoDisposeStateNotifierProviderRef ref;
  late final TextEditingController searchController;
  late final List<Country> _countries;
  CountryPickerController(this.ref) : super(countriesList);

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void init() {
    searchController = TextEditingController();
    _countries = countriesList;
  }

  void initialUpdate() {
    final selectedCountry = ref.read(loginControllerProvider);

    state = [
      selectedCountry,
      ...countriesList.where((country) => country != selectedCountry).toList()
    ];
  }

  void onCrossPressed() {
    searchController.clear();
    state = _countries;
  }

  void setCountry(BuildContext context, Country country) {
    ref
        .read(loginControllerProvider.notifier)
        .updateSelectedCountry(country, true)
        .whenComplete(() => Navigator.of(context).pop());
  }

  void updateSearchResults(String query) {
    query = query.toLowerCase().trim();
    state = _countries
        .where(
          (country) => country.name.toLowerCase().startsWith(query),
        )
        .toList();
  }
}

class LoginController extends StateNotifier<Country> {
  final AutoDisposeStateNotifierProviderRef ref;

  late PhoneNumberEditingController phoneNumberController;
  late final TextEditingController phoneCodeController;
  LoginController(this.ref) : super(ref.read(defaultCountryProvider));

  @override
  void dispose() {
    phoneNumberController.dispose();
    phoneCodeController.dispose();
    super.dispose();
  }

  void init(phoneNumberListener) {
    phoneCodeController = TextEditingController(
      text: state.phoneCode,
    );
    phoneNumberController = PhoneNumberEditingController(
      PhoneNumberUtil(),
      regionCode: state.countryCode,
      behavior: PhoneInputBehavior.strict,
    );

    phoneNumberController.addListener(phoneNumberListener);
  }

  void onNextBtnPressed(context) async {
    final colorTheme = Theme.of(context).custom.colorTheme;

    String phoneNumberWithCode =
        '+${state.phoneCode} ${phoneNumberController.text}';

    bool isValidPhoneNumber = false;
    try {
      isValidPhoneNumber =
          await PhoneNumberUtil().validate(phoneNumberWithCode);
    } catch (_) {
      // ...
    }

    String errorMsg = '';
    if (state.name == 'No such country') {
      errorMsg = 'Invalid country code.';

      if (isValidPhoneNumber) {
        isValidPhoneNumber = !isValidPhoneNumber;
      }
    }

    if (!isValidPhoneNumber) {
      if (errorMsg.isEmpty) {
        errorMsg = ref
                .read(loginControllerProvider.notifier)
                .phoneNumberController
                .text
                .isEmpty
            ? 'Please enter your phone number.'
            : 'The phone number your entered is invalid '
                'for the country: ${state.name}';
      }

      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.all(0),
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? colorTheme.appBarColor
                : colorTheme.backgroundColor,
            content: Text(
              errorMsg,
              style: TextStyle(
                color: colorTheme.greyColor,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: colorTheme.greenColor,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? colorTheme.appBarColor
              : colorTheme.backgroundColor,
          actionButtonTextColor: colorTheme.greenColor,
          actionCallbacks: {
            'EDIT': () => Navigator.of(context).pop(),
            'OK': () async {
              final formattedPhoneNumber =
                  '+${state.phoneCode.trim()} ${phoneNumberController.text.trim()}';
              final phone = Phone(
                code: '+${state.phoneCode.trim()}',
                number: ref
                    .read(loginControllerProvider.notifier)
                    .phoneNumberController
                    .text
                    .replaceAll(' ', '')
                    .replaceAll('-', '')
                    .replaceAll('(', '')
                    .replaceAll(')', ''),
                formattedNumber: formattedPhoneNumber,
              );
            },
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You entered the phone number:',
                style: TextStyle(color: colorTheme.greyColor, fontSize: 16),
              ),
              const SizedBox(height: 16.0),
              Text(
                phoneNumberWithCode,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorTheme.greyColor,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Is this OK, or would you like to edit '
                'the number?',
                style: TextStyle(
                  color: colorTheme.greyColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onPhoneCodeChanged(String value) async {
    Country country;
    if (value.isEmpty) {
      country = Country(
        phoneCode: '',
        countryCode: '',
        e164Sc: -1,
        geographic: false,
        level: -1,
        name: 'No such country',
        example: '',
        displayName: 'No such country',
        fullExampleWithPlusSign: '',
        displayNameNoCountryCode: 'No such country',
        e164Key: '',
      );
    } else {
      List results = countriesList
          .where(
            (country) => country.phoneCode == value,
          )
          .toList();

      if (results.isEmpty) {
        country = Country(
          phoneCode: value,
          countryCode: '',
          e164Sc: -1,
          geographic: false,
          level: -1,
          name: 'No such country',
          example: '',
          displayName: 'No such country',
          fullExampleWithPlusSign: '',
          displayNameNoCountryCode: 'No such country',
          e164Key: '',
        );
      } else {
        country = results[0];
      }
    }

    updateSelectedCountry(country);
  }

  void showCountryPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const CountryPage()),
      ),
    );
  }

  Future<void> updateSelectedCountry(
    Country country, [
    bool editPhoneCode = false,
  ]) async {
    if (state == country) return;

    await _formatPhoneNumber(country.countryCode);
    state = country;

    if (editPhoneCode) _updatePhoneCode(country.phoneCode);
  }

  Future<void> _formatPhoneNumber(String countryCode) async {
    final formattedPhoneNumber = await PhoneNumberUtil().format(
        phoneNumberController.text
            .replaceAll('-', '')
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll(' ', ''),
        countryCode);

    phoneNumberController.dispose();
    phoneNumberController = PhoneNumberEditingController(
      PhoneNumberUtil(),
      text: formattedPhoneNumber,
      regionCode: countryCode,
      behavior: PhoneInputBehavior.strict,
    );
  }

  void _updatePhoneCode(String phoneCode) {
    phoneCodeController.text = phoneCode;
  }
}
