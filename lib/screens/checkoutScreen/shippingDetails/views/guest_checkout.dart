import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/app_string_constant.dart';
import '../../../../constants/route_constant.dart';
import '../../../../customWidgtes/common_order_button.dart';
import '../../../../customWidgtes/common_text_field.dart';
import '../../../../customWidgtes/common_tool_bar.dart';
import '../../../../customWidgtes/dialog_helper.dart';
import '../../../../helper/alert_message.dart';
import '../../../../helper/app_localizations.dart';
import '../../../../helper/loader.dart';
import '../../../../models/CartViewModel.dart';
import '../../../../models/CountryListModel.dart';
import '../../../addEditAddress/bloc/add_edit_address_screen_bloc.dart';
import '../../../addEditAddress/bloc/add_edit_address_screen_event.dart';
import '../../../addEditAddress/bloc/add_edit_address_state.dart';
import '../../../addEditAddress/views/country_state_dropdown.dart';
import 'package:location/location.dart' as location_req;

class GuestCheckoutScreen extends StatefulWidget {
  final CartViewModel? cartViewModel;

  const GuestCheckoutScreen({Key? key, this.cartViewModel}) : super(key: key);

  @override
  State<GuestCheckoutScreen> createState() => _GuestCheckoutScreenState();
}

class _GuestCheckoutScreenState extends State<GuestCheckoutScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  bool initialLoading = true;
  AddEditAddressScreenBloc? addressScreenBloc;
  CountryListModel? _countryListModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  int? selectedCountryId;
  int? selectedStateId;
  bool hasState = false;
  bool isFromMap = false;
  late GlobalKey<FormState> _formKey;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  void initState() {
    super.initState();
    addressScreenBloc = context.read<AddEditAddressScreenBloc>();
    addressScreenBloc?.add(const AddEditAddressDataFetchEvent());
    _formKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonToolBar(
          _localizations?.translate(AppStringConstant.addAddress) ?? "",
          context),
      bottomSheet: commonOrderButton(context, _localizations,
          widget.cartViewModel?.grandtotal?.value.toString() ?? "", () {
            if (_formKey.currentState?.validate() == true) {
              addressScreenBloc?.emit(AddEditAddressInitial());
              addressScreenBloc?.add(GuestAddAddressEvent(
                nameController.text,
                telephoneController.text,
                streetController.text,
                cityController.text,
                zipController.text,
                selectedCountryId.toString(),
                selectedStateId.toString(),
                emailController.text,
              ));
            }
      }, color: Theme.of(context).colorScheme.onPrimary),
      body: BlocBuilder<AddEditAddressScreenBloc, AddEditAddressState>(
        builder: (context, state) {
          if (state is AddEditAddressInitial) {
            isLoading = true;
          } else if (state is AddEditAddressCountrySuccess) {
            initialLoading = false;
            isLoading = false;
            _countryListModel = state.model;
          } else if (state is GuestAddAddressSuccess) {
            isLoading = false;
            if (state.model.success == true) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AlertMessage.showSuccess(state.model.message ?? '', context);
                Navigator.of(context).pushReplacementNamed(
                    checkoutPage,
                    arguments: widget.cartViewModel?.grandtotal?.value);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AlertMessage.showError(state.model.message ?? '', context);
              });
            }
          }
          return buildUI();
        },
      ),
    );
  }

  Widget buildUI() {
    return initialLoading
        ? Loader()
        : Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.imageRadius),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            headingText(_localizations?.translate(
                                    AppStringConstant.contactInformation) ??
                                ""),
                            InkWell(
                              onTap: onTapLocation,
                              child: Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                                child: Icon(
                                  Icons.my_location,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                ),
                              ),
                            )
                          ],
                        ),
                        createTextField(
                            _localizations
                                    ?.translate(AppStringConstant.yourName) ??
                                "",
                            nameController),
                        createTextField(
                            _localizations
                                    ?.translate(AppStringConstant.email) ??
                                "",
                            emailController),
                        createTextField(
                            _localizations
                                    ?.translate(AppStringConstant.telephone) ??
                                "",
                            telephoneController,
                            inputType: TextInputType.phone),
                        headingText(_localizations
                                ?.translate(AppStringConstant.address) ??
                            ""),

                        createTextField(
                            _localizations?.translate(
                                    AppStringConstant.streetAddress) ??
                                "",
                            streetController),
                        createTextField(
                            _localizations?.translate(AppStringConstant.city) ??
                                "",
                            cityController),
                        createTextField(
                            _localizations
                                    ?.translate(AppStringConstant.zipCode) ??
                                "",
                            zipController),
                        const SizedBox(
                          height: AppSizes.sidePadding,
                        ),
                        CountryDropdown(
                            _countryListModel?.countries ?? [],
                            selectedCountryId,
                            selectedStateId,
                            countryStateCallback),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 5.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading) Loader()
            ],
          );
  }

  Widget headingText(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.sidePadding,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: AppSizes.linePadding,
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  void countryStateCallback(int? countryId, int? stateId, bool hasStates) {
    selectedStateId = stateId;
    selectedCountryId = countryId;
    hasState = hasState;
  }

  Widget createTextField(String hintText, TextEditingController controller,
      {inputType = TextInputType.text,bool isRequired = true}) {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.sidePadding),
      child: CommonTextField(
        hintText: hintText,
        isRequired: isRequired,
        isDense: false,
        controller: controller,
        isPassword: false,
        inputType: inputType,
      ),
    );
  }

  //======This will use to filter data from current location========//
  void filterSelectedCountryState(String? country, String? state) {
    if (_countryListModel?.countries != null) {
      for (Countries cou in _countryListModel?.countries ?? []) {
        if (cou.name?.toLowerCase() == country?.toLowerCase()) {
          selectedCountryId = cou.id;
          if ((cou.states ?? []).isNotEmpty) {
            for (States s in cou.states ?? []) {
              if (s.name?.toLowerCase() == state?.toLowerCase()) {
                setState(() {
                  selectedStateId = s.id;
                });
                break;
              } else {
                setState(() {});
              }
            }
            if (selectedStateId == null) {
              setState(() {});
            }
          }
          break;
        }
      }
    }
  }

  void onTapLocation() async {
    var status = await location_req.Location.instance.hasPermission();
    if (status == location_req.PermissionStatus.granted ||
        status == location_req.PermissionStatus.grantedLimited) {
      Navigator.pushNamed(context, location).then((value) {
        if (value is Map) {
          filterSelectedCountryState(value["country"], value["state"]);
          cityController.text = value['city'] ?? '';
          zipController.text = value['zip'] ?? '';
          streetController.text = value['street1'] ?? '';
          if ((value["street3"] != null) && value["street3"] != '') {
            streetController.text += " " + value["street3"];
          }

          isFromMap = true;
        }
      });
    } else {
      DialogHelper.locationPermissionDialog(
          AppStringConstant.requiredLocationPermission, context, _localizations,
          onConfirm: () async {
        var status = await location_req.Location.instance.requestPermission();
        if (status == location_req.PermissionStatus.deniedForever) {
          DialogHelper.locationPermissionDialog(
              AppStringConstant.provideLocationPermission,
              context,
              _localizations, onConfirm: () async {
            openAppSettings();
          });
        } else {
          onTapLocation();
        }
      });
    }
  }

}
