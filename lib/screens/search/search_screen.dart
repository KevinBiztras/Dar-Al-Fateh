import 'dart:async';
import 'dart:io';
/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul
    o
 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/models/SearchScreenModel.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_bloc.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_events.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_state.dart';
import 'package:flutter_project_structure/screens/search/views/bar_code_scanner_file.dart';
import 'package:flutter_project_structure/screens/search/views/search_suggestion.dart';
import 'package:flutter_project_structure/utils/helper.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../../constants/arguments_map.dart';
import '../../constants/route_constant.dart';
import '../../customWidgtes/dialog_helper.dart';
import '../../models/HomeScreenModel.dart';
import '../recentSearch/recent_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isFromPagination = false;
  bool isFirst = true;
  SearchScreenModel? searchModel;
  TextEditingController textEditingController = TextEditingController();
  SearchScreenBloc? searchScreenBloc;
  List<Products> products = [];
  AppLocalizations? _localizations;
  SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String transcription = '';
  String selectedLang = "en_US";
  int offset = 0;
  String barcodeResult = '';
  Timer? _debounce;
  List<String> recentSearch = [];

  @override
  void initState() {
    selectedLang = AppSharedPref().getAppLanguage() ?? 'en_US';
    searchScreenBloc = context.read<SearchScreenBloc>();
    searchScreenBloc?.add(InitialSearchSuggestionEvent());
    recentSearch = AppSharedPref().getRecentSearches();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  void activateSpeechRecognizer() async {
    await _speechToText.initialize();
    await _speechToText.listen(onResult: _onSpeechResult);
    _isListening = true;
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    activateSpeechRecognizer();
    await _speechToText.listen(onResult: _onSpeechResult);
    _isListening = true;
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    _isListening = false;
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      transcription = result.recognizedWords;
      textEditingController.text = transcription;
      searchScreenBloc?.add(SearchSuggestionEvent(transcription, offset));
      _stopListening();
    });
  }

  void errorHandler() => activateSpeechRecognizer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenBloc, SearchState>(
      builder: (context, currentState) {
        print(currentState);
        if (currentState is SearchInitialState) {
          if (!isFirst) {
            isLoading = true;
          }
          isFirst = false;
        } else if (currentState is SearchScreenSuccess) {
          isLoading = false;
          searchModel = currentState.searchSuggestionModel;
          if (offset == 0) {
            products = searchModel?.products ?? [];
          } else {
            products.addAll(searchModel?.products ?? []);
          }
          isLoading = false;
          isFromPagination = false;
          AppSharedPref().setWishlistData(searchModel!.wishlist);
        } else if (currentState is BarCodeScannerSuccess) {
          searchModel = currentState.searchSuggestionModel;
          products = searchModel?.products ?? [];
          isLoading = false;
          isFromPagination = false;
          if ((searchModel?.products?.isNotEmpty ?? false) &&
              (searchModel?.products?.length ?? 0) > 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(
                context,
                productPage,
                arguments: getProductDataMap(
                  searchModel?.products?[0].name ?? "",
                  (searchModel?.products?[0].templateId ?? "").toString(),
                ),
              );
            });
          }
        } else if (currentState is SearchScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message, context);
          });
        }
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).cardColor,
        leading: IconButton(
          onPressed: () {
            Helper.hideSoftKeyBoard();
            Navigator.of(context).pop();
          },
          icon: Semantics(
            identifier: 'back_icon',
            child: const Icon(Icons.arrow_back),
          ),
        ),
        titleSpacing: 0,
        title: SizedBox(
          height: 40,
          //AppSizes.widgetBorderRadius,
          child: TextField(
            readOnly: _isListening,
            controller: textEditingController,
            onChanged: (searchKey) {
              print("Search key ---> $searchKey");
              offset = 0;
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                if (searchKey.isNotEmpty) {
                  searchScreenBloc?.add(
                    SearchSuggestionEvent(searchKey, offset),
                  );
                }
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
              ),
              contentPadding: const EdgeInsets.only(
                top: 0,
                left: AppSizes.normalPadding,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGray),
              ),
              //border: InputBorder.none,
              hintText:
                  _localizations?.translate(AppStringConstant.productSearch) ??
                  '',
              hintStyle: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.normal),
            ),
            //style: TextStyle(height: 3),
            style: Theme.of(context).textTheme.titleSmall,
            cursorColor: Theme.of(context).textTheme.titleSmall?.color,
          ),
        ),
        actions: [
          (_isListening)
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    _localizations?.translate(AppStringConstant.listening) ??
                        '',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              : IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  constraints: BoxConstraints(),
                  onPressed: () {
                    DialogHelper.searchDialog(
                      context,
                      _localizations,
                      () {
                        startImageRecognition(searchImage);
                      },
                      () {
                        startImageRecognition(searchText);
                      },
                    );
                  },
                  icon: const Icon(Icons.camera_alt, size: 24),
                ),
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MobileScannerSimple()),
              ).then((value) {
                if (value != null && value.isNotEmpty) {
                  textEditingController.text = value;
                  searchScreenBloc?.add(BarCodeScannerEvent(value, offset));
                }
              });
            },
            icon: Icon(
              Icons.qr_code_scanner,
              size: 24,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            ),
          ),
          textEditingController.text.isNotEmpty
              ? IconButton(
                  padding: const EdgeInsets.only(right: 12),
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Helper.hideSoftKeyBoard();
                    textEditingController.text = "";
                    searchModel = null;
                    products = [];
                    offset = 0;
                    searchScreenBloc?.add(InitialSearchSuggestionEvent());
                  },
                  icon: const Icon(Icons.close, size: 24),
                )
              : IconButton(
                  padding: const EdgeInsets.only(right: 12),
                  constraints: BoxConstraints(),
                  onPressed:
                      // If not yet listening for speech start, otherwise stop
                      _speechToText.isNotListening
                      ? _startListening
                      : _stopListening,
                  icon: Icon(
                    (_isListening) ? Icons.mic_off : Icons.mic,
                    size: 24,
                  ),
                ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: isLoading,
            child: const LinearProgressIndicator(
              backgroundColor: MobikulTheme.clientAccentColor,
              valueColor: AlwaysStoppedAnimation(AppColors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
            child: RecentSearch(
              onItemSelected: (selectedSearchItem) {
                textEditingController.text = selectedSearchItem;
              },
              recentSearch: recentSearch,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController
                    ..addListener(() {
                      paginationFunction();
                    }),
                  child: Column(
                    children: [
                      Visibility(
                        visible: (products.isNotEmpty),
                        child: suggestionList(
                          products,
                          context,
                          _localizations,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:
                      (!isLoading) &&
                      !(searchModel?.products?.isNotEmpty ?? false),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.imageRadius),
                    child: Center(
                      child: Text(
                        _localizations?.translate(AppStringConstant.noResult) ??
                            '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String searchImage = "imageSearch";
  String searchText = "textSearch";
  var methodChannel = const MethodChannel(AppConstant.channelName);

  Future<String> startImageRecognition(String type) async {
    try {
      String data = "";
      if (Platform.isAndroid) {
        data = await methodChannel.invokeMethod(type);
      } else if (Platform.isIOS) {
        data = await methodChannel.invokeMethod("mlKit", type);
      }
      Navigator.pop(context);
      textEditingController.text = data;
      searchScreenBloc?.add(SearchSuggestionEvent(data, offset));
      searchScreenBloc?.emit(SearchInitialState());
      return data;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  //--------------------Handle load more----------------------//
  void paginationFunction() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (searchModel?.tcount ?? 0) != products.length) {
      // setState(() {
      if (searchModel?.offset == offset &&
          (offset + 10) < (searchModel?.tcount ?? 0)) {
        offset += 10;
        print("checking${offset}");
        searchScreenBloc?.add(
          SearchSuggestionEvent(textEditingController.text, offset),
        );
        isFromPagination = true;
      }
      // });
    }
  }
}
